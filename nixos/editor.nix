{ config, lib, nixpkgs, ... }:
{
  programs.direnv = {
    enable = true;
  };

  programs.fzf = {
      fuzzyCompletion = true;
      keybindings = true;
  };

  environment.interactiveShellInit = ''
    eval "$(starship init bash)"
    if command -v fzf-share >/dev/null; then
      source "$(fzf-share)/key-bindings.bash"
      source "$(fzf-share)/completion.bash"
    fi

    function boom() {
      . /home/jasshank/core/src/scripts/boom.sh $1
    }

    alias noter=". /home/jasshank/core/src/scripts/noter.sh"
  '';

  environment.variables.EDITOR = "nvim";

  programs.tmux = {
    enable = true;
    extraConfig = ''
      unbind C-b
      set-option -g prefix C-e
      bind-key C-e send-prefix

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      set -g mouse on

      set -g base-index 1
      set -g renumber-windows on
      set -g set-clipboard on
      set -wg mode-keys vi

      set-option -g allow-rename off

      bind-key c new-window -c '#{pane_current_path}'
      bind-key '"' split-window -c '#{pane_current_path}'
      bind-key % split-window -h -c '#{pane_current_path}'

      set-option -g history-limit 10000
      set -g status-left-length 300
      set -g repeat-time 700
    '';
  };
}
