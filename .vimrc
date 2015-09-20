set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"
" " let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'kien/ctrlp.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'kchmck/vim-coffee-script'
Plugin 'easymotion/vim-easymotion'
Plugin 'bling/vim-airline'
Plugin 'vim-scripts/dbext.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'tomasr/molokai'
"Plugin 'klen/python-mode'
Plugin 'will133/vim-dirdiff'

call vundle#end()            " required
filetype plugin indent on    " required

au FocusLost * :wa
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*


set autowriteall
let g:EasyMotion_do_mapping = 0 " Disable default mappings
nmap s <Plug>(easymotion-s2)
omap s <Plug>(easymotion-s2)
" change the default EasyMotion shading to something more readable with
" Solarized
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set incsearch

set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4
syntax on
inoremap jj <Esc>


au BufEnter * setlocal cursorline
au BufLeave * setlocal nocursorline

let mapleader = "\<Space>"
nnoremap <Leader>x :bp\|bd #<CR> 
nnoremap <Leader>w :w<CR> 
nnoremap <Leader>p :CtrlPMRU<CR> 
nnoremap <Leader>g :Ggrep -w <C-r><C-w><CR>
nnoremap <Leader>d :bd<CR>

set laststatus=2

let g:ctrlp_use_caching = 0
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
set wildignore+=*/build/*
set wildignore+=*/testsResults/*

let g:pymode_rope = 0
let g:pymode_lint = 0

hi Search cterm=NONE ctermfg=grey ctermbg=blue

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['pylint']
nnoremap <Leader>c :w<CR>:SyntasticCheck<CR>

hi Folded ctermbg=black
set nonumber
if filereadable("~/.vimrc_sec")
    so ~/.vimrc_sec
endif


