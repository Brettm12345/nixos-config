#!/bin/sh

PATH=/run/current-system/sw/bin

nix-env --profile /nix/var/nix/profiles/system --set "$(readlink "$1"/result)"
"$1"/result/bin/switch-to-configuration "$@"
