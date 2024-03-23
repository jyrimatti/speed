#! /usr/bin/env nix-shell
#! nix-shell --pure --keep XDG_RUNTIME_DIR -i dash -I channel:nixos-23.11-small -p nix dash flock
set -eu

serverid="$1"

minutes=5

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
        NIXPKGS_ALLOW_UNFREE=1 nix-shell -p ookla-speedtest --run "speedtest -f json -s '$serverid' > '$outputfile'"
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