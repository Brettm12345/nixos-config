{ ... }: {
  services.xserver = {
    enable = true;
    enableTCP = true;
    autoRepeatDelay = 300;
    autoRepeatInterval = 55;
    videoDrivers = [ "nvidia" ];
    displayManager.lightdm.enable = true;
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
