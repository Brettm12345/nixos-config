{ lib }:
color:
with lib;
with builtins;
let
  toPair = i: v: nameValuePair (toString v) i;
  splitHex = hexStr:
    map (x: elemAt x 0)
    (filter (a: a != "" && a != [ ]) (split "(.{2})" (substring 1 6 hexStr)));
  hex2decDigits =
    listToAttrs (imap0 toPair (range 0 9 ++ stringToCharacters "abcdef"));
  doubleDigitHexToDec = hex:
    16 * hex2decDigits."${substring 0 1 hex}"
    + hex2decDigits."${substring 1 2 hex}";
in concatStringsSep ","
(map (x: toString (doubleDigitHexToDec x)) (splitHex (toLower color)))
