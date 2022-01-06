call plug#begin()
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-sandwich'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'josa42/vim-lightline-coc'
call plug#end()

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
