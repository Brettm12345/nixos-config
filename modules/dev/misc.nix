{ pkgs, ... }: {
  home-manager.users.brett.home.packages = with pkgs; [
    ccls
    clang
    clang-tools
    lldb
    checkbashisms
    python3
    gnumake
    pkgconfig
    shfmt
    shellcheck
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.ocaml-language-server
    nodePackages.typescript-language-server
    nodePackages.vscode-css-languageserver-bin
    nodePackages.vscode-html-languageserver-bin
    nodePackages.vue-language-server
  ];
}
