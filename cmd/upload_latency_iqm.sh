#! /usr/bin/env nix-shell
#! nix-shell -i dash -I channel:nixos-23.11-small -p dash jq flock ookla-speedtest
set -eu

dash ./speed.sh upload.latency.iqm
