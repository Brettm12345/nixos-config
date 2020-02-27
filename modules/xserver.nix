{ pkgs, config, ... }: {
  environment.pathsToLink = [ "/share" ];
  services.xserver = {
    enable = true;
    enableTCP = true;
    autoRepeatDelay = 300;
    autoRepeatInterval = 55;
    videoDrivers = [ "nouveau" "nv" "nvidia" ];
    displayManager.lightdm.enable = true;
    displayManager.lightdm.greeters.mini = {
      enable = false;
      user = "brett";
      extraConfig = with config.themes.colors.grayscale; ''
        [greeter]
        show-password-label = false
        [greeter-theme]
        password-background-color = ${base0}
        window-color = ${base2}
        background-image = "/home/brett/usr/img/bouquet.jpg"
      '';
    };
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
