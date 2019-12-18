{ ... }: {
  imports = [
    ./secrets.nix
    ./applications
    ./dev
    ./applications.nix
    ./boot.nix
    ./colors.nix
    ./fonts.nix
    ./hardware.nix
    ./network.nix
    ./packages.nix
    ./services.nix
    ./users.nix
    ./virtualization.nix
    ./xdg.nix
    ./xserver.nix
  ];
}
