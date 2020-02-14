#!/usr/bin/env zsh
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


setopt autocd correct rcquotes notify globdots autoresume

export LESS="-FX"

function prepend-sudo {
  LBUFFER="sudo $LBUFFER"
}
zle -N prepend-sudo
bindkey -v ^s prepend-sudo

function copy {
  print -rn -- $CUTBUFFER | xsel -i -p;
}
zle -N copy
bindkey -v ^c copy

function paste {
  RBUFFER=$(xsel -o -p </dev/null)$RBUFFER
}
zle -N paste
bindkey -v ^v paste

function open-project {
  selection=$($HOME/bin/find-project)
  if [[ -z "$selection" ]]; then
    zle redisplay
    return 0
  fi
  cd "$selection"
  unset selection
  local ret=$?
  zle fzf-redraw-prompt
  return $ret
}

zle -N open-project
bindkey ^o open-project
zle -N edit-command-line
bindkey -a "^V" edit-command-line
bindkey -v '^e^e' edit-command-line


bindkey jk vi-cmd-mode

function rebuild {
  dir=$(pwd)
  cd $HOME/src/github.com/brettm12345/nixos-config
  ./install
  cd $dir
}


autoload -Uz edit-command-line
zle -N edit-command-line

autoload -Uz select-word-style
select-word-style shell

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

zinit ice wait"0a" light-mode lucid for \
  compile'{src/*.zsh,src/strategies/*}' atload'_zsh_autosuggest_start' \
      zsh-users/zsh-autosuggestions

zinit as"program" src"./zsh/gh/gh.plugin.zsh"
zinit light brettm12345/gh

zinit ice atload"zpcdreplay"
zinit light BuonOmo/yarn-completion

zinit ice wait "0b" light-mode lucid wait for zsh-users/zsh-history-substring-search
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='underline'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=''
zle -N history-substring-search-up
zle -N history-substring-search-down
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down


zinit ice wait"1b" as"program" lucid
zinit light zimfw/archive

zinit ice wait"1b" lucid
zinit light hlissner/zsh-autopair

zinit ice wait"1b" atload"KEYTIMEOUT=20" lucid
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

zinit ice wait atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" lucid
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

typeset -U PATH path
path=("$HOME/bin" "$path[@]")
export PATH
RPROMPT=""
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#5b6395"
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

MODE_CURSOR_VICMD="block"
MODE_CURSOR_VIINS="blinking bar"
MODE_CURSOR_SEARCH="steady underline"

bindkey '^e' autosuggest-accept