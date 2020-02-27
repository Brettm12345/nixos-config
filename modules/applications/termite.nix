{ config, lib, ... }:
with lib;
with config.themes; {
  home-manager.users.brett = {
    gtk.gtk3.extraCss = let padding = "10px";
    in ''
      VteTerminal, vte-terminal {
        -vteterminal-inner-border: ${padding};
      }
      .termite {
        padding: ${padding};
      }
    '';
    programs.termite = with colors;
      with fonts; {
        allowBold = false;
        audibleBell = false;
        backgroundColor = background;
        browser = config.defaultApplications.browser.cmd;
        clickableUrl = true;
        colorsExtra = ''
          color0 = ${grayscale.base3}
          color1 = ${normal.red}
          color2 = ${normal.green}
          color3 = ${normal.yellow}
          color4 = ${normal.blue}
          color5 = ${normal.magenta}
          color6 = ${normal.cyan}
          color7 = ${normal.white}
          color8 = ${grayscale.base6}
          color9 = ${bright.red}
          color10 = ${bright.green}
          color11 = ${bright.yellow}
          color12 = ${bright.blue}
          color13 = ${bright.magenta}
          color14 = ${bright.cyan}
          color15 = ${bright.white}
        '';
        cursorBlink = "on";
        cursorColor = normal.blue;
        cursorShape = "ibeam";
        dynamicTitle = true;
        enable = true;
        filterUnmatchedUrls = true;
        font = "${monospace} 12";
        foregroundBoldColor = bright.white;
        foregroundColor = foreground;
        fullscreen = true;
        highlightColor = grayscale.base3;
        iconName = "terminal";
        modifyOtherKeys = true;
        mouseAutohide = true;
        optionsExtra = ''
          bold_is_bright = false
          cell_height_scale = 1.1
          hyperlinks = true
        '';
        scrollOnKeystroke = true;
        scrollOnOutput = false;
        scrollbackLines = 10000;
        scrollbar = "off";
        searchWrap = true;
        sizeHints = true;
        urgentOnBell = true;
      };
  };
}
