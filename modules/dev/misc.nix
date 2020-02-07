{ pkgs, ... }: {
  home-manager.users.brett.home.packages = with pkgs; [
    clang
    clang-tools
    lldb
    python3
    gnumake
    pkgconfig
    shellcheck
  ];
}
