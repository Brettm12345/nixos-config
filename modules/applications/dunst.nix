{ pkgs, config, ... }:
let
  thm = config.themes.colors;
  fnt = config.themes.fonts;

in {
  home-manager.users.brett = {
    services.dunst = {
      enable = true;
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      settings = {
        global = {
          geometry = "1000x50-10+10";
          transparency = 10;
          font = fnt.sansSerif;
          padding = 16;
          horizontal_padding = 16;
          word_wrap = true;
          follow = "mouse";
          format = "<b>%s</b> %b";
          markup = "full";
        };

        urgency_low = {
          background = thm.bg;
          foreground = thm.fg;
          timeout = 4;
        };

        urgency_normal = {
          background = thm.bg;
          foreground = thm.fg;
          timeout = 6;
        };

        urgency_critical = {
          background = thm.bg;
          foreground = thm.bg;
          timeout = 0;
        };
      };
    };
  };
}
