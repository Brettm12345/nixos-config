{ config, ... }: {
  programs.kitty = {
    enable = true;
    colorScheme = with config.themes.colors; {
      inherit foreground background;
      selectionBackground = normal.black;
      color = {
        "0" = normal.black;
        "8" = bright.black;
        "1" = normal.red;
        "9" = bright.red;
        "2" = normal.green;
        "10" = bright.green;
        "3" = normal.yellow;
        "11" = bright.yellow;
        "4" = normal.blue;
        "12" = bright.blue;
        "5" = normal.magenta;
        "13" = bright.magenta;
        "6" = normal.cyan;
        "14" = bright.cyan;
        "7" = normal.white;
        "15" = bright.white;
      };
    };
  };
}
