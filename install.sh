#!/usr/bin/env nix-shell
#!nix-shell -i sh -p gnumake gnupg

cd "$(dirname "$0")" || exit

make
