{ pkgs, lib, ... }:
let
  # vscodeExtensions = with pkgs.vscode-extensions; [
  #   ms-vscode.cpptools
  #   ms-vscode-remote
  #   alanz.vscode-hie-server
  #   bbenoist.Nix
  #   justusadam.language-haskell
  # ];
  cfg.allowUnfree = true;
in with lib; {
  nixpkgs.config.allowUnfree = cfg.allowUnfree;
  home-manager.users.brett.home.packages = [ pkgs.vscode ];
}
