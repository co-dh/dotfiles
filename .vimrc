"NeoBundle Scripts-----------------------------
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=/home/hao/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('/home/hao/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'easymotion/vim-easymotion'
NeoBundle 'bling/vim-airline'
NeoBundle 'vim-scripts/dbext.vim'
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tomasr/molokai'
"NeoBundle 'klen/python-mode'
NeoBundle 'will133/vim-dirdiff'
NeoBundle 'tmhedberg/SimpylFold'
NeoBundle 'Shougo/vimproc.vim', {'build' : {'linux' : 'make'}}
NeoBundle 'Quramy/tsuquyomi'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx'
"NeoBundle 'garbas/vim-snipmate'
"NeoBundle 'justinj/vim-react-snippets'


" You can specify revision/branch/tag.
"NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------


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
" hi link EasyMotionTarget ErrorMsg
" hi link EasyMotionShade  Comment

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
nnoremap <Leader>m :silent make\|redraw!\|cc<CR>
nmap <Leader>; <Plug>(easymotion-next)
nmap <Leader>, <Plug>(easymotion-prev)

set laststatus=2

let g:ctrlp_use_caching = 0
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
set wildignore+=*/build/*
set wildignore+=*/testsResults/*

let g:pymode_rope = 0
let g:pymode_lint = 0

colo molokai

hi Search cterm=NONE ctermfg=grey ctermbg=blue
hi Folded ctermbg=black
hi Normal ctermbg=black

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['pylint']
nnoremap <Leader>c :w<CR>:SyntasticCheck<CR>

set nonumber

let g:netrw_list_hide= '.*\.pyc$'

so ~/.vimrc_sec

let g:tsuquyomi_use_dev_node_module = 2
let g:tsuquyomi_tsserver_path = '/home/hao/node41/bin/tsserver'
let g:typescript_compiler_binary = '/home/hao/node41/bin/tsc'
