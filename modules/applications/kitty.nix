{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ kitty ];
  home-manager.users.brett = {
    xdg.configFile."kitty/kitty.conf".text = with config.themes.colors;
      with config.themes.fonts; ''
        font_family ${monospace-alt}
        bold_font ${monospace-alt}
        italic_font ${monospace-alt}
        bold_italic_font ${monospace-alt}

        open_url_with ${pkgs.chromium}/bin/chromium

        input_delay 2
        sync_to_monitor yes

        window_padding_width 10.0

        font_size 12
        adjust_line_height  120%
        placement_strategy center
        cursor ${normal.blue}
        foreground ${foreground}
        background ${background}
        selection_background ${grayscale.base4}
        color0 ${grayscale.base3}
        color1 ${normal.red}
        color2 ${normal.green}
        color3 ${normal.yellow}
        color4 ${normal.blue}
        color5 ${normal.magenta}
        color6 ${normal.cyan}
        color7 ${normal.white}
        color8 ${grayscale.base6}
        color9 ${bright.red}
        color10 ${bright.green}
        color11 ${bright.yellow}
        color12 ${bright.blue}
        color13 ${bright.magenta}
        color14 ${bright.cyan}
        color15 ${bright.white}
      '';
  };
}
