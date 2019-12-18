{ config, pkgs, ... }:
let thm = config.themes.colors;
in {
  home-manager.users.brett = {
    xresources.properties = (with thm; {
      "*background" = bg;
      "*foreground" = fg;
    }) // (with thm.normal; {
      "*color0" = black;
      "*color1" = red;
      "*color2" = green;
      "*color3" = yellow;
      "*color4" = blue;
      "*color5" = magenta;
      "*color6" = cyan;
      "*color7" = white;
    }) // (with thm.bright; {
      "*color8" = black;
      "*color9" = red;
      "*color10" = green;
      "*color11" = yellow;
      "*color12" = blue;
      "*color13" = magenta;
      "*color14" = cyan;
      "*color15" = white;
    });
    home.activation.xrdb = {
      after = [ "linkGeneration" ];
      before = [ ];
      data =
        "DISPLAY=:0 ${pkgs.xorg.xrdb}/bin/xrdb -merge ${config.users.users.brett.home}/.Xresources";
    };
  };
}
