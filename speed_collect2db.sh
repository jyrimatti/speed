#! /usr/bin/env NIXPKGS_ALLOW_UNFREE=1 nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep BKT_CACHE_DIR --keep NIXPKGS_ALLOW_UNFREE
#! nix--shell -i dash -I channel:nixos-24.11-small -p dash jq nix dash sqlite gnused curl cacert flock bc coreutils inetutils gnugrep ookla-speedtest bkt
set -eu

export LC_ALL=C # "fix" Nix Perl locale warnings

dash ./speed_collect.sh | sqlite3 -cmd ".timeout 90000" ./speed.db
