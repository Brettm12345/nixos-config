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
}
