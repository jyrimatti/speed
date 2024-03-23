#! /usr/bin/env NIXPKGS_ALLOW_UNFREE=1 nix-shell
#! nix-shell -i dash -I channel:nixos-23.11-small -p dash jq ookla-speedtest flock
set -eu

dash ./cmd/speed.sh upload.latency.low
