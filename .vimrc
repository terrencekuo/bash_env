" setup vundle
set nocompatible               " be iMproved
filetype off                   " required!
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'

" My Bundles here:
"
" original repos on github
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'scrooloose/nerdtree'
Plugin 'tomtom/tcomment_vim'
Plugin 'vim-airline/vim-airline'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-fugitive'
Plugin 'mhinz/vim-signify'

call vundle#end()            " required
filetype plugin indent on    " required

" include number in gutter
set number

" enable syntax highlighting of code
" set colorscheme
syntax on
colorscheme slate
set background=dark
set t_Co=256

" allow prints to work
set paste

" change color of vim autocomplete popup menu
" https://vi.stackexchange.com/questions/12664/is-there-any-way-to-change-the-popup-menu-color
" https://jonasjacek.github.io/colors/
highlight Pmenu ctermbg=blue guibg=blue
highlight PmenuSbar ctermbg=black guibg=black
highlight PmenuSel ctermbg=black guibg=black

"tabs
" 1. show existing tab with 4 space width
" 2. when indenting with tab, use 4 space width
" 3. on tab insert 4 spaces
" 4. autoindent based on last line
" 5. stricter rules for C prgrams
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
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

" change tab selected color
hi TabLineSel ctermfg=Red ctermbg=Blue

" turn off highlight with two esc and redraw screen for gitgutter work around
nnoremap <esc><esc> :redraw! <bar> silent! nohls <cr>

" prevent delay between switching vim modes
set ttimeoutlen=50

" set update time
set updatetime=100

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





