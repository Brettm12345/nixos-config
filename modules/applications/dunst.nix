{ pkgs, config, lib, ... }:
let
  thm = config.themes;
  timeouts = {
    low = 8;
    normal = 16;
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
          # [{width}x{height}][+/-{x}+/-{y}]
          geometry = "365x15-21+21";
          transparency = 0;
          dmenu = "${pkgs.rofi}/bin/rofi -dmenu -p dunst";
          font = sansSerif;
          padding = 16;
          history_length = 20;
          horizontal_padding = 16;
          idle_threshold = 120;
          ignore_newline = false;
          indicate_hidden = true;
          max_icon_size = 64;
          icon_position = "right";
          line_height = 0;
          separator_color = thm.colors.grayscale.base1;
          separator_height = 2;
          show_age_threshold = 60;
          word_wrap = true;
          follow = "mouse";
          format = ''
            <b>%s</b>
            %b'';
          markup = "full";
        };
      } // mapAttrs' (name: timeout:
        nameValuePair "urgency_${name}" {
          inherit background foreground timeout;
        }) timeouts;
    };
  };
}
