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
        "browser.newtabpage.enabled" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
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
        .urlbar-input-box { 
            text-align: center; 
        }

        #nav-bar {
            margin: 8px; 
        }

        #urlbar:not([focused]) #urlbar-background { 
            opacity: 0 !important;
        }
        
        * {
            font-family: "monospace";
        }
        
        #navigator-toolbox {
            max-height: 0vh;
        
            & * {
                opacity: 0 !important;
            }
        }
        
        #navigator-toolbox:focus-within {
            max-height: 100vh;
            height: auto;

            position: absolute !important;
            z-index: 9999 !important;
            top: 0 !important;
            left: 0 !important;
            width: 100% !important;
        
            & * {
                opacity: 1 !important;
            }
        }
      '';

    }; 
  };
}
