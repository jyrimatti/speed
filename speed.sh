#! /usr/bin/env nix-shell
#! nix-shell -i dash -I channel:nixos-23.11-small -p dash nix jq flock ookla-speedtest
set -eu

selector="${1:-}"

. ./speed_env.sh

dash ./speedtest_cached.sh "$SPEED_HOST" | jq -r ".$selector"
