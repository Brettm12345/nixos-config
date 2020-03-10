{ pkgs, ... }: {
  home-manager.users.brett.home.packages = with pkgs.elmPackages; [
    elm-doc-preview
    elm-live
    elm
    elm-format
    elmi-to-json
    elm-test
    elm-upgrade
    elm-verify-examples
    elm-xref
    elm-analyse
    elm-language-server
  ];
}
