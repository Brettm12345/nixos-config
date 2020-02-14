#!/usr/bin/env zsh
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

zinit ice depth=1 atload'!source ~/.p10k.zsh'
zinit light romkatv/powerlevel10k

zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS

zinit as"program" make"!" src"./_shell/_pmy.zsh" pick"$ZPFX/bin/pmy" for relastle/pmy

zinit as"program" make"!" atclone"./direnv hook zsh > zhook.zsh" \
  atpull"%atclone" pick"direnv" src"zhook.zsh" for direnv/direnv

RPROMPT=""
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#5b6395"
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

KEYTIMEOUT=1
MODE_CURSOR_VICMD="block"
MODE_CURSOR_VIINS="blinking bar"
MODE_CURSOR_SEARCH="steady underline"

bindkey '^e' autosuggest-accept