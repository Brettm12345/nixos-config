{ pkgs, ... }: {
  home-manager.users.brett.home.packages = with pkgs; [
    cargo-edit
    cargo-tree
    rustup
  ];
}

