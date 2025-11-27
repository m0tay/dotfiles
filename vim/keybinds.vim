vim9script

g:mapleader = " "

nnoremap <leader>e :Ex<CR>


nnoremap <leader>w :write<CR>
nnoremap <leader>q :quit<CR>
nnoremap <leader>Q :qa<CR>
nnoremap <leader>o :update<CR> :source<CR>
nnoremap <leader>m :update<CR> :make<CR>

nnoremap <leader>y "+y
vnoremap <leader>y "+y

nnoremap <leader>d "+d
vnoremap <leader>d "+d

nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

vnoremap < <gv
vnoremap > >gv
