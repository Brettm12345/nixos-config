#!/bin/sh

current="$(pwd)"
cd "$(dirname "$0")" || exit
make
cd "$current" || exit
