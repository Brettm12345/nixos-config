redraw-prompt() {
  local precmd
  for precmd in $precmd_functions; do
    $precmd
  done
  zle reset-prompt
}
zle -N redraw-prompt

bind() {
  zle -N $2
  bindkey -v $1 $2
}

with() {
  autoload -Uz $1
}

load() {
  with $1
  zle -N $1
}

open-project() {
  selection=$($HOME/bin/find-project)
  if [[ -z "$selection" ]]; then
    zle redisplay
    return 0
  fi
  cd "$selection"
  unset selection
  local ret=$?
  zle redraw-prompt
  return $ret
}
