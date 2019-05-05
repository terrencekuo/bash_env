set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" vim plugins
"
" show bars for the line indents
Plugin 'Yggdroot/indentLine'
" show file in the dir on the left panel
Plugin 'scrooloose/nerdtree'
" comment code using gc and gcc
Plugin 'tomtom/tcomment_vim'
" show color bar of vim mode
Plugin 'vim-airline/vim-airline'
" quickly jump to different code locations
Plugin 'easymotion/vim-easymotion'
" enable git commands within vim
Plugin 'tpope/vim-fugitive'
" show changes against git in gutter
Plugin 'mhinz/vim-signify'
" fuzzy find files
Plugin 'ctrlpvim/ctrlp.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" include number in gutter
set number

" enable pasting
set paste

" rename the tmux window name to the file that is currently open
" also undo the tmux window name change once we leave vim
autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%"))
autocmd VimLeave * call system("tmux rename-window bash")
autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
set title

" enable syntax highlighting of code
" set colorscheme
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

" show tabs and whitespace
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
nnoremap tn :tabnew<Space>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
nnoremap th :tabfirst<CR>
nnoremap tl :tablast<CR>

" map Ctrl+j/k/h/l to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" use :Grep as opposed to :grep to open results in quick view window
command! -bar -nargs=1 Grep silent grep <q-args> | redraw! | cw

" NERDTree
" ctrl-n for opening NERDTree
map <C-n> :NERDTreeToggle<CR>

" ctrlp.vim - a full finder for vim
" 1. map cntrlp plugin to cntrl-f to allow native cntrl-p autocomplete
"       note: the 'let g' is used to set global settings for the ctrlp plugin
" 2. enable ctrlp to search ctags
let g:ctrlp_map = '<c-f>'
nnoremap <leader>. :CtrlPTag<cr>

" ctags - search for functions and variable definitions
" 1. add path to tags for linux
" 2. use ctags to open function definition horizontally (https://codeincomplete.com/posts/split-windows-and-tabs-in-vim/)
" note: included additional window shfit for make for vertical split
set tags=./tags,tags;
map <C-o> <C-w>s<C-]>
map <C-e> <C-w>v<C-]>

" easy motion - type 'ss' to trigger easy motion to start
nmap s <Plug>(easymotion-prefix)

" silver searcher (ag)
" make sure to download 'ag'
" https://robots.thoughtbot.com/faster-grepping-in-vim
" this opens results in a 'quickfix' window
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
