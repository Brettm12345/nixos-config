{ ... }: {
  imports = [
    ./theme
    ./secrets.nix
    ./applications.nix
    ./boot.nix
    ./gtk.nix
    ./fontconfig.nix
    ./hardware.nix
    ./network.nix
    ./overlay.nix
    ./services.nix
    ./users.nix
    ./virtualization.nix
    ./xdg.nix
    ./xserver.nix
    ./applications
    ./dev
  ];
}
