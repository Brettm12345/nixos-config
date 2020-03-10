{ pkgs, config, ... }: {
  environment.pathsToLink = [ "/share" ];
  programs.ssh.askPassword = "${pkgs.gnome3.seahorse}/bin/seahorse";
  services.xserver = {
    enable = true;
    enableTCP = true;
    autoRepeatDelay = 300;
    autoRepeatInterval = 55;
    videoDrivers = [ "nouveau" "nv" "nvidia" ];
    desktopManager.gnome3.enable = true;
    displayManager.lightdm = {
      enable = true;
      greeters = {
        gtk = with pkgs; {
          enable = true;
          cursorTheme = {
            package = bibata-cursors;
            name = "Bibata Ice";
          };
          iconTheme = {
            name = "Papirus-Dark";
            package = papirus-icon-theme;
          };
          theme = {
            name = "Juno";
            package = juno;
          };
        };
        mini = {
          enable = false;
          user = "brett";
          extraConfig = with config.themes.colors.grayscale; ''
            [greeter]
            show-password-label = false
            [greeter-theme]
            font = Inter v
            password-background-color = ${base0}
            window-color = ${base2}
            background-image = "/home/brett/usr/img/bouquet.jpg"
          '';
        };
      };
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
        haskellPackages.xmonad
      ];
    };
  };
}
