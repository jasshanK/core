{ pkgs, ... }:

let
  # Jan agent TUI/CLI, packaged from the prebuilt nightly release.
  # To bump: curl -s https://apps-nightly.jan.ai/agent/update-check
  # and copy the linux-x86_64 version + sha256.
  jan-unwrapped = pkgs.stdenv.mkDerivation rec {
    pname = "jan-agent";
    version = "0.8.6-63";

    src = pkgs.fetchurl {
      url = "https://delta.jan.ai/agent-nightly/jan-agent-linux-x86_64-${version}.tar.gz";
      sha256 = "0224875f6623311632f4d39947552f618089077b44780a816d57e3a762d7bd56";
    };

    sourceRoot = ".";

    nativeBuildInputs = [ pkgs.autoPatchelfHook ];
    buildInputs = [ pkgs.openssl pkgs.stdenv.cc.cc.lib ];

    installPhase = ''
      runHook preInstall
      install -Dm755 jan $out/bin/jan
      runHook postInstall
    '';

    meta = {
      description = "Jan agent console (TUI) and CLI";
      homepage = "https://jan.ai";
      mainProgram = "jan";
      platforms = [ "x86_64-linux" ];
    };
  };

  # Wrapper that shows Jan in herdr as a running agent named "jan".
  # Jan has no lifecycle hooks, so the state is a static "idle" while it
  # runs. The thread Jan is writing to is reported as the resume command
  # (`jan --resume <id>`) so herdr can reopen it after a server restart.
  jan = pkgs.writeShellApplication {
    name = "jan";
    runtimeInputs = [ pkgs.coreutils pkgs.findutils pkgs.gnugrep ];
    text = ''
      real=${jan-unwrapped}/bin/jan

      # Nix manages updates; disable the self-update check and `jan update`.
      export JAN_CLI_NO_UPDATE_CHECK=1

      # Only the bare TUI is an interactive agent. Subcommands, --help and
      # --version run straight through, as does everything outside herdr.
      tui=1
      case "''${1:-}" in
        cli|login|auth|usage|config|plugin|mcp|update|help) tui=0 ;;
      esac
      for arg in "$@"; do
        case "$arg" in -h|--help|-V|--version) tui=0 ;; esac
      done

      if [ "$tui" != 1 ] || [ "''${HERDR_ENV:-}" != "1" ] \
        || [ -z "''${HERDR_PANE_ID:-}" ] || [ -z "''${HERDR_BIN_PATH:-}" ]; then
        exec "$real" "$@"
      fi

      herdr_pane() {
        timeout 5 "$HERDR_BIN_PATH" pane "$@" >/dev/null 2>&1 || true
      }

      # Jan keys its thread store on the project root (--project, default .):
      # ~/.jan/projects/<slug>/{project.json,threads/<id>/thread.json}.
      project="."
      prev=""
      for arg in "$@"; do
        if [ "$prev" = "--project" ]; then project="$arg"; fi
        case "$arg" in --project=*) project="''${arg#--project=}" ;; esac
        prev="$arg"
      done
      project_root="$(realpath -- "$project" 2>/dev/null || printf '%s' "$project")"

      marker="$(mktemp "''${TMPDIR:-/tmp}/herdr-jan.XXXXXX")"
      touch -d "-2 seconds" "$marker"

      watch() {
        # Give Jan a moment to take the foreground, then claim the pane.
        sleep 1
        herdr_pane report-agent "$HERDR_PANE_ID" --source jan --agent jan \
          --state idle --seq "$(date +%s%N)"

        reported=""
        while sleep 3; do
          dirs=()
          while IFS= read -r meta; do
            dirs+=("$(dirname "$meta")/threads")
          done < <(grep -lsF "\"path\": \"$project_root\"" "$HOME"/.jan/projects/*/project.json || true)
          [ "''${#dirs[@]}" -gt 0 ] || continue
          # The thread Jan most recently wrote to since this launch.
          id="$(find "''${dirs[@]}" -mindepth 2 -maxdepth 2 -name thread.json \
                  -newer "$marker" -printf '%T@ %h\n' 2>/dev/null \
                | sort -rn | head -n1 | cut -d' ' -f2- || true)"
          id="''${id##*/}"
          if [ -n "$id" ] && [ "$id" != "$reported" ]; then
            herdr_pane report-agent-session "$HERDR_PANE_ID" --source jan --agent jan \
              --seq "$(date +%s%N)" --agent-session-id "$id" -- jan --resume "$id"
            reported="$id"
          fi
        done
      }

      watch &
      watcher=$!

      # shellcheck disable=SC2329  # invoked via trap
      cleanup() {
        kill "$watcher" 2>/dev/null || true
        rm -f "$marker"
        herdr_pane release-agent "$HERDR_PANE_ID" --source jan --agent jan \
          --seq "$(date +%s%N)"
      }
      trap cleanup EXIT

      status=0
      "$real" "$@" || status=$?
      exit "$status"
    '';
  };
in
{
  home.packages = [ jan ];
}
