#! /usr/bin/env NIXPKGS_ALLOW_UNFREE=1 nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.11-small -p dash ookla-speedtest jq nix dash sqlite gnused curl cacert flock bc coreutils inetutils gnugrep
set -eu

export LC_ALL=C # "fix" Nix Perl locale warnings

dash ./speed_collect.sh | sqlite3 -cmd ".timeout 90000" ./speed.db
