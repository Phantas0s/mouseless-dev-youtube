#!/usr/bin/env bash

# e - script stops on error (return != 0)
# u - error if undefined variable
# o pipefail - script fails if one of piped command fails
# x - output each line (debug)
set -euo pipefail

function handle-arguments() {
    __ScriptVersion="1.0"

    while getopts ":hvd" opt
    do
    case $opt in

        h|help     )  output-help; exit 0   ;;

        v|version  )  echo "$0 -- Version $__ScriptVersion"; exit 0   ;;

        d|dry-run  )  rsync_opts+=(--dry-run); ;;

        * )  echo -e "\n  Option does not exist : $OPTARG\n"
            output-help; exit 1   ;;

    esac
    done
    shift $(($OPTIND-1))
}

function output-help()
{
    echo "Usage :  $0 [options] [--]

    Options:
    -h|help       Display this message
    -v|version    Display script version
    -d|dry-run    Run rsync with --dry-run for test"
}

function run() {
    local rsync_opts=(-avz --delete)
    handle-arguments "$@"

    declare -A folder=(
        ["$HOME/backup/source"]="$HOME/backup/destination"
    )

    for key in "${!folder[@]}"; do
        src="$key"
        dest="${folder[$key]}"

        [ ! -d "$src" ] && echo "The directory $src does not exist -- NO BACKUP CREATED" && continue

        rsync "${rsync_opts[@]}" "$src/" "$dest"
    done
}

run "$@"
