set nocompatible
syntax on
set tabstop=3
set shiftwidth=3
set expandtab
set rnu
set ruler
set ai
set si
set incsearch " highlight text while type searching string
set smartcase " new, can be added <set ignorecase>
set splitright " when split window, new pane will be on the right side
set nowrap " prevent text wrapping
filetype off

" Cargo compilation
map ,cb :! cargo build<CR>
map ,cr :! cargo run<CR>
" ---------------------

" Set enviroment and run programms
map ,cp :! cp ./target/debug/rsignal.dll ../../Programms\ on\ VS\ 2013/COS_Lab2/COS_Lab2/bin/x64/Debug/rsignal.dll<CR>
map ,r :! ../../Programms\ on\ VS\ 2013/COS_Lab2/COS_Lab2/bin/x64/Debug/COS_Lab2.exe<CR>
" ---------------------

" Switch between pannels
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" -------------------

" Switch between tabs
nmap gtp :tabp<CR>
nmap gtw :tabnew<CR>:e 
" -------------------

let mapleader=" "

" set Runtime path to inc Vundle and initialize

set rtp+=~/.vim/bundle/Vundle.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim

" this is the call to begin the Vundle Plugin Opperation

call vundle#begin()

Plugin 'gmarik/Vundle.vim' " Package manager itself 
Plugin 'wting/rust.vim' " Rust syntax hightlighting 
Plugin 'scrooloose/nerdtree' " Directory tree 
Plugin 'scrooloose/nerdcommenter' " Plugin that's allow to cooment  
Plugin 'sjl/gundo.vim' " Undo tree

call vundle#end()
filetype plugin indent on

" NERDTree
nmap ,k :NERDTree<CR> 
nmap ,l :NERDTreeClose<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg']

" Gundo
nnoremap <F5> :GundoToggle<CR>

" +---------------------------+
" |                           |
" |       My functions        |
" |                           |
" +---------------------------+

autocmd VimEnter *.cs call CSSnippensSet()

function CSSnippensSet()
   " constructor snippet for c# ("ctor"<Space>)
   iab ctor public <C-c>?class<CR>wyw''A<C-r>0()<CR>{<CR>}<C-c>ko
   iab for for (int i = a; i < a; i++)<CR>{<CR>}<C-c>kkfah
endfunction

