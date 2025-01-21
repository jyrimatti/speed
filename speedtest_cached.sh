#! /usr/bin/env nix-shell
#! nix-shell --pure --keep XDG_RUNTIME_DIR --keep SPEEDTEST_OUTPUT_DIR --keep NIX_ALLOW_UNFREE --keep SPEEDTEST_CACHED_MINUTES -i dash -I channel:nixos-24.11-small -p dash ookla-speedtest flock
set -eu

serverid="$1"

minutes="${SPEEDTEST_CACHED_MINUTES:-300}"

outputdir="${SPEEDTEST_OUTPUT_DIR:-${XDG_RUNTIME_DIR:-/tmp}/$(basename "$PWD")}"
outputfile="$outputdir/$serverid"

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
        tmpfile="$(mktemp "${XDG_RUNTIME_DIR:-/tmp}/speedtest_cached.XXXXXX")"
        speedtest --accept-gdpr -f json -s "$serverid" > "$tmpfile"
        if [ -s "$tmpfile" ]; then
            mv "$tmpfile" "$outputfile"
        else
            rm "$tmpfile"
        fi
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