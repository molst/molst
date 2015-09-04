set nocompatible              " be iMproved, required
filetype off                  " required

" set enable fuzzy find in vim if it's installed in the system
set rtp+=~/.fzf

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'rodjek/vim-puppet'
Plugin 'godlygeek/tabular' " not sure I need this
Plugin 'plasticboy/vim-markdown'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'ervandew/supertab'
Plugin 'PProvost/vim-ps1'
Plugin 'pangloss/vim-javascript'
" Plugin 'tpope/vim-surround' not sure I need this
Plugin 'vim-scripts/paredit.vim'
" Plugin 'scrooloose/nerdtree' not sure I need this, probably use vranger
" instead
Plugin 'altercation/vim-colors-solarized'
Plugin 'terryma/vim-expand-region'

" All of your Plugins must be added before the following line
call vundle#end()            " required
" " To ignore plugin indent changes, instead use:
" "filetype plugin on
" "
" " Brief help
" " :PluginList      - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line
"
" https://github.com/gmarik/Vundle.vim

syntax on
filetype plugin indent on
set tabstop=3
set shiftwidth=2
set softtabstop=2
set expandtab

set laststatus=2
set noshowmode
au! FileType ruby set tabstop=2 shiftwidth=2 softtabstop=2
au! FileType puppet set tabstop=2 shiftwidth=2 softtabstop=2
set encoding=utf-8
set t_Co=256
set mouse=a
set omnifunc=syntaxcomplete#Complete
set background=dark
colorscheme solarized

set hidden
let g:airline_powerline_fonts=2
