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
