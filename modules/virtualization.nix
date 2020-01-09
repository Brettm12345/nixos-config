{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ docker-compose ];
  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
    };
    virtualbox.host = {
      enable = false;
      enableHardening = false;
      enableExtensionPack = true;
    };
  };
}
