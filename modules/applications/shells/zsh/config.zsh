#!/usr/bin/env zsh
setopt autocd correct rcquotes notify globdots autoresume promptsubst

CARGO_HOME="$HOME/.cargo"
BROWSER="firefox"

typeset -U PATH path
path=("$HOME/bin" "$HOME/.npm/bin" "$CARGO_HOME/bin" "$HOME/.yarn/bin" "$HOME/.cabal/bin" "$HOME/.emacs.d/bin" "$path[@]") && export PATH

RPROMPT=""
GHQ_ROOT="$HOME/src"

alias -- -="cd -"

export LESS="-FX"

zle -N edit-command-line
bindkey -a "^V" edit-command-line
bindkey -v '^e^e' edit-command-line

zle -N open-project
bindkey ^o open-project

# zle -N execute-command
# bindkey "^i" execute-command

load edit-command-line

with select-word-style
select-word-style shell

with url-quote-magic
zle -N self-insert url-quote-magic

# Suff that gets loaded immediately
zinit ice depth=1 atload'!source ~/.config/zsh/p10k.zsh' atinit'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true'
zinit light romkatv/powerlevel10k

x11-clip-wrap-widgets() {
    local copy_or_paste=$1
    shift
    for widget in $@; do
        if [[ $copy_or_paste == "copy" ]]; then
            eval "
            function _x11-clip-wrapped-$widget() {
                zle .$widget
                xclip -in -selection clipboard <<<\$CUTBUFFER
            }
            "
        else
            eval "
            function _x11-clip-wrapped-$widget() {
                CUTBUFFER=\$(xclip -out -selection clipboard)
                zle .$widget
            }
            "
        fi
        zle -N $widget _x11-clip-wrapped-$widget
    done
}


local copy_widgets=(
    vi-yank vi-yank-eol vi-delete vi-backward-kill-word vi-change-whole-line
)
local paste_widgets=(
    vi-put-{before,after}
)

x11-clip-wrap-widgets copy $copy_widgets
x11-clip-wrap-widgets paste  $paste_widgets

bindkey -M viins '^v' vi-put-before
bindkey -M viins '^c' vi-yank

setup-autosuggest() {
  bindkey -M viins '^e' autosuggest-accept
  ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=30
  ZSH_AUTOSUGGEST_USE_ASYNC=1
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#5b6395'
}

setup-vim-mode() {
  bindkey -M viins jk vi-cmd-mode
  KEYTIMEOUT=20
  MODE_CURSOR_VICMD='block'
  MODE_CURSOR_VIINS='blinking bar'
  MODE_CURSOR_SEARCH='steady underline'
}

setup-lazyenv() {
  export ZSH_EVALCACHE_DIR=$XDG_CACHE_HOME/lazyenv
  lazyenv-enabled
  lazyload init:hub
}

setup-fzf-tab() {
  bindkey -M viins '^T' toggle-fzf-tab
}

setup-completion-generator() {
  alias gencomp='zinit lucid nocd as"null" wait"1" atload"zinit creinstall -q _local/config-files; fast-zpcompinit" for /dev/null; gencomp'
}

setup-enhancd() {
  ENHANCD_FILTER='fzf -0 -1 --ansi --preview="exa -l --git -h --git-ignore --color=always -a {}"'
  ENHANCD_HOOK_AFTER_CD="exa -l --git -h --git-ignore --color=always -a"
}

setup-substring-search() {
  HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='underline'
  HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=''
  HISTORY_SUBSTRING_SEARCH_FUZZY=set
  zle -N history-substring-search-up
  zle -N history-substring-search-down
  bindkey '^[OA' history-substring-search-up
  bindkey '^[OB' history-substring-search-down
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
}

# Very important things
zinit wait'0a' light-mode lucid nocompletions for \
  atinit'ZINIT[COMPINIT_OPTS]=-C; fast-zpcompinit; zpcdreplay' atpull'fast-theme XDG:overlay' \
    zdharma/fast-syntax-highlighting \
  compile'{src/*.zsh,src/strategies/*}' atinit'setup-autosuggest' atload'!_zsh_autosuggest_start' \
    zsh-users/zsh-autosuggestions

# Stuff that can wait a minute
zinit wait'0b' light-mode lucid nocompletions for \
  sei40kr/zsh-fast-alias-tips \
  atload'setup-vim-mode' softmoth/zsh-vim-mode \
  atload'setup-lazyenv' black7375/zsh-lazyenv \
  atload'setup-fzf-tab' Aloxaf/fzf-tab \
  pick'autopair.zsh' hlissner/zsh-autopair \
  atload'setup-substring-search' zsh-users/zsh-history-substring-search

zinit wait'0c' lucid light-mode for \
  wfxr/forgit \
  zinit-zsh/z-a-man \
  reegnz/jq-zsh-plugin \
  chisui/zsh-nix-shell \
  OMZ::plugins/fancy-ctrl-z/fancy-ctrl-z.plugin.zsh \
  OMZ::plugins/yarn/yarn.plugin.zsh \
  atload'bindkey "^x" sudo-command-line' OMZ::plugins/sudo/sudo.plugin.zsh


zinit light-mode wait"1" lucid as"completion" for \
  atclone'./zplug.zsh' g-plane/zsh-yarn-autocompletions \
  zsh-users/zsh-completions \
  spwhitt/nix-zsh-completions

zinit as"program" light-mode lucid for \
  from'gh-r' sei40kr/fast-alias-tips-bin \
  make'!' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' pick'direnv' src'zhook.zsh' direnv/direnv \
  trigger-load'!cd' src"init.sh" atload"setup-enhancd" blockf b4b4r07/enhancd \
  trigger-load'!gh' src"zsh/gh/gh.plugin.zsh" blockf brettm12345/gh \
  trigger-load'!code;!vscode' wuotr/zsh-plugin-vscode \
  trigger-load'!x;!extract' blockf OMZ::plugins/extract/extract.plugin.zsh \
  trigger-load'!gencomp' pick'zsh-completion-generator.plugin.zsh' blockf atload'setup-completion-generator' RobSis/zsh-completion-generator
