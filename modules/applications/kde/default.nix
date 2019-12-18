{ pkgs, lib, config, ... }:
with import ../../../support.nix { inherit lib config pkgs; }; {
  xdg.portal.enable = true;
  # services.flatpak.enable = true;
  xdg.portal.extraPortals = [ pkgs.plasma5.xdg-desktop-portal-kde ];
  environment.sessionVariables = {
    QT_XFT = "true";
    QT_SELECT = "5";
    KDE_SESSION_VERSION = "5";
    QT_SCALE_FACTOR = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "0";
    GTK_USE_PORTAL = "1";
    QT_QPA_PLATFORMTHEME = "kde";
  };
  services.dbus.packages = with pkgs; [
    plasma5.xdg-desktop-portal-kde
    flatpak
    firefox
    systemd
  ];
  nixpkgs.config.firefox.enablePlasmaBrowserIntegration = true;
  home-manager.users.brett = {
    home.packages = [ pkgs.qt5ct ];
    xdg.configFile."qt5ct/qt5ct.conf".source = ./qt5ct.conf;
    xdg.configFile."kdeglobals".text = genIni {
      "Colors:Button" = {
        BackgroundAlternate = thmDec.bright.black;
        BackgroundNormal = thmDec.background;
        DecorationFocus = thmDec.bright.black;
        DecorationHover = thmDec.bright.black;
        ForegroundActive = thmDec.normal.blue;
        ForegroundInactive = thmDec.normal.black;
        ForegroundLink = thmDec.normal.cyan;
        ForegroundNegative = thmDec.normal.red;
        ForegroundNeutral = thmDec.normal.yellow;
        ForegroundNormal = thmDec.foreground;
        ForegroundPositive = thmDec.normal.green;
        ForegroundVisited = thmDec.bright.magenta;
      };
      "Colors:Complementary" = {
        BackgroundAlternate = thmDec.normal.black;
        BackgroundNormal = thmDec.background;
        DecorationFocus = thmDec.normal.blue;
        DecorationHover = thmDec.normal.blue;
        ForegroundActive = thmDec.normal.yellow;
        ForegroundInactive = thmDec.normal.black;
        ForegroundLink = thmDec.normal.blue;
        ForegroundNegative = thmDec.normal.red;
        ForegroundNeutral = thmDec.normal.yellow;
        ForegroundNormal = thmDec.foreground;
        ForegroundPositive = thmDec.normal.green;
        ForegroundVisited = thmDec.normal.magenta;
      };
      "Colors:Selection" = {
        BackgroundAlternate = thmDec.bright.black;
        BackgroundNormal = thmDec.bright.black;
        DecorationFocus = thmDec.bright.black;
        DecorationHover = thmDec.bright.black;
        ForegroundActive = thmDec.foreground;
        ForegroundInactive = thmDec.foreground;
        ForegroundLink = thmDec.normal.cyan;
        ForegroundNegative = thmDec.normal.red;
        ForegroundNeutral = thmDec.normal.yellow;
        ForegroundNormal = thmDec.foreground;
        ForegroundPositive = thmDec.normal.green;
        ForegroundVisited = thmDec.normal.magenta;
      };
      "Colors:Tooltip" = {
        BackgroundAlternate = thmDec.normal.black;
        BackgroundNormal = thmDec.background;
        DecorationFocus = thmDec.normal.blue;
        DecorationHover = thmDec.normal.blue;
        ForegroundActive = thmDec.normal.blue;
        ForegroundInactive = thmDec.normal.black;
        ForegroundLink = thmDec.normal.blue;
        ForegroundNegative = thmDec.normal.red;
        ForegroundNeutral = thmDec.normal.yellow;
        ForegroundNormal = thmDec.foreground;
        ForegroundPositive = thmDec.normal.green;
        ForegroundVisited = thmDec.bright.magenta;
      };
      "Colors:View" = {
        BackgroundAlternate = thmDec.background;
        BackgroundNormal = thmDec.background;
        DecorationFocus = thmDec.normal.black;
        DecorationHover = thmDec.normal.black;
        ForegroundActive = thmDec.normal.white;
        ForegroundInactive = thmDec.normal.black;
        ForegroundLink = thmDec.normal.cyan;
        ForegroundNegative = thmDec.normal.red;
        ForegroundNeutral = thmDec.normal.yellow;
        ForegroundNormal = thmDec.foreground;
        ForegroundPositive = thmDec.normal.green;
        ForegroundVisited = thmDec.bright.magenta;
      };
      "Colors:Window" = {
        BackgroundAlternate = thmDec.background;
        BackgroundNormal = thmDec.background;
        DecorationFocus = thmDec.normal.blue;
        DecorationHover = thmDec.normal.black;
        ForegroundActive = thmDec.bright.black;
        ForegroundInactive = thmDec.normal.black;
        ForegroundLink = thmDec.normal.blue;
        ForegroundNegative = thmDec.normal.red;
        ForegroundNeutral = thmDec.normal.yellow;
        ForegroundNormal = thmDec.foreground;
        ForegroundPositive = thmDec.normal.green;
        ForegroundVisited = thmDec.bright.magenta;
      };
      General = {
        ColorScheme = "Generated";
        Name = "Generated";
        fixed = "Roboto Mono,11,-1,5,50,0,0,0,0,0";
        font = "Roboto,11,-1,5,50,0,0,0,0,0";
        menuFont = "Roboto,11,-1,5,50,0,0,0,0,0";
        shadeSortColumn = true;
        smallestReadableFont = "Roboto,8,-1,5,57,0,0,0,0,0,Medium";
        toolBarFont = "Roboto,11,-1,5,50,0,0,0,0,0";
      };
      KDE = {
        DoubleClickInterval = 400;
        ShowDeleteCommand = true;
        SingleClick = false;
        StartDragDist = 4;
        StartDragTime = 500;
        WheelScrollLines = 3;
        contrast = 4;
        widgetStyle = "Breeze";
      };
      Icons = { Theme = "Papirus-Dark"; };
    };
  };
}
