{ pkgs, ... }: {
  home-manager.users.brett.home.packages = (with pkgs; [
    pythonFull
    python2Full
    pypi2nix
  ]) ++ (with pkgs.python37Packages; [
    pip
  ]) ++ (with pkgs.python27Packages; [
    pip
  ]);
}