function bind() {
  zle -N $2
  bindkey -v $1 $2
}

function with() {
  autoload -Uz $1
}

function load() {
  with $1
  zle -N $1
}

function execute-command() {
    local selected=$(printf "%s\n" ${(k)widgets} | fzf --reverse --prompt="cmd> " --height=10 )
    [[ $selected ]] && {
        zle redisplay
        zle $selected
    }
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
