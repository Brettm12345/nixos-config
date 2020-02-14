#!/usr/bin/env zsh
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

function prepend-sudo {
  LBUFFER="sudo $LBUFFER"
}

function rebuild {
  dir=$(pwd)
  cd $HOME/src/github.com/brettm12345/nixos-config
  ./install
  cd $dir
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

zinit ice wait"1b" from"gh-r" as"program" lucid
zinit light sei40kr/fast-alias-tips-bin
zinit light sei40kr/zsh-fast-alias-tips

zinit ice wait atinit"zpcompinit" lucid
zinit light zdharma/fast-syntax-highlighting

zinit ice depth=1 atload'!source ~/.p10k.zsh'
zinit light romkatv/powerlevel10k

zinit as"program" pick"./zsh/gh/gh.plugin.zsh" atload 'compdef ./zsh/gh/_gh gh'
zinit light brettm12345/gh

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
