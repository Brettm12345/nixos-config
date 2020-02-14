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

autoload -Uz edit-command-line
zle -N edit-command-line

autoload -Uz select-word-style
select-word-style shell

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

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

zinit wait"2" lucid for wfxr/forgit

zinit ice from'gh-r' as'program'
zinit light sei40kr/fast-alias-tips-bin
zinit light sei40kr/zsh-fast-alias-tips

zinit ice depth=1 atload'!source ~/.p10k.zsh'
zinit light romkatv/powerlevel10k

zinit as"program" make"!" src"./_shell/_pmy.zsh" pick"$ZPFX/bin/pmy" for relastle/pmy

zinit as"program" make"!" atclone"./direnv hook zsh > zhook.zsh" \
  atpull"%atclone" pick"direnv" src"zhook.zsh" for direnv/direnv

zinit ice wait atinit"zpcompinit; zpcdreplay" lucid
zinit light zdharma/fast-syntax-highlighting

zinit light-mode for \
    zinit-zsh/z-a-test \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-submods \
    zinit-zsh/z-a-bin-gem-node \
    zinit-zsh/z-a-rust

zinit as"null" wait"3" lucid for \
    sbin Fakerr/git-recall \
    sbin paulirish/git-open \
    sbin paulirish/git-recent \
    sbin davidosomething/git-my \
    sbin arzzen/git-quick-stats \
    sbin iwata/git-now \
    make"PREFIX=$ZPFX" tj/git-extras \
    sbin"git-url;git-guclone" make"GITURL_NO_CGITURL=1" zdharma/git-url

RPROMPT=""
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#5b6395"
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

KEYTIMEOUT=1
MODE_CURSOR_VICMD="block"
MODE_CURSOR_VIINS="blinking bar"
MODE_CURSOR_SEARCH="steady underline"

bindkey '^e' autosuggest-accept