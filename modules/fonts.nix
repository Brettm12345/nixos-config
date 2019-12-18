{ config, lib, pkgs, ... }:
with import ../support.nix { inherit lib config pkgs; };
with lib;
let
  font = (name:
    (mkOption {
      description = "${name} font";
      type = types.str;
    }));

in {
  options.themes.fonts = mkOption {
    description =
      "Set of fonts from withch themes for various applications will be generated";
    type = with types;
      submodule {
        options = {
          sansSerif = font "sansSerif";
          serif = font "serif";
          monospace = font "monospace";
        };
      };
  };
  config.themes.fonts = {
    sansSerif = "Proxima Nova Cond Semibold";
    serif = "Noto Serif";
    monospace = "Operator Mono SSm Lig 11";
  };
}
