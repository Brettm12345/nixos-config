{ ... }: {
  imports = [
    ./secrets.nix
    ./applications.nix
    ./colors.nix
    ./boot.nix
    ./fonts.nix
    ./hardware.nix
    ./network.nix
    ./packages.nix
    ./services.nix
    ./users.nix
    ./virtualization.nix
    ./xdg.nix
    ./xserver.nix
    ./applications
    ./dev
  ];
}
