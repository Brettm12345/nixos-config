#!/usr/bin/env cached-nix-shell
#! nix-shell -p git zsh -i zsh

unset IN_NIX_SHELL

nixpkgs="$(nix eval --raw '(import ./nix/sources.nix).nixpkgs-unstable')"

nix-store --realise "$nixpkgs" 2 &>/dev/null

export NIX_PATH=nixpkgs=$nixpkgs:nixos-config=/etc/nixos/configuration.nix

if [[ -n $INSIDE_EMACS ]]; then
  nix-build $nixpkgs/nixos -A system "$@"
else
  nix build -f $nixpkgs/nixos system "$@"
fi &&
  {
    git add .
    git commit -t <(
      echo -n "Update "
      echo -n "$(git diff HEAD --name-only)" | tr "\n" ", "
    ) --no-edit --no-gpg-sign
    git tag latestBuild --force
  }
