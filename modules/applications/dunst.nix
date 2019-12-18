{ pkgs, config, lib, ... }:
let thm = config.themes;
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
      } // mapAttrs' (name: value:
        nameValuePair "urgency_${name}" {
          background = background;
          foregorund = foreground;
          timeout = value;
        }) {
          low = 4;
          normal = 6;
          critical = 0;
        };
    };
  };
}
