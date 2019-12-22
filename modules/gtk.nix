{ config, pkgs, ... }: {
  home-manager.users.brett.gtk = with config.themes; {
    enable = true;
    theme = {
      name = "Juno";
      package = pkgs.juno;
    };
    iconTheme = icons;
    font.name = fonts.sansSerif;
  };
  home-manager.users.brett.xsession.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata Ice";
  };
}
