function bind() {
  zle -N $2
  bindkey -v $1 $2
}
