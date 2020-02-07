{ pkgs }:
yaml:
builtins.fromJSON (builtins.readFile (pkgs.stdenv.mkDerivation {
  name = "fromYAML";
  phases = [ "buildPhase" ];
  buildPhase = "echo '${yaml}' | ${pkgs.yaml2json}/bin/yaml2json > $out";
}))
