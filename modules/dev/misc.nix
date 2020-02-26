{ pkgs, ... }: {
  home-manager.users.brett.home.packages = with pkgs; [
    clang
    clang-tools
    lldb
    checkbashisms
    python3
    gnumake
    pkgconfig
    shfmt
    shellcheck
  ];
}
