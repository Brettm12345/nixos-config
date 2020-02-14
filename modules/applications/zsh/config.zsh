#!/usr/bin/env zsh

zinit ice wait:0a compile:'{src/*.zsh,src/strategies/*}' lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait:1b as:"program" lucid
zinit light zimfw/archive

zinit ice wait:1b lucid
zinit light hlissner/zsh-autopair

zinit ice wait:1b lucid
zinit light softmoth/zsh-vim-mode

zinit ice wait atinit:"zpcompinit" lucid
zinit light zdharma/fast-syntax-highlighting

ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#5b6395"

KEYTIMEOUT=1
MODE_CURSOR_VICMD="block"
MODE_CURSOR_VIINS="blinking bar"
MODE_CURSOR_SEARCH="steady underline"

bindkey '^e' autosuggest-accept

eval "$(dircolors)"
