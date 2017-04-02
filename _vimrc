set nocompatible
syntax on
set tabstop=4
set shiftwidth=4
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
set hidden
set autochdir
set fileencodings=utf-8,cp1251,cp866,koi8-r
set lines=50 columns=200

let mapleader=","

" Set default omni completion for SQL, PHP, JavaScript, CSS, HTML
filetype plugin on
set omnifunc=syntaxcomplete#Complete

nmap <silent><leader>h :set hls!<CR>
" Toggle spell check on and off 
nmap <silent><leader>s :set spell!<CR>
nmap <silent><leader>v :tabnew ~/_vimrc<CR>
" Reselect last selected text (it doesn't care where it is)
nmap gV `[v`] 
" Toggle fold (open|close)
nnoremap <Space> za
nmap <silent><F4> :call ToggleQuickFix()<CR>

" Switch between panes
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
" -------------------

" Resize panes with arrow keys
map <Left> <C-w>>
map <Right> <C-w><
map <Down> <C-w>+
map <Up> <C-w>-
" -------------------

" Switch between tabs
nmap <C-Tab> :tabp<CR>
nmap <leader>tw :tabnew<CR>
" -------------------

nmap e ea

colorscheme evening

set colorcolumn=80
highlight ColorColumn guibg=darkgray

" set Runtime path to inc Vundle and initialize
set rtp+=$HOME/vimfiles/bundle/Vundle.vim/
set runtimepath^=$HOME/vimfiles/bundle/ctrlp.vim

filetype off

" this is the call to begin the Vundle Plugin Opperation
call vundle#begin('$USERPROFILE/vimfiles/bundle/')

Plugin 'gmarik/Vundle.vim'        " Package manager itself
Plugin 'rust-lang/rust.vim'       " Rust syntax highlighting
Plugin 'scrooloose/nerdtree'      " Directory tree
Plugin 'scrooloose/nerdcommenter' " Plugin that's allow to comment
Plugin 'kien/ctrlp.vim'           " Fuzzy search files
Plugin 'mbbill/undotree'          " Undotree for buffer with diff
Plugin 'tpope/vim-dispatch'       " Async `make` command
Plugin 'godlygeek/tabular'        " :Tab /{pattern} to align lines usign {pattern}
Plugin 'tpope/vim-fugitive'       " Git wrapper for Vim
Plugin 'Shougo/neocomplete.vim'   " Syntax completion on the fly
Plugin 'racer-rust/vim-racer'     " Rust-lang completion engine
Plugin 'jremmen/vim-ripgrep'      " Plugin for ripgrep CL utility
Plugin 'majutsushi/tagbar'        " Tagbar support
Plugin 'cespare/vim-toml'         " Toml syntax

call vundle#end()
filetype plugin indent on

" Tagbar
let g:tagbar_ctags_bin='ctags'
nmap <silent><F8> :TagbarToggle<CR>
 let g:tagbar_type_rust = {
     \ 'ctagstype' : 'rust',
     \ 'kinds' : [
         \'T:types,type definitions',
         \'f:functions,function definitions',
         \'g:enum,enumeration names',
         \'s:structure names',
         \'m:modules,module names',
         \'c:consts,static constants',
         \'t:traits,traits',
         \'i:impls,trait implementations',
     \]
     \}

" Racer
let g:racer_cmd = '$USERPROFILE/.cargo/bin/racer'
let $RUST_SRC_PATH = "E:/Program/RustSourceCode/rust/src/"
let g:racer_experimental_completer = 1

au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

" Neocomplete
let g:neocomplete#enable_at_startup = 1

" Fugitive
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gd :Gdiff<CR>

" Undotree
nnoremap <C-F5> :UndotreeToggle<CR>

" NERDTree
nmap <silent><F2> :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg', 'target']

" Ctrl-P
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.suo,*.sln,*.csproj,*.pdb,*.dll,*.cache,*.config,*.user,*.mdf,*.ldf,*.psm1,*.nupkg,*.psd1,*.manifest,*.ps1,*.transform,*.csproj.*
set wildignore+=*\\target\\*
"set wildignore+=*.xml

" +---------------------------+
" |                           |
" |       My functions        |
" |                           |
" +---------------------------+

au FileType cs call CSSnippensSet()
au FileType rust call SetupRustCompiler()
" Apply any changes when .vimrc is saved
au BufWrite,BufWritePost _vimrc source $MYVIMRC

function! CSSnippensSet()
   " To create .NET Core project, you need to exec `dotnet new` in project folder
   " Than `dotnet restore` to initialize project dependencies
   " After that, you can `dotnet build` and `dotnet run` solution

   " constructor snippet for c# ("ctor"<Space>)
   iab ctor public <C-c>?class<CR>wye''A<C-r>0()<CR>{<CR>}<C-c>ko
   iab for for (int i = a; i < a; i++)<CR>{<CR>}<C-c>kkfah
   iab foreach foreach(var ITEM in ITEMS)<CR>{<CR>}<C-c>kkfI
   iab cw Console.WriteLine();<C-c>hi
   iab cr Console.ReadKey();<C-c>
   iab prop public TYPE NAME { get; set; }<C-c>FT
endfunction

function! SetupRustCompiler()
   compiler cargo
   nnoremap <silent><F7> :Make build<CR>
   nnoremap <silent><F5> :Make run<CR>
endfunction

let g:quickfixstate = 0
function! ToggleQuickFix()
    if !exists("g:quickfixstate")
        let g:quickfixstate = 0
    endif

    if g:quickfixstate == 0
        let g:quickfixstate = 1
        copen
    else
        let g:quickfixstate = 0
        ccl
    endif
endfunction

set directory=.,$TEMP

