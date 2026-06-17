#!/bin/sh -e

export NAME="$1"
export DATA_IMAGE="$PWD/data/$NAME.raw"
[ -f "$DATA_IMAGE" ] || { echo "Image \"$NAME\" not found"; exit 1; }
nix run .#vm