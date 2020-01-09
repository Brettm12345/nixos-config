{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ organizr php ];
  services = {
    plex = {
      enable = true;
      openFirewall = true;
    };
    sonarr.enable = true;
    radarr.enable = true;
  };
}
