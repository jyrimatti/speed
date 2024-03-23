#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.11-small -p dash jq flock
set -eu

stamp="$(date +%s)"

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
    dash ./cmd/speed.sh "$(echo "$x" | tr '_' '.')" | { read -r d; echo "[$stamp,$d]"; } | dash ./speed_convert.sh "$x"
done;