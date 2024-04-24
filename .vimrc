set number
syntax on

let mapleader=','
inoremap <leader>w <Esc>:w<cr>

inoremap jj <Esc>

"use ctrl+h/j/k/l switch window"
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

com! FormatJSON %!python3 -m jso.tool


call plug#begin('~/.vim/plugged')

Plug 'mhinz/vim-startify'

Plug 'junegunn/vim-easy-align'

Plug 'https://github.com/junegunn/seoul256.vim.git'

Plug 'fatih/vim-go', { 'tag': '*' }

Plug 'junegunn/fzf', { 'dir': '~/.fzf' }

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

Plug 'nsf/gocode', { 'rtp': 'vim' }

Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }

Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

Plug '~/my-prototype-plugin'

call plug#end()
