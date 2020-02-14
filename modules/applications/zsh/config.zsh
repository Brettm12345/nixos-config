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

zinit wait"0a" light-mode lucid for \
    sei40kr/zsh-fast-alias-tips \
    compile'{src/*.zsh,src/strategies/*}' atload'_zsh_autosuggest_start' \
        zsh-users/zsh-autosuggestions \
    atload"zpcdreplay" \
        BuonOmo/yarn-completion


zinit wait"0b" light-mode lucid for \
    pick"autopair.zsh" nocompletions \
        hlissner/zsh-autopair \
    atload"KEYTIMEOUT=20" \
        softmoth/zsh-vim-mode \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" atpull"fast-theme XDG:overlay" \
        zdharma/fast-syntax-highlighting \
    atload"bind_substring_search" \
        zsh-users/zsh-history-substring-search

function bind_substring_search {
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='underline'
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=''
    zle -N history-substring-search-up
    zle -N history-substring-search-down
    bindkey '^[OA' history-substring-search-up
    bindkey '^[OB' history-substring-search-down
    bindkey -M vicmd 'k' history-substring-search-up
    bindkey -M vicmd 'j' history-substring-search-down
}


zinit light-mode wait"0c" as"program" lucid for \
    zimfw/archive \
    make"!" atclone"./direnv hook zsh > zhook.zsh" atpull"%atclone" pick"direnv" src"zhook.zsh" \
        direnv/direnv \
    make"!" src"./_shell/_pmy.zsh" pick"$ZPFX/bin/pmy" \
        relastle/pmy \
    from'gh-r' \
        sei40kr/fast-alias-tips-bin

zt light-mode lucid for \
    trigger-load'!gh' src"./zsh/gh/gh.plugin.zsh" \
        brettm12345/gh
    trigger-load'!x;!extract' \
        OMZ::plugins/extract/extract.plugin.zsh \
    trigger-load'!ga;!gcf;!gclean;!gd;!glo;!grh;!gss' \
        wfxr/forgit \
    trigger-load'!gencomp' pick'zsh-completion-generator.plugin.zsh' blockf \
    atload'alias gencomp="zinit lucid nocd as\"null\" wait\"1\" atload\"zinit creinstall -q _local/config-files; zpcompinit\" for /dev/null; gencomp"' \
        RobSis/zsh-completion-generator

zinit ice depth=1 atload'!source ~/.p10k.zsh'
zinit light romkatv/powerlevel10k

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