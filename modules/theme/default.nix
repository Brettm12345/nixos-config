{ config, pkgs, lib, ... }:
let
  colors = import ./colors.nix;
  fonts = import ./fonts.nix;
  icons = import ./icons.nix { inherit pkgs; };
in {
  options.themes = import ./options.nix { inherit config lib pkgs; };
  config.themes = { inherit colors fonts icons; };
}
