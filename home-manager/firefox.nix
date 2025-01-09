{ config, inputs, pkgs, ... }:
let 
  pkgsUnstable = import <nixpkgs-unstable> {
    config.allowUnfree = true;
  };
in
{
  programs.firefox = {
    enable = true;
    profiles.carboncopy = {
      settings = {
        "darkmode" = true;
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "browser.startup.homepage" = "chrome://browser/content/blanktab.html";
        "browser.startup.firstrunSkipsHomepage" = true;
        "browser.toolbars.bookmarks.visibility" = "never";
      };

      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        ublock-origin
        translate-web-pages
      ];

      search = {
        default = "Google";
        engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

          "Google".metaData.alias = "@gg";
        };
        force = true;
        order = [
          "DuckDuckGo"
          "Nix Packages"
          "Google"
        ];
      };

      userChrome = ''

      '';

    }; 
  };
}
