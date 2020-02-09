{ pkgs, ... }: {
  console = {
    earlySetup = true;
    font = "ter-i32b";
    packages = with pkgs; [ terminus_font ];
  };
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "America/New_York";
}
