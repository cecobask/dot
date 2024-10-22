let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'devsjc/vim-jb'
call plug#end()

colorscheme jb
filetype plugin indent on
syntax on
set autoindent
set backspace=indent,eol,start
set incsearch
set ruler
set wildmenu
set hidden
set tabstop=4
set shiftwidth=4
set expandtab
