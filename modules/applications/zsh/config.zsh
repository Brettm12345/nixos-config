#!/usr/bin/env zsh

function prepend-sudo() {
  LBUFFER="sudo $LBUFFER"
}
zle -N prepend-sudo

bindkey ^s prepend-sudo

zinit ice wait"0a" compile:'{src/*.zsh,src/strategies/*}' lucid
zinit light zsh-users/zsh-autosuggestions

# zinit ice pick"async.zsh" src"pure.zsh"
# zinit light sindresorhus/pure

zinit ice wait"1b" as"program" lucid
zinit light zimfw/archive

zinit ice wait"1b" lucid
zinit light hlissner/zsh-autopair

zinit ice wait"1b" lucid
zinit light softmoth/zsh-vim-mode

zinit ice from'gh-r' as'program'
zinit light sei40kr/fast-alias-tips-bin
zinit light sei40kr/zsh-fast-alias-tips

zinit ice wait atinit"zpcompinit" lucid
zinit light zdharma/fast-syntax-highlighting

zinit as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' \
  atpull'%atclone' pick"direnv" src"zhook.zsh" for direnv/direnv

export RPROMPT=""
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#5b6395"

export KEYTIMEOUT=1
export MODE_CURSOR_VICMD="block"
export MODE_CURSOR_VIINS="blinking bar"
export MODE_CURSOR_SEARCH="steady underline"

bindkey '^e' autosuggest-accept

eval "$(dircolors)"
