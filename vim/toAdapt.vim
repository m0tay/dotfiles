vim9script

" Basic options
set number
set relativenumber
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set smartindent
set backspace=indent,eol,start
set filetype plugin indent on
set syntax on

" Search
set incsearch
set ignorecase
set smartcase
set hlsearch

" Undo and backup (no swap)
set undofile
set undodir=~/.vim/undodir
set backup
set backupdir=~/.vim/backup//
set noswapfile

" Quality of life
set lazyredraw
set ttyfast
set scrolloff=3
set sidescrolloff=5
set showcmd
set showmode
set ruler
set wildmenu
set wildmode=full

" Visuals
set cursorline
set colorcolumn=80
set matchpairs+=<:>,$:$

" Editing
set clipboard=unnamedplus
set autoread

" Autocommands
augroup vimrc_autocmds
  autocmd!
  autocmd FocusGained,BufEnter * checktime
  autocmd TextYankPost * silent! echo "Yanked"
augroup END

" Leader key and new mappings (never remap existing)
g:mapleader = " "

" File explorer
nnoremap <leader>e :Ex<CR>

" Save, quit, update, make
nnoremap <leader>w :write<CR>
nnoremap <leader>q :quit<CR>
nnoremap <leader>Q :qa<CR>
nnoremap <leader>o :update<CR> :source<CR>
nnoremap <leader>m :update<CR> :make<CR>

" Clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>d "+d
vnoremap <leader>d "+d

" Center search results
nnoremap <leader>n nzzzv
nnoremap <leader>N Nzzzv
nnoremap <leader>d <C-d>zz
nnoremap <leader>u <C-u>zz

" Reselect after indent
vnoremap <leader>< <gv
vnoremap <leader>> >gv

" Colorscheme
set termguicolors
set laststatus=2
set background=dark
colorscheme default
