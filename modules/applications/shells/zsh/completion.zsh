#!/usr/bin/env zsh
setopt auto_list
setopt auto_menu

zstyle ':completion:*' use-compctl false


function _files_enhance() {
    _files -M '' \
        -M 'm:{[:lower:]-}={[:upper:]_}' \
        -M 'r:|[.,_-]=* r:|=*' \
        -M 'r:|.=* r:|=*'
}
# caching
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache yes
zstyle ':completion::complete:*' cache-path $XDG_CACHE_HOME/zsh

zstyle ':completion:*:*:*:*:*' menu true select search interactive
zstyle ':completion:*' list-grouped false
zstyle ':completion:*' list-separator ''
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:warnings' format '%F{red}%B-- No match for: %d --%b%f'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*:descriptions' format '[%d]'


## completion system
zstyle ':completion:*:approximate:'                 max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )' # allow one error for every three characters typed in approximate completer
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'              # don't complete backup files as executables
zstyle ':completion:*:correct:*'                    insert-unambiguous true             # start menu completion only if it could find no unambiguous initial string
zstyle ':completion:*:corrections'                  format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}' #
zstyle ':completion:*:correct:*'                    original true
zstyle ':completion:*:default'                      list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=00}:${(s.:.)LS_COLORS}")'
zstyle ':completion:*:descriptions'                 format $'\n%F{magenta}%U%B%d%b%u%f\n'
zstyle ':completion:*:*:cd:*:directory-stack'       menu yes select
zstyle ':completion:*:expand:*'                     tag-order all-expansions            # insert all expansions for expand completer
zstyle ':completion:*:history-words'                list false                          #
zstyle ':completion:*:history-words'                menu yes                            # activate menu
zstyle ':completion:*:history-words'                remove-all-dups yes                 # ignore duplicate entries
zstyle ':completion:*:history-words'                stop yes                            #
zstyle ':completion:*'                              matcher-list 'm:{a-z}={A-Z}'        # match uppercase from lowercase
zstyle ':completion:*:matches'                      group 'yes'                         # separate matches into groups
zstyle ':completion:*'                              group-name ''                       # group results by category
zstyle -e ':completion:*'                           special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'
zstyle ':completion:*:messages'                     format '%d'                         #
zstyle ':completion:*:options'                      auto-description '%d'               #
zstyle ':completion:*:options'                      description 'yes'                   # describe options in full
zstyle ':completion:*:processes'                    command 'ps -au$USER'               # on processes completion complete all user processes
zstyle ':completion:*:*:-subscript-:*'              tag-order indexes parameters        # offer indexes before parameters in subscripts
zstyle ':completion:*'                              verbose true                        # provide verbose completion information
zstyle ':completion:*:warnings'                     format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d' # set format for warnings
zstyle ':completion:*:*:zcompile:*'                 ignored-patterns '(*~|*.zwc)'       # define files to ignore for zcompile
zstyle ':completion:correct:'                       prompt 'correct to: %e'             #
zstyle ':completion::(^approximate*):*:functions'   ignored-patterns '_*'               # Ignore completion functions for commands you don't have:
zstyle ':completion::complete:*'                    gain-privileges 1                   # enabling autocompletion of privileged environments in privileged commands

# complete manual by their section
zstyle ':completion:*:manuals'                      separate-sections true
zstyle ':completion:*:manuals.*'                    insert-sections   true
zstyle ':completion:*:man:*'                        menu yes select


# Kill
zstyle ':completion:*:*:*:*:processes'              command 'ps -u $LOGNAME -o pid,user,command -w,nice'
zstyle ':completion:*:*:kill:*:processes'           list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*'                     menu yes select
zstyle ':completion:*:*:kill:*'                     force-list always
zstyle ':completion:*:*:kill:*'                     insert-ids single


# Media Players
zstyle ':completion:*:*:mpg123:*'                   file-patterns '*.(mp3|MP3):mp3\ files *(-/):directories'
zstyle ':completion:*:*:mpg321:*'                   file-patterns '*.(mp3|MP3):mp3\ files *(-/):directories'
zstyle ':completion:*:*:ogg123:*'                   file-patterns '*.(ogg|OGG|flac):ogg\ files *(-/):directories'
zstyle ':completion:*:*:mocp:*'                     file-patterns '*.(wav|WAV|mp3|MP3|ogg|OGG|flac):ogg\ files *(-/):directories'

# SSH/SCP/RSYNC
zstyle ':completion:*:(ssh|scp|rsync):*'            tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*'                group-order users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*'                        group-order users hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

# Fuzzy matching of completions
# https://grml.org/zsh/zsh-lovers.html
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle -e ':completion:*:approximate:*' \
  max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'

# In menu-style completion, give a status bar
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

## correction
# run rehash on completion so new installed program are found automatically:
_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1 # Because we didn't really complete anything
}

# host completion /* add brackets as vim can't parse zsh's complex cmdlines 8-) {{{ */
# [ -r ~/.ssh/known_hosts ] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
# [ -r /etc/hosts ] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()

hosts=(`hostname` "$_ssh_hosts[@]" "$_etc_hosts[@]" localhost)
zstyle ':completion:*:hosts' hosts $hosts

# Complete words from tmux pane(s) {{{1
# Source: http://blog.plenz.com/2012-01/zsh-complete-words-from-tmux-pane.html
# Gist: https://gist.github.com/blueyed/6856354
_tmux_pane_words()
{
    local expl
    local -a w
    if [[ -z "$TMUX_PANE" ]]; then
        _message "not running inside tmux!"
        return 1
    fi

    # Based on vim-tmuxcomplete's splitwords function.
    # https://github.com/wellle/tmux-complete.vim/blob/master/sh/tmuxcomplete
    _tmux_capture_pane()
    {
        tmux capture-pane -J -p -S -100 $@ |
            # Remove "^C".
            sed 's/\^C\S*/ /g' |
            # copy lines and split words
            sed -e 'p;s/[^a-zA-Z0-9_]/ /g' |
            # split on spaces
            tr -s '[:space:]' '\n' |
            # remove surrounding non-word characters
            =grep -o "\w.*\w"
    }
    # Capture current pane first.
    w=( ${(u)=$(_tmux_capture_pane)} )
    echo $w > /tmp/w1
    local i
    for i in $(tmux list-panes -F '#D'); do
        # Skip current pane (handled before).
        [[ "$TMUX_PANE" = "$i" ]] && continue
        w+=( ${(u)=$(_tmux_capture_pane -t $i)} )
    done
    _wanted values expl 'words from current tmux pane' compadd -a w
}

zle -C tmux-pane-words-prefix   complete-word _generic
zle -C tmux-pane-words-anywhere complete-word _generic
bindkey '^X^Tt' tmux-pane-words-prefix
bindkey '^X^TT' tmux-pane-words-anywhere
zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' completer _tmux_pane_words
zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' ignore-line current
# Display the (interactive) menu on first execution of the hotkey.
zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' menu yes select interactive
# zstyle ':completion:tmux-pane-words-anywhere:*' matcher-list 'b:=* m:{A-Za-z}={a-zA-Z}'
zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' matcher-list 'b:=* m:{A-Za-z}={a-zA-Z}'
# }}}
