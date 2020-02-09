{ config, pkgs, lib, ... }:
with lib;
let
  colors = [ "black" "red" "green" "yellow" "blue" "magenta" "cyan" "white" ];
  lighten = import ./lighten.nix { inherit pkgs; };
  bases = color:
    mapAttrs (_: base: lighten base color) {
      alt = -1.5e-2;
      base0 = -6.0e-2;
      base1 = -4.0e-2;
      base2 = -2.0e-2;
      base3 = 4.0e-2;
      base4 = 6.0e-2;
      base5 = 0.12;
      base6 = 0.42;
      base7 = 0.52;
    };
  basePair = i: nameValuePair "color${toString i}";
  transformColors = theme:
    with theme; rec {
      inherit background foreground;
      grayscale = bases background;
      normal = getAttrs colors theme;
      bright = mapAttrs (_: lighten 1.9e-2) normal;
      base16 = listToAttrs
        (imap0 basePair ((attrValues normal) ++ (attrValues bright)));
    };
in {
  options.themes = import ./options.nix { inherit config lib pkgs; };
  config.themes = {
    colors = transformColors (import ./colors.nix);
    fonts = import ./fonts.nix;
    icons = import ./icons.nix { inherit pkgs; };
  };
}
