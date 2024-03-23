#! /usr/bin/env nix-shell
#! nix-shell -i dash -I channel:nixos-23.11-small -p dash jq flock
set -eu

dash ./cmd/speed.sh upload.latency.high
