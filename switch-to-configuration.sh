#!/bin/sh

PATH=/run/current-system/sw/bin

DIR="$(dirname "$0")"

nix-env --profile /nix/var/nix/profiles/system --set "$(readlink "$DIR"/result)"

"$DIR"/result/bin/switch-to-configuration "$@"
