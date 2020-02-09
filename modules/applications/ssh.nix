{ pkgs, config, ... }: {
  services.openssh = {
    enable = false;
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
      matchBlocks = {
        "*" = {
          identityFile = toString (pkgs.writeTextFile {
            name = "id_rsa";
            text = config.secrets.id_rsa;
          });
          compression = false;
          addressFamily = "inet";
        };
      };
    } else
      { };
}
