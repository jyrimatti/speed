#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep BKT_CACHE_DIR --keep NIXPKGS_ALLOW_UNFREE
#! nix-shell -i dash -I channel:nixos-24.11-small -p dash jq flock ookla-speedtest bkt
set -eu

dash ./speed.sh upload.bandwidth
