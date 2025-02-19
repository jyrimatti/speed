#! /usr/bin/env NIXPKGS_ALLOW_UNFREE=1 nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep BKT_CACHE_DIR --keep NIXPKGS_ALLOW_UNFREE
#! nix-shell -i dash -I channel:nixos-24.11-small -p nix dash jq flock ookla-speedtest bkt
set -eu

stamp="$(date +%s)"

# clear cache
touch "${BKT_CACHE_DIR:-/tmp}/speed.lock"

for x in ping_high\
         ping_jitter\
         ping_latency\
         ping_low\
         download_bandwidth\
         download_bytes\
         download_elapsed\
         download_latency_high\
         download_latency_iqm\
         download_latency_jitter\
         download_latency_low\
         upload_bandwidth\
         upload_bytes\
         upload_elapsed\
         upload_latency_high\
         upload_latency_iqm\
         upload_latency_jitter\
         upload_latency_low\
    ; do
    dash ./speed.sh "$(echo "$x" | tr '_' '.')" | { read -r d; echo "[$stamp,$d]"; } | dash ./speed_convert.sh "$x"
done;