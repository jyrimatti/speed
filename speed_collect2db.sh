#! /usr/bin/env nix-shell
#! nix-shell --pure --keep XDG_RUNTIME_DIR --keep NIXPKGS_ALLOW_UNFREE -i dash -I channel:nixos-23.11-small -p dash jq nix dash sqlite gnused curl cacert flock bc coreutils inetutils gnugrep ookla-speedtest
set -eu

export LC_ALL=C # "fix" Nix Perl locale warnings

dash ./speed_collect.sh | sqlite3 -cmd ".timeout 90000" ./speed.db
