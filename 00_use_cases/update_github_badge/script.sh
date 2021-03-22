#!/bin/zsh

# e - script stops on error
# u - error if undefined variable
# o pipefail - script fails if command piped fails
set -euo pipefail

count=$(find -- **/*.mm | wc -l)
pattern="https://img\.shields\.io/badge/total_mindmaps.*"
replace="https://img.shields.io/badge/total_mindmaps-$count-blue)"
sed -i "s#$pattern#$replace#" README.md
