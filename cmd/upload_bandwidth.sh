#! /usr/bin/env nix-shell
#! nix-shell -i dash -I channel:nixos-24.11-small -p dash jq flock ookla-speedtest
set -eu

dash ./speed.sh upload.bandwidth
