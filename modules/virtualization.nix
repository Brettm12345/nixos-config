{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ docker-compose ];
  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
    };
    virtualbox.host = {
      enable = true;
      enableHardening = false;
      enableExtensionPack = true;
    };
  };
}
