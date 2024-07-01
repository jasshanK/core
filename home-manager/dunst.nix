{ config, inputs, pkgs, ... }:
{
  services.dunst = {
    enable = true;
    settings = {
        global = {
            follow = "mouse";
            width = 300;
            height = 300;
            offset = "10x30";
            origin = "top-right";
            foreground = "#ffffff";
            background = "#000000";
            frame_color = "#abb2bf";
            frame_width = 2;
            corner_radius = 5;
            history= "mod1+n";
        };
    };
  };
}
