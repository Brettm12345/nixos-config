{ pkgs, lib, config, ... }:
with import ../../../support.nix { inherit lib config pkgs; };
let
  fnt = config.themes.fonts;
  # default = with thmDec; {
  #   BackgroundAlternate = alt;
  #   BackgroundNormal = alt;
  #   DecorationFocus = bright.black;
  #   DecorationHover = normal.black;
  #   ForegroundActive = normal.magenta;
  #   ForegroundInactive = base5;
  #   ForegroundLink = normal.blue;
  #   ForegroundNegative = normal.red;
  #   ForegroundNeutral = normal.blue;
  #   ForegroundNormal = foreground;
  #   ForegroundPositive = normal.green;
  #   ForegroundVisited = normal.magenta;
  # };
in {

  xdg.portal.enable = true;
  services.flatpak.enable = true;
  xdg.portal.extraPortals = [ pkgs.plasma5.xdg-desktop-portal-kde ];
  services.dbus.packages = with pkgs; [
    plasma5.xdg-desktop-portal-kde
    flatpak
    firefox
    systemd
  ];
  services.xserver.desktopManager.plasma5.enable = true;
  nixpkgs.config.firefox.enablePlasmaBrowserIntegration = true;
  environment.systemPackages = (with pkgs;
    [
      plasma-browser-integration
      ktorrent
      qt5.qtsvg
      kded
      plasma-integration
      kinit
    ] ++ (with pkgs.kdeApplications; [
      ark
      dolphin
      dolphin-plugins
      ffmpegthumbs
      gwenview
      kcachegrind
      kcolorchooser
      kdenlive
      kolourpaint
      okular
    ]));
  programs.qt5ct = { enable = true; };
  home-manager.users.brett = {
    xdg.configFile."qt5ct/qt5ct.conf".source = ./qt5ct.conf;
    # xdg.dataFile."color-schemes/Generated.colors".text = with thmDec;
    #   with lib;
    #   genIni mapAttrs'
    #   (scope: values: (nameValuePair "Colors:${scope}" values // default)) {
    #     "Button" = {
    #       BackgroundNormal = base2;
    #       BackgroundAlternate = base2;
    #     };
    #     "Complementary" = { };
    #     "View" = { };
    #     "Selection" = {
    #       BackgroundAlternate = base5;
    #       BackgroundNormal = base5;
    #       ForegroundActive = bright.white;
    #       ForegroundInactive = normal.white;
    #       ForegroundNormal = bright.white;
    #     };
    #     "Tooltip" = {
    #       BackgroundAlternate = base0;
    #       BackgroundNormal = base0;
    #     };
    #     "Window" = {
    #       BackgroundAlternate = background;
    #       BackgroundNormal = background;
    #     };
    #   };
    # xdg.configFile."kdeglobals".text = genIni {
    #   General = with fnt; rec {
    #     ColorScheme = "Generated";
    #     Name = "Generated";
    #     fixed = "${monospace},11,-1,5,50,0,0,0,0,0";
    #     font = "${sansSerif},11,-1,5,50,0,0,0,0,0";
    #     menuFont = font;
    #     shadeSortColumn = true;
    #     smallestReadableFont = "${sansSerif},8,-1,5,57,0,0,0,0,0,Medium";
    #     toolBarFont = "${sansSerif},11,-1,5,50,0,0,0,0,0";
    #   };
    #   Icons = { Theme = "Papirus-Dark"; };
    # };
  };
}
