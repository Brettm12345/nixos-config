#!/usr/bin/env zsh

# Stuff I have copied and pasted from the internet
PROMPT_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
test -r "$PROMPT_CACHE" && source "$PROMPT_CACHE"

setopt autocd correct rcquotes notify globdots autoresume

export LESS="-FX"

function fast-zpcompinit() {
  setopt extendedglob local_options
  autoload -Uz compinit
  local zcompf="${ZINIT[ZCOMPDUMP_PATH]:-${ZDOTDIR:-$HOME}/.zcompdump}"
  # use a separate file to determine when to regenerate, as compinit doesn't always need to modify the compdump
  local zcompf_a="${zcompf}.augur"

  if [[ -e "$zcompf_a" && -f "$zcompf_a"(#qN.md-1) ]]; then
      compinit -C -d "$zcompf"
  else
      compinit -i -d "$zcompf"
      touch "$zcompf_a"
  fi
  # if zcompdump exists (and is non-zero), and is older than the .zwc file, then regenerate
  if [[ -s "$zcompf" && (! -s "${zcompf}.zwc" || "$zcompf" -nt "${zcompf}.zwc") ]]; then
      # since file is mapped, it might be mapped right now (current shells), so rename it then make a new one
      [[ -e "$zcompf.zwc" ]] && mv -f "$zcompf.zwc" "$zcompf.zwc.old"
      # compile it mapped, so multiple shells can share it (total mem reduction)
      # run in background
      zcompile -M "$zcompf" &!
  fi
}

function open-project() {
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

function rebuild() {
  dir=$(pwd)
  cd $HOME/src/github.com/brettm12345/nixos-config
  ./install
  cd $dir
}
alias re=rebuild

function with() {
  autoload -Uz $1
}

with edit-command-line; zle -N edit-command-line

with select-word-style; select-word-style shell

with url-quote-magic; zle -N self-insert url-quote-magic

function setup-autosuggest() {
  bindkey '^e' autosuggest-accept
  ZSH_AUTOSUGGEST_USE_ASYNC=1
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#5b6395"
}

zinit wait"0a" light-mode lucid for \
  sei40kr/zsh-fast-alias-tips \
  blockf zsh-users/zsh-completions \
  compile'{src/*.zsh,src/strategies/*}' atinit'setup-autosuggest' atload'!_zsh_autosuggest_start' \
    zsh-users/zsh-autosuggestions \

function setup-substring-search() {
  HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='underline'
  HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=''
  zle -N history-substring-search-up
  zle -N history-substring-search-down
  bindkey '^[OA' history-substring-search-up
  bindkey '^[OB' history-substring-search-down
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
}

zinit wait"0b" light-mode lucid nocompletions for \
  pick"autopair.zsh" hlissner/zsh-autopair \
  atload"KEYTIMEOUT=20"  softmoth/zsh-vim-mode \
  atload"bind_substring_search" zsh-users/zsh-history-substring-search \
  atinit"ZINIT[COMPINIT_OPTS]=-C; fast-zpcompinit; zpcdreplay" atpull"fast-theme XDG:overlay" \
    zdharma/fast-syntax-highlighting



zinit light-mode wait"0c" as"program" lucid for \
  zimfw/archive \
  from'gh-r' sei40kr/fast-alias-tips-bin \
  make"!" atclone"./direnv hook zsh > zhook.zsh" atpull"%atclone" pick"direnv" src"zhook.zsh" \
    direnv/direnv \
  make"!" src"./_shell/_pmy.zsh" pick"$ZPFX/bin/pmy" \
    relastle/pmy

zinit light-mode wait"1" lucid as"completion" for \
  OMZ::plugins/gatsby/_gatsby \
  OMZ::plugins/gitfast/_git

function set-enhancd-filter() {
  ENHANCD_FILTER='fzf -0 -1 --ansi --preview="exa -F --icons -l --git -h --git-ignore --color=always -a {}"'
}

zinit light-mode lucid for \
  OMZ::plugins/fancy-ctrl-z/fancy-ctrl-z.plugin.zsh \
  OMZ::plugins/yarn/yarn.plugin.zsh \
  trigger-load"!git" OMZ::lib/git.zsh \
  atinit"bindkey -v ^s sudo-command-line" OMZ::plugins/sudo/sudo.plugin.zsh \
  atinit"bindkey -v ^v clippaste; bindkey -v ^c clipcopy" OMZ::lib/clipboard.zsh \
  trigger-load'!cd' src"init.sh" atload"set_enhancd_filter" blockf \
    b4b4r07/enhancd \
  trigger-load"!alias-finder" nocompletions \
    OMZ::plugins/alias-finder/alias-finder.plugin.zsh \
  trigger-load'!gh' src"zsh/gh/gh.plugin.zsh" blockf \
    brettm12345/gh \
  trigger-load'!x;!extract' blockf \
    OMZ::plugins/extract/extract.plugin.zsh \
  trigger-load'!ga;!gcf;!gclean;!gd;!glo;!grh;!gss' \
    wfxr/forgit \
  trigger-load'!gencomp' pick'zsh-completion-generator.plugin.zsh' blockf \
  atload'alias gencomp="zinit lucid nocd as\"null\" wait\"1\" atload\"zinit creinstall -q _local/config-files; fast-zpcompinit\" for /dev/null; gencomp"' \
    RobSis/zsh-completion-generator

zinit ice depth=1 atload'!source ~/.config/zsh/p10k.zsh' atinit'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true'
zinit light romkatv/powerlevel10k

typeset -U PATH path
path=("$HOME/bin" "$path[@]") &&
export PATH

export GHQ_ROOT="$HOME/src"
RPROMPT=""

MODE_CURSOR_VICMD="block"
MODE_CURSOR_VIINS="blinking bar"
MODE_CURSOR_SEARCH="steady underline"

