{ pkgs, config, ... }: {
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "no";
    forwardX11 = true;
    ports = [ 22 13722 ];
  };

  home-manager.users.brett.programs.ssh =
    if (!isNull config.secrets.id_rsa) then {
      enable = true;
      controlMaster = "auto";
      controlPersist = "yes";
      controlPath = "$HOME/var/ssh/sockets/socket-%r@%h:%p";
      matchBlocks = {
        "*" = {
          identityFile = toString (pkgs.writeTextFile {
            name = "id_rsa";
            text = config.secrets.id_rsa;
          });
          compression = false;
          addressFamily = "inet";
        };
        aws = {
          hostname = "ec2-54-172-188-27.compute-1.amazonaws.com";
          user = "ec2-user";
          identityFile = "$HOME/.ssh/yelli.pem";
        };

        magento = {
          hostname = "209.126.24.127";
          user = "a6ff38c0_1";
        };

      };
    } else
      { };
}
