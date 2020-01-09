{ config, lib, pkgs, ... }:
with import ../../support.nix { inherit lib config pkgs; };
with lib;
with types;
let
  o = type: description: mkOption { inherit type description; };
  mkStr = name: description: o str "${name} ${description}";
  mkSubmodule = description: options:
    mkOption {
      inherit description;
      type = submodule { inherit options; };
    };
  defaultColors =
    [ "black" "red" "green" "yellow" "blue" "magenta" "cyan" "white" ];
  color = mkStr "color of palette";
  font = mkStr "font";
  colorList = name:
    mkSubmodule "A ${name} list of colors" (mergeWith color defaultColors);
  base = i: "base${toString i}";
  base8 = let f = x: i: c: nameValuePair (base (x + i)) (color c);
  in x: listToAttrs (imap0 (f x) defaultColors);
in mapAttrs (_:
  { description, options }:
  mkOption {
    inherit description;
    type = submodule { inherit options; };
  }) {
    colors = {
      description = "A set of colors";
      options = mergeWith color [ "background" "foreground" ] // {
        grayscale = mkSubmodule "Grayscale color scale"
          ((base8 0) // { alt = color "alt"; });
        base16 = mkSubmodule "A base16 color scale" ((base8 0) // (base8 9));
        normal = colorList "normal";
        bright = colorList "bright";
      };
    };
    fonts = {
      description =
        "Set of fonts from withch themes for various applications will be generated";
      options =
        mergeWith font [ "sansSerif" "serif" "monospace" "monospace-alt" ];
    };
    icons = {
      description = "An icon theme";
      options = mapAttrs (_: mkOption) {
        package = {
          type = package;
          example = literalExample "pkgs.gnome3.adwaita-icon-theme";
          description = "Package providing the theme.";
        };
        name = {
          type = str;
          example = "Adwaita";
          description = "The name of the theme within the package.";
        };
      };
    };
  }
