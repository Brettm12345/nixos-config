{ config, lib, ... }:
with lib;
with config.themes;
let
  foldLines = concatStringsSep "\n" foldl';
  padding = "10px";
  mkColors = x: foldLines (i: c: "color${i + x} = ${c}") attrValues;
in {
  home-manager.users.brett = {
    gtk.gtk3.extraCss = ''
      VteTerminal,
      vte-terminal {
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
        colorsExtra = foldLines (i: mkColors i * 8) [ normal bright ];
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
