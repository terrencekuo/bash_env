" pre-requisite
" download:
"   - the silver searcher (ag)
"   - fuzy finder (fzf)

" to install the plugins in vundle call the following command
"     :PlugInstall

" *********************************
" vim plug
" *********************************

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" show color bar of vim mode at bottom the terminal
Plug 'vim-airline/vim-airline'

" show bars for the line indents
Plug 'Yggdroot/indentLine'

" PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run the install script
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" intelligently reopen files in the last edit place
Plug 'farmergreg/vim-lastplace'

" quickly jump to different code locations
Plug 'easymotion/vim-easymotion'

" comment code using gc and gcc
Plug 'tomtom/tcomment_vim'

" show file in the dir on the left panel
Plug 'scrooloose/nerdtree'

" quickly jump to different code locations
Plug 'tpope/vim-fugitive'

" show changes against git in gutter
Plug 'mhinz/vim-signify'

call plug#end()

" *********************************
" vim options: http://vimdoc.sourceforge.net/htmldoc/options.html
" *********************************

" include number in gutter
" the keyword set in vim is used for setting vim options
set number

" enable pasting
set paste

" rename the tmux window name to the file that is currently open
" also undo the tmux window name change once we leave vim
"
" NOTE: autocmd are powerful things that allow us to run
" run certain commands based on events that are happening. for
" more info: http://vimdoc.sourceforge.net/htmldoc/autocmd.html
"
" autocmd-intro
" you can specify commands to be executed automatically when reading
" or writing a file, when entering or leaving a buffer or window, and
" when exiting vim
"
" syntax
" autocmd {event} {pattern} {cmd}
"
" {event}       - VimLeave      - is an event that is fired when you leave a vim window
" {pattern}     - *             - pattern to match for all files
" {cmd}         - call system() - run the command 'tmux rename-window bash'
autocmd BufReadPre,BufReadPost,FileReadPre,FileReadPost,BufNew,BufNewFile,BufEnter,BufWinEnter,WinEnter,TabEnter * call system("tmux rename-window '" . expand("%:t") . "'")
autocmd VimLeave * call system("tmux rename-window bash")
set title

" dont jump when searching the file using #
"
" NOTE: key mapping is used to change the meaning of typed keys. the most common
" use is to define a sequence of commands for a function key
" more info: http://vimdoc.sourceforge.net/htmldoc/map.html
"
" differences between map, noremap, nnoremap is whether or not the mapping is
" recursive and which vim mode the mapping works for
" more info: http://vimdoc.sourceforge.net/htmldoc/map.html
" map - works for normal and visual mode (recursive)
" noremap - works for normal and visual mode (not recursive)
"
" nmap - works for normal mode (recursive)
" nnoremap - works for normal mode
"
" syntax
" map {original_key} {new_key_and_instructions}
"
" {original_key}        - #
" {new_key + instruc}   - :keepjumps normal! mi#`i<cr>
"                       - the : is used to show what we type when in vim normal mode
"                       - the keepjumps is the vim command
nnoremap # :keepjumps normal! mi#`i<cr>

"vim visual
" 1. enable syntax highlighting of code
" 2. set colorscheme
" 3. set background color
" 4. give vim support for 256 colors
syntax on
colorscheme slate
set background=dark
set t_Co=256

" change color of vim autocomplete popup menu
" https://vi.stackexchange.com/questions/12664/is-there-any-way-to-change-the-popup-menu-color
" https://jonasjacek.github.io/colors/
highlight Pmenu ctermbg=59 guibg=59
highlight PmenuSbar ctermbg=52 guibg=52
highlight PmenuSel ctermbg=52 guibg=52

"tabs
" 1. show existing tab with 4 space width
" 2. when indenting with tab, use 4 space width
" 3. on tab insert 4 spaces
" 4. autoindent based on last line
" 6. copy the previous indentation on autoindent
" 5. stricter rules for C prgrams
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set copyindent
set cindent

" show tabs and whitespace with symbols
set list
set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:⎵

" show the command you are typing from normal mode in bottom right
set showcmd

" this shows highlighting for brackets
set showmatch

" as you search, incrementally show the matches
set incsearch

" highlight the matched searches
set hlsearch

" don't beep
set visualbell
set noerrorbells
set novb

" use many levels of undo
set undolevels=1000

" change tab selected color
hi TabLineSel ctermfg=Red ctermbg=Blue

" turn off highlight with two esc and redraw screen for gitgutter work around
" nnoremap <esc><esc>       this is used to map the esc key
" :let _s=@/                this is stores the last search term
" :%s/\s\+$//e              this is searches and deletes the trailing whitespace
" let @/=_s                 this is restores the last search term
" :redraw!                  this is used to redraw the vim screen
" <bar>                     this is used to separate commands so you can run more than one
" silent! nohls             this is used to remove the highlighting
" <cr>                      this ends the mapping
nnoremap <esc><esc> :let _s=@/ <bar> :%s/\s\+$//e <bar> :let @/=_s <bar> :redraw! <bar> silent! nohls <bar> <cr>

" <Leader> is the \ keyboard input
" this enables one ot quickly do a search and replace
" the \< and \> are used for ensuring only complete words are found
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" prevent delay between switching vim modes
set ttimeoutlen=10

" set update time
set updatetime=50

" default vertical split is to the right
" default horizontal split is below
set splitbelow
set splitright

" setup 'x' so that it is sent to the black hole register
" (https://superuser.com/questions/102815/vim-cut-and-paste-history)
nnoremap x "_x

" map tn/tk/tj/th/tl to navigate through tabs
" the nnoremap allows you to use keywords when normal mode
"
" example
" when pressing tn keys we call the tabnew command and press space
" the : is used to show what we type when in vim normal mode
" the <CR> is a new line character to represent pressing entering after writing the vim character
nnoremap tn :tabnew<Space>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
nnoremap th :tabfirst<CR>
nnoremap tl :tablast<CR>

" map Ctrl+j/k/h/l to move between windows
" <C-j> represents pressing the ctrl key then the j key
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" use :Grep as opposed to :grep to open results in quick view window
command! -bar -nargs=1 Grep silent grep <q-args> | redraw! | cw

" NERDTree
" ctrl-n for opening NERDTree
"
" map {old_key} {new_instructions}
"
" {old_key}             - <C-n>                 - control key then n
" {new_instructions}    - :NERDTreeToggle<CR>   - command you would type in normal mode
map <C-n> :NERDTreeToggle<CR>

" ctrlp.vim - a full finder for vim
"
" the keyword let is for assigning a value to a variable
"
" to find out more about g look at :help internal-variables
" g is a Global

" here we have
"   let g:ctrlp_map = '<c-f>'
"
" let           keyword to assign a value to variable
" g:ctrl_map    global variable that is builtin from the ctrlp plugin
" '<c-f>'       new value inside that variable
"
"
" <leader> key is maped to \ key by default
" the \ key is used in vim. one example is searching when in normal mode
"
" 1. map cntrlp plugin to cntrl-f to allow native cntrl-p autocomplete
"       note: the 'let g' is used to set global settings for the ctrlp plugin
" 2. enable ctrlp to search ctags
"let g:ctrlp_map = '<c-f>'
"nnoremap <leader>. :CtrlPTag<cr>

" NOW USE FZF INSTEAD OF CTRLP
"
" this says when we press CTRL + f we will write :FZF + enter to bring up the fzf window
nnoremap <C-f> :FZF<CR>

" ctags - search for functions and variable definitions
" 1. add path to tags for linux
" 2. use ctags to open function definition horizontally (https://codeincomplete.com/posts/split-windows-and-tabs-in-vim/)
" note: included additional window shfit for make for vertical split
set tags=./tags,tags;
map <C-o> <C-w>s<C-]>
map <C-e> <C-w>v<C-]>

" easy motion - type 'ss' to trigger easy motion to start
"
" <Plug> is a special character meant to be mapped
nmap s <Plug>(easymotion-prefix)

" silver searcher (ag)
" make sure to download 'ag'
" https://robots.thoughtbot.com/faster-grepping-in-vim
" this opens results in a 'quickfix' window
"
" this if checks if the 'ag' system call is available on
" this system
if executable('ag')
    " if the 'ag' executable exists them we do the things
    " in this loop
    "
    " Use ag over grep
    set grepprg=ag\ --nogroup

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache but let's use it
    let g:ctrlp_use_caching = 1
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

