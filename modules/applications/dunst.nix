{ pkgs, config, lib, ... }:
let
  thm = config.themes;
  timeouts = {
    low = 4;
    normal = 6;
    critical = 0;
  };
in with thm.colors;
with thm.fonts;
with lib;
with pkgs;
with builtins; {
  home-manager.users.brett = {
    services.dunst = {
      enable = true;
      iconTheme = {
        name = "Papirus-Dark";
        package = papirus-icon-theme;
      };
      settings = {
        global = {
          geometry = "1000x50-10+10";
          transparency = 10;
          font = sansSerif;
          padding = 16;
          horizontal_padding = 16;
          word_wrap = true;
          follow = "mouse";
          format = "<b>%s</b> %b";
          markup = "full";
        };
      } // mapAttrs' (name: timeout:
        nameValuePair "urgency_${name}" {
          inherit background foreground timeout;
        }) timeouts;
    };
  };
}
