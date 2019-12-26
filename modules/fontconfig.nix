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
      ultimate = {
        enable = true;
        preset = "ultimate5";
      };
      dpi = 110;
      defaultFonts = with config.themes.fonts; {
        monospace = [ monospace "Roboto Mono 13" ];
        sansSerif = [ sansSerif "Roboto 13" ];
        serif = [ serif "Roboto Slab 13" ];
      };
    };
  };
}