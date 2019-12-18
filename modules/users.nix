{ config, ... }:
let hash = config.secrets.passwordHash;
in {
  users = {
    mutableUsers = false;
    users.root.hashedPassword = hash;
    users.brett = {
      isNormalUser = true;
      extraGroups = [
        "sudo"
        "wheel"
        "networkmanager"
        "disk"
        "dbus"
        "audio"
        "docker"
        "sound"
        "pulse"
        "adbusers"
        "input"
        "libvirtd"
        "vboxusers"
        "wireshark"
      ];
      hashedPassword = hash;
      uid = 1000;
    };
  };

  systemd.services."user@" = { serviceConfig = { Restart = "always"; }; };

  home-manager.users.brett.home.sessionVariables.XDG_RUNTIME_DIR =
    "/run/user/1000";

  security.sudo = {
    enable = true;
    extraConfig = ''
      brett ALL = (root) NOPASSWD: /run/current-system/sw/bin/nixos-rebuild
    '';
  };
  nix.requireSignedBinaryCaches = false;
  home-manager.useUserPackages = true;
}
