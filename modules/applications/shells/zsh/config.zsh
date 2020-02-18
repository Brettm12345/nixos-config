#!/usr/bin/env zsh
setopt autocd correct rcquotes notify globdots autoresume promptsubst

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
zinit ice depth=1 atload'!source ~/.config/zsh/p10k.zsh' atinit'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' cloneeopts'-b readonly-fix'
zinit light brettm12345/powerlevel10k

function setup-autosuggest() {
  bindkey '^e' autosuggest-accept
  ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=30
  ZSH_AUTOSUGGEST_USE_ASYNC=1
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#5b6395"
}

function setup-vim-mode() {
  bindkey jk vi-cmd-mode
  KEYTIMEOUT=20
  MODE_CURSOR_VICMD="block"
  MODE_CURSOR_VIINS="blinking bar"
  MODE_CURSOR_SEARCH="steady underline"
}

function setup-lazyenv() {
  export ZSH_EVALCACHE_DIR=$XDG_CACHE_HOME/lazyenv
  lazyenv-enabled
  lazyload init:hub
}

function setup-fzf-tab() {
  bindkey '^T' toggle-fzf-tab
}

# Very important things
zinit wait'0a' light-mode lucid nocompletions for \
  sei40kr/zsh-fast-alias-tips \
  atload'setup-fzf-tab' Aloxaf/fzf-tab \
  atload'setup-lazyenv' black7375/zsh-lazyenv \
  atload'setup-vim-mode' softmoth/zsh-vim-mode \
  blockf zsh-users/zsh-completions \
  atinit'ZINIT[COMPINIT_OPTS]=-C; fast-zpcompinit; zpcdreplay' atpull'fast-theme XDG:overlay' \
  zdharma/fast-syntax-highlighting \
  compile'{src/*.zsh,src/strategies/*}' atinit'setup-autosuggest' atload'!_zsh_autosuggest_start' \
  zsh-users/zsh-autosuggestions

function setup-substring-search() {
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

# Stuff that can wait a minute
zinit wait'0b' light-mode lucid nocompletions for \
  pick'autopair.zsh' hlissner/zsh-autopair \
  atload'setup-substring-search' zsh-users/zsh-history-substring-search

zinit light-mode wait'0c' as'program' lucid for \
  chisui/zsh-nix-shell \
  from'gh-r' sei40kr/fast-alias-tips-bin \
  make'!' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' pick'direnv' src'zhook.zsh' \
  direnv/direnv \
  make'!' src'./_shell/_pmy.zsh' pick"$ZPFX/bin/pmy" \
  relastle/pmy

zinit light-mode wait"1" lucid as"completion" for \
  spwhitt/nix-zsh-completions \
  OMZ::plugins/gitfast/_git \
  OMZ::plugins/gatsby/_gatsby

zinit ice lucid wait
zinit snippet OMZ::plugins/git/git.plugin.zsh

zinit ice wait lucid atinit"bind '^s' sudo-command-line"
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh

zinit ice wait lucid
zinit snippet OMZ::lib/git.zsh

zinit ice wait lucid atinit'setup-clipboard'
zinit snippet OMZ::lib/clipboard.zsh

alias -- -="cd -"

function list() {
}

function setup-clipboard() {
  bind '^v' clippaste
  bind '^c' clipcopy
}

function setup-completion-generator() {
  alias gencomp='zinit lucid nocd as"null" wait"1" atload"zinit creinstall -q _local/config-files; fast-zpcompinit" for /dev/null; gencomp'
}

function setup-enhancd() {
  ENHANCD_FILTER='fzf -0 -1 --ansi --preview="exa -l --git -h --git-ignore --color=always -a {}"'
  ENHANCD_HOOK_AFTER_CD="exa -l --git -h --git-ignore --color=always -a"
}

zinit as"program" light-mode lucid for \
  OMZ::plugins/fancy-ctrl-z/fancy-ctrl-z.plugin.zsh \
  OMZ::plugins/yarn/yarn.plugin.zsh \
  trigger-load'!nix-shell' \
  trigger-load'!cd' src"init.sh" atload"setup-enhancd" blockf b4b4r07/enhancd \
  trigger-load"!alias-finder" nocompletions OMZ::plugins/alias-finder/alias-finder.plugin.zsh \
  trigger-load'!gh' src"zsh/gh/gh.plugin.zsh" blockf brettm12345/gh \
  trigger-load'!x;!extract' blockf OMZ::plugins/extract/extract.plugin.zsh \
  trigger-load'!ga;!gcf;!gclean;!gd;!glo;!grh;!gss' wfxr/forgit \
  trigger-load'!gencomp' pick'zsh-completion-generator.plugin.zsh' blockf atload'setup-completion-generator' \
  RobSis/zsh-completion-generator

CARGO_HOME="$HOME/.cargo"
BROWSER="chromium"

typeset -U PATH path
path=("$HOME/bin" "$HOME/.npm/bin" "$CARGO_HOME/bin" "$HOME/.yarn/bin" "$HOME/.cabal/bin" "$HOME/.emacs.d/bin" "$path[@]") && export PATH

RPROMPT=""
GHQ_ROOT="$HOME/src"
