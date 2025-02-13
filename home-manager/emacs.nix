{ pkgs, ... }:
{
  programs.emacs = {
      enable = true;
      package = pkgs.emacs-gtk;  # replace with pkgs.emacs-gtk, or a version provided by the community overlay if desired.
      extraConfig = ''
        (setq standard-indent 2)
      '';
  };
}
