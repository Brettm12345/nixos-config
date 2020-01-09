{ pkgs, ... }: {
  home-manager.users.brett.home.packages = with pkgs.haskellPackages; [
    dhall
    dhall-bash
    dhall-json
  ];
}
