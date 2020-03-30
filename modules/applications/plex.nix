{ ... }: {
  services = {
    plex = {
      enable = true;
      openFirewall = true;
    };
    sonarr.enable = true;
    radarr.enable = true;
  };
}
