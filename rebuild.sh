#!/bin/sh
#
unset IN_NIX_SHELL

nixpkgs="$(nix eval --raw '(import ./nix/sources.nix).nixpkgs-unstable')"

nix-store --realise "$nixpkgs" 2>/dev/null

export NIX_PATH=nixpkgs=$nixpkgs:nixos-config=/etc/nixos/configuration.nix

nixos-rebuild -I "nixpkgs=$nixpkgs" "$@"
