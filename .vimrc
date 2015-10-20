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
set smartcase " new
filetype off

" Cargo compilation
map ,cb :! cargo build<Enter>
map ,cr :! cargo run<Enter>
map ,cp :! cp ./target/debug/rsignal.dll ../../Programms\ on\ VS\ 2013/COS_Lab2/COS_Lab2/bin/x64/Debug/rsignal.dll<Enter>
map ,r :! ../../Programms\ on\ VS\ 2013/COS_Lab2/COS_Lab2/bin/x64/Debug/COS_Lab2.exe<Enter>
map ,t :! ../../Programms\ on\ VS\ 2013/COS_Lab1/WinApp/bin/x64/Debug/WinApp.exe<Enter>
" ---------------------

" Switch between pannels
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
"
" Switch between tabs
nmap gtp :tabp<Enter>
nmap gtw :tabnew<Enter>:e 
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

call vundle#end()
filetype plugin indent on

" NERDTree
nmap ,k :NERDTree<Enter> 
nmap ,l :NERDTreeClose<Enter>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg']

