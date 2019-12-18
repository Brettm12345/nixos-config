{ pkgs, ... }: {
  home-manager.users.brett.home.packages = with pkgs; [
    dhall
    dhall-bash
    dhall-json
  ];
}
