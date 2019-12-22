{ config, pkgs, lib, ... }:
with lib;
let
  lighten = import ./lighten.nix { inherit pkgs; };
  brighten = _: color: lighten 0.19 color;
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
      base8 = 0.575;
    };

  transformColors = { normal, background, foreground }:
    {
      inherit normal background foreground;
      bright = mapAttrs brighten normal;
    } // bases background;
  colors = transformColors (import ./colors.nix);
  fonts = import ./fonts.nix;
  icons = import ./icons.nix { inherit pkgs; };
in {
  options.themes = import ./options.nix { inherit config lib pkgs; };
  config.themes = { inherit colors fonts icons; };
}
