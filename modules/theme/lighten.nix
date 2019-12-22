{ pkgs ? import <nixos-unstable> }:
with builtins;
amount: color:
with pkgs;
let
  pastel = c: "${pkgs.pastel}/bin/pastel ${c}";
  build = map pastel [ "color" "lighten ${toString amount}" "format hex" ];
  cmd = lib.concatStringsSep " | " build;
  drv = pkgs.stdenv.mkDerivation {
    name = "lighten";
    phases = [ "buildPhase" ];
    buildPhase = "echo '${color}' | ${cmd} > $out";
  };
in readFile drv
