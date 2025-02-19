#! /usr/bin/env NIXPKGS_ALLOW_UNFREE=1 nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep BKT_CACHE_DIR --keep NIXPKGS_ALLOW_UNFREE
#! nix-shell -i dash -I channel:nixos-24.11-small -p dash nix jq flock ookla-speedtest bkt
set -eu

selector="${1:-}"

. ./speed_env.sh

# shared cache for everyone, since speedtest is not fast enough for real-time querying
export BKT_SCOPE="all_speed_invokers"

export BKT_CACHE_DIR="/tmp"
lock="${BKT_CACHE_DIR:-/tmp}/speed.lock"

flock "$lock" \
    bkt --discard-failures --ttl 24h --modtime "$lock" -- \
        speedtest --accept-gdpr -f json -s "$SPEED_HOST" \
  | jq -r ".$selector"
