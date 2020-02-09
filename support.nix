{ config, lib, ... }:
with builtins;
with lib; rec {
  genIni = generators.toINI {
    mkKeyValue = key: value:
      let
        mvalue = if isBool value then
          (if value then "true" else "false")
        else if (isString value && key != "include-file") then
          value
        else
          toString value;
      in "${key}=${mvalue}";
  };
  afterLinkGen = data: {
    after = [ "linkGeneration" ];
    before = [ ];
    inherit data;
  };

  merge = fold (a: b: a // b) { };
  pairWith = f: n: nameValuePair n (f n);
  mergeWith = f: l: listToAttrs (map (pairWith f) l);
}
