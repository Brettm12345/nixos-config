" vim: foldmethod=marker foldlevel=2

" Neo/vim Settings
" ===

" General {{{
set mouse=nv                 " Disable mouse in command-line mode
set modeline                 " automatically setting options from modelines
set report=0                 " Don't report on line changes
set errorbells               " Trigger bell on error
set visualbell               " Use visual bell instead of beeping
set signcolumn=yes           " Always show signs column
set hidden                   " hide buffers when abandoned instead of unload
set fileformats=unix,dos,mac " Use Unix as the standard file type
set magic                    " For regular expressions turn magic on
set path=.,**                " Directories to search when using gf
set virtualedit=block        " Position cursor anywhere in visual block
set synmaxcol=1000           " Don't syntax highlight long lines
set formatoptions+=1         " Don't break lines after a one-letter word
set formatoptions-=t         " Don't auto-wrap text
if has('patch-7.3.541')
	set formatoptions+=j       " Remove comment leader when joining lines
endif

if has('vim_starting')
	set encoding=utf-8
	scriptencoding utf-8
endif

" Enables 24-bit RGB color in the TUI
set termguicolors

" What to save for views and sessions:
set viewoptions=folds,cursor,curdir,slash,unix
set sessionoptions=curdir,help,tabpages,winsize

if has('mac')
	let g:clipboard = {
		\   'name': 'macOS-clipboard',
		\   'copy': {
		\      '+': 'pbcopy',
		\      '*': 'pbcopy',
		\    },
		\   'paste': {
		\      '+': 'pbpaste',
		\      '*': 'pbpaste',
		\   },
		\   'cache_enabled': 0,
		\ }
endif

if has('clipboard')
	set clipboard& clipboard+=unnamedplus
endif

" }}}
" Wildmenu {{{
" --------
if has('wildmenu')
	set nowildmenu
	set wildmode=list:longest,full
	set wildoptions=tagfile
	set wildignorecase
	set wildignore+=.git,.hg,.svn,.stversions,*.pyc,*.spl,*.o,*.out,*~,%*
	set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store
	set wildignore+=**/node_modules/**,**/bower_modules/**,*/.sass-cache/*
	set wildignore+=application/vendor/**,**/vendor/ckeditor/**,media/vendor/**
	set wildignore+=__pycache__,*.egg-info,.pytest_cache
endif

" }}}
" Vim Directories {{{
" ---------------
set undofile swapfile nobackup
set directory=$DATA_PATH/swap//,$DATA_PATH,~/tmp,/var/tmp,/tmp
set undodir=$DATA_PATH/undo//,$DATA_PATH,~/tmp,/var/tmp,/tmp
set backupdir=$DATA_PATH/backup/,$DATA_PATH,~/tmp,/var/tmp,/tmp
set viewdir=$DATA_PATH/view/
set nospell spellfile=$VIM_PATH/spell/en.utf-8.add

" History saving
set history=1000
if has('nvim')
	set shada='300,<50,@100,s10,h
else
	set viminfo='300,<10,@50,h,n$DATA_PATH/viminfo
endif

" If sudo, disable vim swap/backup/undo/shada/viminfo writing
if $SUDO_USER !=# '' && $USER !=# $SUDO_USER
		\ && $HOME !=# expand('~'.$USER)
		\ && $HOME ==# expand('~'.$SUDO_USER)

	set noswapfile
	set nobackup
	set nowritebackup
	set noundofile
	if has('nvim')
		set shada="NONE"
	else
		set viminfo="NONE"
	endif
endif

" Secure sensitive information, disable backup files in temp directories
if exists('&backupskip')
	set backupskip+=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*
	set backupskip+=.vault.vim
endif

" Disable swap/undo/viminfo/shada files in temp directories or shm
augroup user_secure
	autocmd!
	silent! autocmd BufNewFile,BufReadPre
		\ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim
		\ setlocal noswapfile noundofile nobackup nowritebackup viminfo= shada=
augroup END

" }}}
" Tabs and Indents {{{
" ----------------
set textwidth=80    " Text width maximum chars before wrapping
set noexpandtab     " Don't expand tabs to spaces.
set tabstop=2       " The number of spaces a tab is
set softtabstop=2   " While performing editing operations
set shiftwidth=2    " Number of spaces to use in auto(indent)
set smarttab        " Tab insert blanks according to 'shiftwidth'
set autoindent      " Use same indenting on new lines
set smartindent     " Smart autoindenting on new lines
set shiftround      " Round indent to multiple of 'shiftwidth'

" }}}
" Timing {{{
" ------
set timeout ttimeout
set timeoutlen=750  " Time out on mappings
set updatetime=400  " Idle time to write swap and trigger CursorHold
set ttimeoutlen=10  " Time out on key codes

" }}}
" Searching {{{
" ---------
set ignorecase      " Search ignoring case
set smartcase       " Keep case when searching with *
set infercase       " Adjust case in insert completion mode
set incsearch       " Incremental search
set wrapscan        " Searches wrap around the end of the file
set showmatch       " Jump to matching bracket
set matchpairs+=<:> " Add HTML brackets to pair matching
set matchtime=1     " Tenths of a second to show the matching paren
set cpoptions-=m    " showmatch will wait 0.5s or until a char is typed
set showfulltag     " Show tag and tidy search in completion
"set complete=.      " No wins, buffs, tags, include scanning

if exists('+inccommand')
	set inccommand=nosplit
endif

if executable('rg')
	set grepformat=%f:%l:%m
	let &grepprg = 'rg --vimgrep' . (&smartcase ? ' --smart-case' : '')
elseif executable('ag')
	set grepformat=%f:%l:%m
	let &grepprg = 'ag --vimgrep' . (&smartcase ? ' --smart-case' : '')
endif

" }}}
" Behavior {{{
" --------
set nowrap                      " No wrap by default
set linebreak                   " Break long lines at 'breakat'
set breakat=\ \	;:,!?           " Long lines break chars
set nostartofline               " Cursor in same column for few commands
set whichwrap+=h,l,<,>,[,],~    " Move to following line on certain keys
set splitbelow splitright       " Splits open bottom right
set switchbuf=useopen,usetab    " Jump to the first open window in any tab
set switchbuf+=vsplit           " Switch buffer behavior to vsplit
set backspace=indent,eol,start  " Intuitive backspacing in insert mode
set diffopt=filler,iwhite       " Diff mode: show fillers, ignore whitespace
set completeopt=menuone         " Always show menu, even for one item
set completeopt+=noselect       " Do not select a match in the menu

if has('patch-7.4.775')
	" Do not insert any text for a match until the user selects from menu
	set completeopt+=noinsert
endif

if has('patch-8.1.0360') || has('nvim-0.4')
	set diffopt+=internal,algorithm:patience
	" set diffopt=indent-heuristic,algorithm:patience
endif

" }}}
" Editor UI {{{
" --------------------
set noshowmode          " Don't show mode in cmd window
set shortmess=aoOTI     " Shorten messages and don't show intro
set scrolloff=2         " Keep at least 2 lines above/below
set sidescrolloff=5     " Keep at least 5 lines left/right
set nonumber            " Don't show line numbers
set noruler             " Disable default status ruler
set list                " Show hidden characters

set showtabline=2       " Always show the tabs line
set winwidth=30         " Minimum width for active window
set winminwidth=10      " Minimum width for inactive windows
set winheight=4         " Minimum height for active window
set winminheight=1      " Minimum height for inactive window
set pumheight=15        " Pop-up menu's line height
set helpheight=12       " Minimum help window height
set previewheight=12    " Completion preview height

set showcmd             " Show command in status line
set cmdheight=2         " Height of the command line
set cmdwinheight=5      " Command-line lines
set equalalways         " Resize windows on split or close
set laststatus=2        " Always show a status line
set colorcolumn=80      " Highlight the 80th character limit
set display=lastline

if has('folding')
	set foldenable
	set foldmethod=syntax
	set foldlevelstart=99
endif

" UI Symbols
" icons:  ▏│ ¦ ╎ ┆ ⋮ ⦙ ┊ 
set showbreak=↪
set listchars=tab:\▏\ ,extends:⟫,precedes:⟪,nbsp:␣,trail:·
"set fillchars=vert:▉,fold:─

if has('patch-7.4.314')
	" Do not display completion messages
	set shortmess+=c
endif

if has('patch-7.4.1570')
	" Do not display message when editing files
	set shortmess+=F
endif

if has('conceal') && v:version >= 703
	" For snippet_complete marker
	set conceallevel=2 concealcursor=niv
endif

" }}}

" Enable 256 color terminal
set t_Co=256

" Paste
" Credits: https://github.com/Shougo/shougo-s-github
" ---
let &t_ti .= "\e[?2004h"
let &t_te .= "\e[?2004l"
let &pastetoggle = "\e[201~"

function! s:XTermPasteBegin(ret) abort
	setlocal paste
	return a:ret
endfunction

noremap  <special> <expr> <Esc>[200~ <SID>XTermPasteBegin('0i')
inoremap <special> <expr> <Esc>[200~ <SID>XTermPasteBegin('')
cnoremap <special> <Esc>[200~ <nop>
cnoremap <special> <Esc>[201~ <nop>

" Mouse settings
" ---
if has('mouse')
	if has('mouse_sgr')
		set ttymouse=sgr
	else
		set ttymouse=xterm2
	endif
endif

" Cursor-shape
" Credits: https://github.com/wincent/terminus
" ---
" Detect terminal
let s:tmux = exists('$TMUX')
let s:iterm = exists('$ITERM_PROFILE') || exists('$ITERM_SESSION_ID')
let s:iterm2 = s:iterm && exists('$TERM_PROGRAM_VERSION') &&
	\ match($TERM_PROGRAM_VERSION, '\v^[2-9]\.') == 0
let s:konsole = exists('$KONSOLE_DBUS_SESSION') ||
	\ exists('$KONSOLE_PROFILE_NAME')

" 1 or 0 -> blinking block
" 2 -> solid block
" 3 -> blinking underscore
" 4 -> solid underscore
" Recent versions of xterm (282 or above) also support
" 5 -> blinking vertical bar
" 6 -> solid vertical bar
let s:normal_shape = 0
let s:insert_shape = 5
let s:replace_shape = 3
if s:iterm2
	let s:start_insert = "\<Esc>]1337;CursorShape=" . s:insert_shape . "\x7"
	let s:start_replace = "\<Esc>]1337;CursorShape=" . s:replace_shape . "\x7"
	let s:end_insert = "\<Esc>]1337;CursorShape=" . s:normal_shape . "\x7"
elseif s:iterm || s:konsole
	let s:start_insert = "\<Esc>]50;CursorShape=" . s:insert_shape . "\x7"
	let s:start_replace = "\<Esc>]50;CursorShape=" . s:replace_shape . "\x7"
	let s:end_insert = "\<Esc>]50;CursorShape=" . s:normal_shape . "\x7"
else
	let s:cursor_shape_to_vte_shape = {1: 6, 2: 4, 0: 2, 5: 6, 3: 4}
	let s:insert_shape = s:cursor_shape_to_vte_shape[s:insert_shape]
	let s:replace_shape = s:cursor_shape_to_vte_shape[s:replace_shape]
	let s:normal_shape = s:cursor_shape_to_vte_shape[s:normal_shape]
	let s:start_insert = "\<Esc>[" . s:insert_shape . ' q'
	let s:start_replace = "\<Esc>[" . s:replace_shape . ' q'
	let s:end_insert = "\<Esc>[" . s:normal_shape . ' q'
endif

function! s:tmux_wrap(string)
	if strlen(a:string) == 0 | return '' | end
	let l:tmux_begin = "\<Esc>Ptmux;"
	let l:tmux_end = "\<Esc>\\"
	let l:parsed = substitute(a:string, "\<Esc>", "\<Esc>\<Esc>", 'g')
	return l:tmux_begin.l:parsed.l:tmux_end
endfunction

if s:tmux
	let s:start_insert = s:tmux_wrap(s:start_insert)
	let s:start_replace = s:tmux_wrap(s:start_replace)
	let s:end_insert = s:tmux_wrap(s:end_insert)
endif

let &t_SI = s:start_insert
if v:version > 704 || v:version == 704 && has('patch687')
	let &t_SR = s:start_replace
end
let &t_EI = s:end_insert

" Tmux specific settings
" ---
if s:tmux
	set ttyfast

	" Set Vim-specific sequences for RGB colors
	" Fixes 'termguicolors' usage in tmux
	" :h xterm-true-color
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

	" Assigns some xterm(1)-style keys to escape sequences passed by tmux
	" when 'xterm-keys' is set to 'on'.  Inspired by an example given by
	" Chris Johnsen at https://stackoverflow.com/a/15471820
	" Credits: Mark Oteiza
	" Documentation: help:xterm-modifier-keys man:tmux(1)
	execute "set <xUp>=\e[1;*A"
	execute "set <xDown>=\e[1;*B"
	execute "set <xRight>=\e[1;*C"
	execute "set <xLeft>=\e[1;*D"

	execute "set <xHome>=\e[1;*H"
	execute "set <xEnd>=\e[1;*F"

	execute "set <Insert>=\e[2;*~"
	execute "set <Delete>=\e[3;*~"
	execute "set <PageUp>=\e[5;*~"
	execute "set <PageDown>=\e[6;*~"

	execute "set <xF1>=\e[1;*P"
	execute "set <xF2>=\e[1;*Q"
	execute "set <xF3>=\e[1;*R"
	execute "set <xF4>=\e[1;*S"

	execute "set <F5>=\e[15;*~"
	execute "set <F6>=\e[17;*~"
	execute "set <F7>=\e[18;*~"
	execute "set <F8>=\e[19;*~"
	execute "set <F9>=\e[20;*~"
	execute "set <F10>=\e[21;*~"
	execute "set <F11>=\e[23;*~"
	execute "set <F12>=\e[24;*~"
endif
