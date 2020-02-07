{ config, pkgs, ... }: {
  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      terminus_font
      opensans-ttf
      roboto
      roboto-mono
      roboto-slab
      nerdfonts
      noto-fonts
      fira
      fira-code
      fira-mono
      noto-fonts-emoji
      hasklig
      material-design-icons
      material-icons
    ];
    fontconfig = {
      enable = true;
      dpi = 110;
      defaultFonts = with config.themes.fonts; {
        monospace = [ monospace ];
        sansSerif = [ sansSerif ];
        serif = [ serif ];
      };
    };
  };
}
