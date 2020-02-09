{ pkgs, ... }: {
  console = {
    earlySetup = true;
    font = "Lat2-Terminus16";
    packages = with pkgs; [ terminus_font ];
  };
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "America/New_York";
}
