{ pkgs, config, ... }:
let
  gtkTheme = "Juno";
  fnt = config.themes.fonts;
in {
  nixpkgs.overlays = [
    (self: super: {
      juno = self.stdenv.mkDerivation rec {
        name = gtkTheme;
        src = pkgs.imports.juno;
        propagatedUserEnvPkgs = [ pkgs.gtk-engine-murrine ];
        sourceRoot = ".";
        installPhase = ''
          mkdir -p $out/share/themes/Juno
          cp -a ./source/* $out/share/themes/Juno
        '';
      };
    })
  ];
  home-manager.users.brett = {
    home.packages = with pkgs; [
      juno
      gnome3.adwaita-icon-theme
      papirus-icon-theme
    ];
    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      theme = {
        name = gtkTheme;
        package = pkgs.juno;
      };
      font.name = fnt.sansSerif;
    };
  };
}
