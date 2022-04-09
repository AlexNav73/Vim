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
set icm=split
set termguicolors
set completeopt=menuone,noinsert,noselect

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

if has('persistent_undo')
    "let &undodir = expand('%:p:h') . '/undofiles/'
    set udf
endif

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
" let g:terminal_color_0  = '#073642'
" let g:terminal_color_1  = '#dc322f'
" let g:terminal_color_2  = '#859900'
" let g:terminal_color_3  = '#b58900'
" let g:terminal_color_4  = '#268bd2'
" let g:terminal_color_5  = '#d33682'
" let g:terminal_color_6  = '#2aa198'
" let g:terminal_color_7  = '#eee8d5'
" let g:terminal_color_8  = '#002b36'
" let g:terminal_color_9  = '#cb4b16'
" let g:terminal_color_10 = '#586e75'
" let g:terminal_color_11 = '#657b83'
" let g:terminal_color_12 = '#839496'
" let g:terminal_color_13 = '#6c71c4'
" let g:terminal_color_14 = '#93a1a1'
" let g:terminal_color_15 = '#fdf6e3'
" ----------------

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
Plug 'terryma/vim-multiple-cursors'
Plug 'itchyny/lightline.vim'    " Custom bottom bar
Plug 'mhinz/vim-startify'       " Start page with MRU files and cow :)
Plug 'chriskempson/base16-vim'  " Collection of the color themes
Plug 'kassio/neoterm'           " Wrapper of some vim/neovim's :terminal functions

Plug 'neovim/nvim-lspconfig'    " Collection of configurations for built-in LSP client
Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
Plug 'L3MON4D3/LuaSnip'         " Snippets plugin
Plug 'simrat39/rust-tools.nvim'
Plug 'hrsh7th/nvim-cmp'         " Autocompletion plugin
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-nvim-lsp'     " LSP source for nvim-cmp
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

call plug#end()

" Colors
set background=dark
colorscheme base16-atelier-dune

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

" rust.vim
let g:rustfmt_autosave = 1
let g:rust_fold = 1

" NeoTerm
let g:neoterm_shell = "powershell"
nnoremap <silent> <leader>p :vertical botright Ttoggle<CR><C-w>l

" LSP hotkeys (https://sharksforarms.dev/posts/neovim-rust/)
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" LSP config
lua <<EOF
    local nvim_lsp = require('lspconfig')

    local opts = {
        tools = { -- rust-tools options
            autoSetHints = true,
            hover_with_actions = true,
            inlay_hints = {
                show_parameter_hints = false,
                parameter_hints_prefix = "",
                other_hints_prefix = "",
            },
        },

        -- all the opts to send to nvim-lspconfig
        -- these override the defaults set by rust-tools.nvim
        -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
        server = {
            -- on_attach is a callback called when the language server attachs to the buffer
            -- on_attach = on_attach,
            settings = {
                -- to enable rust-analyzer settings visit:
                -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
                ["rust-analyzer"] = {
                    -- enable clippy on save
                    checkOnSave = {
                        command = "clippy"
                    },
                }
            }
        },
    }

    require('rust-tools').setup(opts)
EOF

" Autocompletion
lua <<EOF
    local cmp = require'cmp'
    cmp.setup({
      -- Enable LSP snippets
      snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
      },
      mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        -- Add tab support
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        })
      },

      -- Installed sources
      sources = {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'path' },
        { name = 'buffer' },
      },
    })
EOF

let g:quickfixstate = 0
function! ToggleQuickFix()
lua << EOF
    local set_var, nvim_command = vim.api.nvim_set_var, vim.api.nvim_command
    local quickfixstate = vim.api.nvim_get_var("quickfixstate")
    if vim.api.nvim_call_function("exists", {"g:quickfixstate"}) ~= 0 then
        if quickfixstate == 0 then
            set_var("quickfixstate", 1)
            nvim_command("copen")
        else
            set_var("quickfixstate", 0)
            nvim_command("ccl")
        end
    else
        print("Global variable `g:quickfixstate` is not defined")
    end
EOF
endfunction
