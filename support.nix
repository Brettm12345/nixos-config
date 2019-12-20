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
    (map (key: {
      name = key;
      value = getAttr key x;
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
  thm = config.themes.colors;
  thmDec = lib.mapAttrsRecursive (name: color: hex2dec color) thm;
}
