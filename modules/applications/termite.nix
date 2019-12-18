{ config, ... }:
let
  thm = config.themes.colors;
  padding = "10px";
in {
  home-manager.users.brett = {
    xdg.configFile."gtk-3.0/gtk.css".text = ''
      VteTerminal,
      vte-terminal {
        -vteterminal-inner-border: ${padding};
      }
      .termite {
        padding: ${padding};
      }
    '';
    programs.termite = {
      enable = true;
      allowBold = false;
      audibleBell = false;
      clickableUrl = true;
      cursorBlink = "on";
      cursorShape = "ibeam";
      dynamicTitle = true;
      filterUnmatchedUrls = true;
      font = "Operator Mono Lig 12";
      iconName = "terminal";
      modifyOtherKeys = true;
      mouseAutohide = true;
      scrollOnKeystroke = true;
      scrollOnOutput = false;
      scrollbackLines = 10000;
      scrollbar = "off";
      searchWrap = true;
      sizeHints = true;
      urgentOnBell = true;
      highlightColor = thm.bright.black;
      backgroundColor = thm.bg;
      foregroundColor = thm.fg;
      optionsExtra = ''
        bold_is_bright = false
        cell_height_scale = 1.1
        hyperlinks = true
      '';
      colorsExtra = ((with thm.normal; ''
        color0 = ${black}
        color1 = ${red}
        color2 = ${green}
        color3 = ${yellow}
        color4 = ${blue}
        color5 = ${magenta}
        color6 = ${cyan}
        color7 = ${white}
      '') + (with thm.bright; ''
        color8 = ${black}
        color9 = ${red}
        color10 = ${green}
        color11 = ${yellow}
        color12 = ${blue}
        color13 = ${magenta}
        color14 = ${cyan}
        color15 = ${white}
      ''));
    };
  };

}
