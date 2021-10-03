#!/usr/bin/env bash

declare -A folders=(
    # ["source"]="destination"
    ["$HOME/backup/source"]="$HOME/backup/destination"
)

# ! to expand the keys
for key in "${!folders[@]}"; do
    src=$key
    dest="${folders[$key]}"

    [ ! -d "$src" ] && echo "The directory $src doesn't exist -- NO BACKUP CREATED" && continue
    mkdir -p "$dest"

    rsync -avz --delete --dry-run "$src/" "$dest"
done
