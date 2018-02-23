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
set fdc=1
set scrolloff=2

let mapleader=","

nmap <silent><leader>h :set hls!<CR>
" Toggle spell check on and off 
nmap <silent><leader>s :set spell!<CR>
nmap <silent><leader>v :tabnew $MYVIMRC<CR>
" Reselect last selected text (it doesn't care where it is)
nmap gV `[v`] 
nmap <silent><F4> :call ToggleQuickFix()<CR>
" Toggle fold (open|close)
nnoremap <Space> za
noremap H ^
noremap L $

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

" Terminal settings
tnoremap <C-[> <C-\><C-n>
let g:terminal_color_0  = '#2e3436'
let g:terminal_color_1  = '#cc0000'
let g:terminal_color_2  = '#4e9a06'
let g:terminal_color_3  = '#a000c4'
let g:terminal_color_4  = '#3465a4'
let g:terminal_color_5  = '#75507b'
let g:terminal_color_6  = '#0b939b'
let g:terminal_color_7  = '#d3d7cf'
let g:terminal_color_8  = '#555753'
let g:terminal_color_9  = '#ef2929'
let g:terminal_color_10 = '#8ae234'
let g:terminal_color_11 = '#fce94f'
let g:terminal_color_12 = '#729fcf'
let g:terminal_color_13 = '#ad7fa8'
let g:terminal_color_14 = '#00f5e9'
let g:terminal_color_15 = '#eeeeec'
" -------------------

nmap e ea

set colorcolumn=80
highlight ColorColumn guibg=darkgray

" Plugin section
call plug#begin('$USERPROFILE/AppData/nvim/plugged')

Plug 'rust-lang/rust.vim'       " Rust syntax highlighting
Plug 'scrooloose/nerdtree'      " Directory tree
Plug 'scrooloose/nerdcommenter' " Plugin that's allow to comment
Plug 'kien/ctrlp.vim'           " Fuzzy search files
Plug 'mbbill/undotree'          " Undotree for buffer with diff
Plug 'godlygeek/tabular'        " :Tab /{pattern} to align lines usign {pattern}
Plug 'tpope/vim-fugitive'       " Git wrapper for Vim
Plug 'jremmen/vim-ripgrep'      " Plugin for ripgrep CL utility
Plug 'cespare/vim-toml'         " Toml syntax
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'neomake/neomake'
Plug 'terryma/vim-multiple-cursors'

call plug#end()

" NERDTree
nmap <silent><F2> :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg', 'target']

" Ctrl-P
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.suo,*.sln,*.csproj,*.pdb,*.dll,*.cache,*.config,*.user,*.mdf,*.ldf,*.psm1,*.nupkg,*.psd1,*.manifest,*.ps1,*.transform,*.csproj.*
set wildignore+=*\\target\\*
"set wildignore+=*.xml

" Undotree
nnoremap <C-F5> :UndotreeToggle<CR>

" Fugitive
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gd :Gdiff<CR>

" deoplete
let g:deoplete#enable_at_startup=1

" LSP
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly-x86_64-pc-windows-msvc', 'rls']
\ }
" Automatically start language servers.
let g:LanguageClient_autoStart=1
nnoremap <silent>K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent>gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent><F1> :call LanguageClient_textDocument_references()<CR>

" neomake
call neomake#configure#automake('nw', 750)

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
