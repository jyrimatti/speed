#! /usr/bin/env nix-shell
#! nix-shell -i dash -I channel:nixos-23.11-small -p dash jq flock
set -eu

selector="${1:-}"

dash ./speedtest_cached.sh "$(cat .speed-host)" | jq -r ".$selector"
