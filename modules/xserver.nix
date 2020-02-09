{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ sddm-theme-goodnight ];
  # hardware.nvidia.modesetting.enable = true;
  # https://twitter.com/ttuegel/status/997561239659270145
  environment.pathsToLink = [ "/share" ];
  services.xserver = {
    enable = true;
    enableTCP = true;
    autoRepeatDelay = 300;
    autoRepeatInterval = 55;
    videoDrivers = [ "nouveau" ];
    displayManager.lightdm.enable = true;
    # displayManager.sddm = {
    #   enable = true;
    #   theme = "goodnight";
    #   autoLogin = { user = "brett"; };
    # };
    layout = "us";
    libinput = {
      enable = true;
      accelSpeed = "1.5";
    };
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages: [
        haskellPackages.xmonad-contrib
        haskellPackages.xmonad-extras
        haskellPackages.xmonad
      ];
    };
  };
}
