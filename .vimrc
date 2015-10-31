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
set cursorline " enable cursor line highlited 
set backspace=indent,eol,start " enable delete with backspace existing text

" cterm=bold - remove underline from line
" cterm=053 - sets highlited line color == 053
hi CursorLine cterm=bold ctermbg=053

" Set default omni completion for SQL, PHP, JavaScript, CSS, HTML
filetype plugin on
set omnifunc=syntaxcomplete#Complete

filetype off

" Cargo compilation
map ,cb :! cargo build<CR>
map ,cr :! cargo run<CR>
" ---------------------

" Set enviroment and run programms
map ,cp :! cp ./target/debug/rsignal.dll ../../Programms\ on\ VS\ 2013/COS_Lab2/COS_Lab2/bin/x64/Debug/rsignal.dll<CR>
map ,r :! ../../Programms\ on\ VS\ 2013/COS_Lab2/COS_Lab2/bin/x64/Debug/COS_Lab2.exe<CR>
" ---------------------

" Switch between panes
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
" -------------------

" Resize panes with arrow keys
map OC <C-w><
map OD <C-w>>
map OA <C-w>-
map OB <C-w>+
" -------------------

" Switch between tabs
nmap gtp :tabp<CR>
nmap gtn :tabn<CR>
nmap gtw :tabnew<CR>:e 
" -------------------

nmap 0 ^
nmap e ea

let mapleader=" "

" set Runtime path to inc Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim

" this is the call to begin the Vundle Plugin Opperation
call vundle#begin()

Plugin 'gmarik/Vundle.vim' " Package manager itself 
Plugin 'rust-lang/rust.vim' " Rust syntax hightlighting 
Plugin 'scrooloose/nerdtree' " Directory tree 
Plugin 'scrooloose/nerdcommenter' " Plugin that's allow to cooment  
Plugin 'sjl/gundo.vim' " Undo tree
Plugin 'scrooloose/syntastic' " Syntax checker
Plugin 'bling/vim-airline' " cmdline and tabline bars

call vundle#end()
filetype plugin indent on

" NERDTree
nmap ,k :NERDTree<CR> 
nmap ,l :NERDTreeClose<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg']

" Gundo
nnoremap <F5> :GundoToggle<CR>

" Airlines
set laststatus=2
let g:airline_theme='bubblegum'
let g:airline#extensions#tabline#enabled = 1

" Ctrl-P
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.suo,*.sln,*.csproj

" +---------------------------+
" |                           |
" |       My functions        |
" |                           |
" +---------------------------+

autocmd BufRead,BufNewFile *.cs call CSSnippensSet()

function CSSnippensSet()
   " constructor snippet for c# ("ctor"<Space>)
   iab ctor public <C-c>?class<CR>wye''A<C-r>0()<CR>{<CR>}<C-c>ko
   iab for for (int i = a; i < a; i++)<CR>{<CR>}<C-c>kkfah
   iab cons Console.WriteLine();<C-c>hi
   iab prop public int Prop { get; set; }<C-c>FPviw
   
   set tabstop=4
   set shiftwidth=4
endfunction

function ExtractInterface()
    " Place cursor inside class defenition and :call ExtractInterface()
    normal ?classVj%ygP?cwinterfacewiIjviB:g/{\n\(get;\|set;\)\@!/:norm diB?interfacejviB:g/;$/dviB:g/{\n\(get;\|set;\)\@!/:norm djviB:g/^$/dviB:s/\((.*)\)/\1;

    "normal ?classVj%ygP?cwinterfacewiIjviB:g/\(get\(;\|\ *\(\n\|\).*{\)\|set\(;\|\ *\(\n\|\).*{\)\)\@!/:norm diB?interfacejviB:g/;$/dviB:g/\(get\(;\|\ *\(\n\|\).*{\)\|set\(;\|\ *\(\n\|\).*{\)\)\@!/:norm djviB:g/^$/dviB:s/\((.*)\)/\1;

    "g/\(get\(;\|\ *\(\n\|\).*{\)\|set\(;\|\ *\(\n\|\).*{\)\)/
    " 1:
    " {
    "      get
    "      {
    "      }
    "      set
    "      {
    "      }
    " }
    " 2:
    " {
    "      get { }
    "      set { }
    " }
    " 3:
    " { get { } set { } }
endfunction

