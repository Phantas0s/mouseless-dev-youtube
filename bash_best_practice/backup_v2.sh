#!/usr/bin/env bash

# e - script stops on error
# u - error if undefined variable
# o pipefail - script fails if command piped fails
set -euo pipefail

__ScriptVersion="1.0"

#===  FUNCTION  ================================================================
#         NAME:  Backup
#  DESCRIPTION:  Backup a list of directories using rsync
#===============================================================================
function usage ()
{
    echo "Usage :  $0 [options] [--]

    Options:
    -h|help       Display this message
    -v|version    Display script version"

}    # ----------  end of function usage  ----------

#-----------------------------------------------------------------------
#  Handle command line arguments
#-----------------------------------------------------------------------

rsync_opts=(-avz --delete)

while getopts ":hvd" opt
do
  case $opt in

    h|help     )  usage; exit 0   ;;

    v|version  )  echo "$0 -- Version $__ScriptVersion"; exit 0   ;;

    d|dry-run  )  rsync_opts+=(--dry-run);;

    * )  echo -e "\n  Option does not exist : $OPTARG\n"
          usage; exit 1   ;;

  esac    # --- end of case ---
done
shift $((OPTIND-1))

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

    rsync "${rsync_opts[@]}" "$src/" "$dest"
done
