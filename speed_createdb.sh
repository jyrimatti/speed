#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-24.11-small -p dash sqlite
set -eu

sqlite3 speed.db < speed_create.sql