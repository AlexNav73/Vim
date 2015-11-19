set nocompatible
syntax on
set tabstop=3
set shiftwidth=3
set expandtab
set nu
set rnu
set ruler
set ai
set si
set incsearch " highlight text while type searching string
set smartcase " new, can be added <set ignorecase>
set splitright " when split window, new pane will be on the right side
set nowrap " prevent text wrapping
set cursorline " enable cursor line highlighted
set backspace=indent,eol,start " enable delete with backspace existing text

" cterm=bold - remove underline from line
" cterm=053 - sets highlighted line color == 053
hi CursorLine cterm=bold ctermbg=053

" Set default omni completion for SQL, PHP, JavaScript, CSS, HTML
filetype plugin on
"set omnifunc=syntaxcomplete#Complete
"setlocal spell spelllang=en_us

filetype off

" Set environment and run programs
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
Plugin 'rust-lang/rust.vim' " Rust syntax highlighting
Plugin 'scrooloose/nerdtree' " Directory tree
Plugin 'scrooloose/nerdcommenter' " Plugin that's allow to comment
Plugin 'sjl/gundo.vim' " Undo tree
Plugin 'scrooloose/syntastic' " Syntax checker
Plugin 'bling/vim-airline' " cmdline and tabline bars
Plugin 'kien/ctrlp.vim' " Fuzzy search files

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
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.suo,*.sln,*.csproj,*.pdb,*.dll,*.cache,*.config,*.user,*.mdf,*.ldf,*.psm1,*.nupkg,*.psd1,*.manifest,*.ps1,*.transform
set wildignore+=*.csproj.*
set wildignore+=*.xml

" +---------------------------+
" |                           |
" |       My functions        |
" |                           |
" +---------------------------+

autocmd BufRead,BufNewFile *.cs call CSSnippensSet()
autocmd BufRead,BufNewFile *.rs call SetupRustCompiler()

function CSSnippensSet()
   " constructor snippet for c# ("ctor"<Space>)
   iab ctor public <C-c>?class<CR>wye''A<C-r>0()<CR>{<CR>}<C-c>ko
   iab for for (int i = a; i < a; i++)<CR>{<CR>}<C-c>kkfah
   iab cons Console.WriteLine();<C-c>hi
   iab prop public TYPE NAME { get; set; }<C-c>FT

   set tabstop=4
   set shiftwidth=4
endfunction

function SetupRustCompiler()
   compiler cargo
endfunction

function ExtractInterface()
    " Place cursor inside class definition and :call ExtractInterface()
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

