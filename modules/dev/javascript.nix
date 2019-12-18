{ pkgs, ... }: {
  home-manager.users.brett.home.packages = with pkgs; [
    yarn
    # yarn2nix
    nodejs
  ];
}