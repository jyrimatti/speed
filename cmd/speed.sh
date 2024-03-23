#! /usr/bin/env NIXPKGS_ALLOW_UNFREE=1 nix-shell
#! nix-shell -i dash -I channel:nixos-23.11-small -p dash jq ookla-speedtest flock
set -eu

selector="${1:-}"

dash ./speedtest_cached.sh "$(cat .speed-host)" | jq -r ".$selector"
