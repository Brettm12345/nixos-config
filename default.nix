{ config, pkgs, lib, ... }:
let sources = import ./nix/sources.nix;
in {
  imports = [
    "${./hardware-configuration}/uwu.nix"
    "${sources.home-manager}/nixos"
    ./modules
  ];

  system.stateVersion = "19.09";
}
