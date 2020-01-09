{ pkgs, config, lib, ... }:
with builtins;
let
  mkKeyValue = key: value:
    let
      mvalue = if isBool value then
        (if value then "true" else "false")
      else if (isString value && key != "include-file") then
        value
      else
        toString value;
    in "${key}=${mvalue}";

  attrsToList = x:
    (map (name: {
      inherit name;
      value = getAttr name x;
    }) (attrNames x));

  concat' = concatStringsSep "\n";

in rec {
  genIni = lib.generators.toINI { inherit mkKeyValue; };
  genIniOrdered = lst:
    (concat' (map ({ name ? "widget", ... }@attrs:
      concat' "\n" ([ "[${name}]" ]
        ++ (map ({ name, value }: mkKeyValue name value)
          (attrsToList (removeAttrs attrs [ "name" ]))))) lst)) + "\n";

  afterLinkGen = data: {
    after = [ "linkGeneration" ];
    before = [ ];
    inherit data;
  };

  hex2dec = import ./hex2dec.nix;
  lighten = import ./lighten.nix { inherit pkgs; };

  thm = config.themes.colors;
  thmLight = lib.mapAttrsRecursive (_: color: lighten "0.19" color) thm;
  thmDec = lib.mapAttrsRecursive (_: color: hex2dec color) thm;
}
