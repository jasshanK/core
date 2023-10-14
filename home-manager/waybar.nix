{ lib, config, pkgs, ... }: 
{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or  [ ]) ++ [ "-Dexperimental=true" ];
    });
    settings = { 
      mainBar = {
        layer = "top";
        position = "top";
        modules-left = ["wlr/workspaces"];
        modules-center = ["hyprland/window"];
        modules-right = ["battery" "clock"];
        "hyprland/window" = {
          max-length = 50;
        };
        battery = {
          format = "{capacity}% {icon}";
          format-icons = ["" "" "" "" ""];
        };
        clock = {
          format-alt = "{:%a, %d. %b  %H:%M}";
        };
      };
    };
  };
}
