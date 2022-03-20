#!/usr/bin/env bash

find -type d | \
fzf \
--bind "enter:execute(nvim {})" \
--bind "del:execute(rm -ri {})" \
--bind "?:toggle-preview" \
--bind "ctrl-d:change-prompt(Dirs > )" \
--bind "ctrl-d:+reload(find -type d)" \
--bind "ctrl-d:+change-preview(tree -C {} | head -n 10)" \
--bind "ctrl-d:+toggle-preview" \
--bind "ctrl-f:change-prompt(Files > )" \
--bind "ctrl-f:+reload(find -type f)" \
--bind "ctrl-f:+change-preview(cat {})" \
--bind "ctrl-f:+toggle-preview" \
--header "CTRL+R to delete | ENTER to run nvim | DEL to delete | CTRL-D to display directories | CTRL-F to display files" \
--height 50% --border sharp --margin 5% --preview-window hidden --preview "tree -C {}" --prompt "Dirs > "
