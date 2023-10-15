{ config, lib, nixpkgs, ... }:
{
  programs.direnv = {
    enable = true;
  };

  environment.interactiveShellInit = ''
    eval "$(starship init bash)"
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

      set-option -g allow-rename off

      bind-key c new-window -c '#{pane_current_path}'
      bind-key '"' split-window -c '#{pane_current_path}'
      bind-key % split-window -h -c '#{pane_current_path}'

      set-option -g history-limit 20000
    '';
  };
}
