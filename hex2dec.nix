color:
with builtins;
let
  hex2decDigits = rec {
    "0" = 0;
    "1" = 1;
    "2" = 2;
    "3" = 3;
    "4" = 4;
    "5" = 5;
    "6" = 6;
    "7" = 7;
    "8" = 8;
    "9" = 9;
    "a" = 10;
    "b" = 11;
    "c" = 12;
    "d" = 13;
    "e" = 14;
    "f" = 15;
    A = a;
    B = b;
    C = c;
    D = d;
    E = e;
    F = f;
  };

  splitHex = hexStr:
    map (x: elemAt x 0)
    (filter (a: a != "" && a != [ ]) (split "(.{2})" (substring 1 6 hexStr)));

  doubleDigitHexToDec = hex:
    16 * hex2decDigits."${substring 0 1 hex}"
    + hex2decDigits."${substring 1 2 hex}";

in concatStringsSep ","
(map (x: toString (doubleDigitHexToDec x)) (splitHex color))
