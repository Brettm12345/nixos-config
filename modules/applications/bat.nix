{ pkgs, lib, config, ... }:
with import ../../support.nix { inherit lib config pkgs; };
let
  theme = with builtins;
    with pkgs.imports; rec {
      name = "Material-Theme-Palenight";
      file = "${name}.sublime-theme";
      text = readFile "${material-theme}/${file}";
    };
in {
  home-manager.users.brett = with builtins;
    with pkgs; {
      xdg.configFile."bat/themes/${theme.file}".text = theme.text;
      home.activation.bat = afterLinkGen "${pkgs.bat}/bin/bat cache --build";
      programs.bat = {
        enable = true;
        config.theme = theme.name;
      };
    };
}
