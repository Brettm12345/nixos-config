{ pkgs, ... }: {
  home-manager.users.brett.home.packages = with pkgs; [
    cargo-bloat
    cargo-edit
    cargo-generate
    cargo-make
    cargo-sweep
    cargo-tree
    cargo-xbuild
    cargo-outdated
    cargo-release
    cargo-tree
    cargo-watch
    # racer
    rustup
  ];
}

