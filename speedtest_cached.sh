#! /usr/bin/env nix-shell
#! nix-shell --pure --keep XDG_RUNTIME_DIR --keep NIX_ALLOW_UNFREE --keep SPEEDTEST_CACHED_MINUTES -i dash -I channel:nixos-23.11-small -p dash ookla-speedtest flock
set -eu

serverid="$1"

minutes="${SPEEDTEST_CACHED_MINUTES:-300}"

outputfile="${XDG_RUNTIME_DIR:-/tmp}/$(basename "$PWD")/$serverid"

if [ -f "$outputfile" ] && [ -s "$outputfile" ]; then
    for i in $(find "$outputfile" -mmin -$minutes); do
        cat "$outputfile"
        exit 0
    done
fi

dir="$(dirname "$outputfile")"
test -e "$dir" || mkdir -p "$dir"

(
    flock 8

    fetch() {
        speedtest -f json -s "$serverid" > "$outputfile"
    }

    if [ ! -f "$outputfile" ] || [ ! -s "$outputfile" ]; then
        fetch
    else
        for i in $(find "$outputfile" -mmin +$minutes); do
            fetch
        done
    fi

    cat "$outputfile"
) 8> "$outputfile.lock"