{ pkgs, ... }: {
  home-manager.users.brett.home.packages = with pkgs; [
    cargo-edit
    cargo-outdated
    cargo-release
    cargo-tree
    racer
    rustup
  ];
}

