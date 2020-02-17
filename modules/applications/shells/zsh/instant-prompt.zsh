PROMPT_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
test -r "$PROMPT_CACHE" && source "$PROMPT_CACHE"