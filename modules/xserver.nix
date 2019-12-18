{ pkgs, lib, config, ... }: {
  services.xserver = {
    enable = true;
    enableTCP = true;
    autoRepeatDelay = 300;
    autoRepeatInterval = 50;
    videoDrivers = [ "nvidia" ];
    displayManager.lightdm.enable = true;
    layout = "us";
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
