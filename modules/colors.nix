{ config, lib, pkgs, ... }:
with import ../support.nix { inherit lib config pkgs; };
with lib;
let
  colorType = types.str;
  color = (name:
    (mkOption {
      description = "${name} color of palette";
      type = colorType;
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
  options = {
    themes = {
      colors = mkOption {
        description = "A set of colors";
        type = with types;
          submodule {
            options = {
              bg = color "background";
              fg = color "foreground";
              normal = colorList "normal";
              bright = colorList "bright";
            };
          };
      };
    };
  };
  config = {
    themes.colors = {
      bg = "#212337";
      fg = "#afbeee";
      normal = {
        black = "#2a2e48";
        red = "#ff5370";
        green = "#c7f59b";
        yellow = "#ffdb8e";
        blue = "#70b0ff";
        magenta = "#baacff";
        cyan = "#7fdaff";
        white = "#e4f3fa";
      };
      bright = {
        black = "#4e5579";
        red = "#ff758d";
        green = "#d2f7af";
        yellow = "#ffe2a5";
        blue = "#8dc0ff";
        magenta = "#c8bdff";
        cyan = "#99e1ff";
        white = "#e9f5fb";
      };
    };
  };
}
