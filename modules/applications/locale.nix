{ pkgs, ... }: {
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    packages = with pkgs; [ terminus_font ];
  };
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "America/New_York";
}
