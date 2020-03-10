{ pkgs, ... }: {
  services.lorri.enable = true;
  home-manager.users.brett.home.packages = with pkgs; [
    niv
    cached-nix-shell
    # nixfmt
    nix-prefetch
  ];
}
