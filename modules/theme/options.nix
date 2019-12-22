{ config, lib, pkgs, ... }:
with import ../../support.nix { inherit lib config pkgs; };
with lib;
with types;
let
  font = (name:
    (mkOption {
      description = "${name} font";
      type = str;
    }));
  color = (name:
    (mkOption {
      description = "${name} color of palette";
      type = str;
    }));
  colorList = (name:
    (mkOption {
      description = "A ${name} list of colors";
      type = with types;
        submodule {
          options = {
            black = color "black";
            red = color "red";
            green = color "green";
            yellow = color "yellow";
            blue = color "blue";
            magenta = color "magenta";
            cyan = color "cyan";
            white = color "white";
          };
        };
    }));
in {
  colors = mkOption {
    description = "A set of colors";
    type = submodule {
      options = {
        background = color "background";
        foreground = color "foreground";
        alt = color "alt";
        base0 = color "base0";
        base1 = color "base1";
        base2 = color "base2";
        base3 = color "base3";
        base4 = color "base4";
        base5 = color "base5";
        base6 = color "base6";
        base7 = color "base7";
        base8 = color "base8";
        normal = colorList "normal";
        bright = colorList "bright";
      };
    };
  };
  fonts = mkOption {
    description =
      "Set of fonts from withch themes for various applications will be generated";
    type = submodule {
      options = {
        sansSerif = font "sansSerif";
        serif = font "serif";
        monospace = font "monospace";
      };
    };
  };
  icons = mkOption {
    description = "An icon theme";
    type = submodule {
      options = {
        package = mkOption {
          type = package;
          example = literalExample "pkgs.gnome3.adwaita-icon-theme";
          description = "Package providing the theme.";
        };
        name = mkOption {
          type = str;
          example = "Adwaita";
          description = "The name of the theme within the package.";
        };
      };
    };
  };
}
