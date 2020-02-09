{ pkgs, ... }: {
  environment = {
    sessionVariables = {
      # Directory
      FFF_COL1 = "4";
      # Statusbar bg
      FFF_COL2 = "0";
      # Copied/Moved files
      FFF_COL3 = "3";
      # Cursor
      FFF_COL4 = "4";

      # Favorites
      FFF_FAV1 = "~/src/github.com/brettm12345";
      FFF_FAV2 = "~/src/github.com/the-mmm-agency";
    };
    systemPackages = [ pkgs.fff ];
  };
}
