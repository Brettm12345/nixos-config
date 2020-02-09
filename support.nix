{ config, lib, ... }:
with builtins;
with lib; rec {
  mkIniGen = quote:
    let
      quot = str: if quote then ''"${str}"'' else quote;
      mkKeyValue = key: value:
        let
          mVal = if isBool value then
            (if value then "true" else "false")
          else if (isString value && key != "include-file") then
            quot value
          else
            quot (toString value);
        in "${key}=${toString mVal}";
    in generators.toINI { inherit mkKeyValue; };
  genToml = mkIniGen true;
  genIni = mkIniGen false;
  genIniOrdered = let
    attrsToList = x:
      (map (name: {
        inherit name;
        value = getAttr name x;
      }) (attrNames x));
    concat' = concatStringsSep "\n";
  in lst:
  (concat' (map ({ name ? "widget", ... }@attrs:
    concat' "\n" ([ "[${name}]" ]
      ++ (map ({ name, value }: mkKeyValue name value)
        (attrsToList (removeAttrs attrs [ "name" ]))))) lst)) + "\n";

  afterLinkGen = data: {
    after = [ "linkGeneration" ];
    before = [ ];
    inherit data;
  };

  hex2dec = import ./lib/hex2dec.nix;
  merge = fold (a: b: a // b) { };
  pairWith = f: n: nameValuePair n (f n);
  mergeWith = f: l: listToAttrs (map (pairWith f) l);

  thm = config.themes.colors;
  # thmLight = mapAttrsRecursive (_: lighten "0.19") thm;
  thmDec = lib.mapAttrsRecursive (_: hex2dec) thm;
}
