call plug#begin()
Plug 'Shougo/vimproc.vim'
Plug 'Quramy/tsuquyomi'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-unimpaired'
Plug 'rking/ag.vim'
Plug 'leafgarland/typescript-vim'
Plug 'jaxbot/semantic-highlight.vim'
Plug 'lambdatoast/elm.vim'
Plug 'tpope/vim-fugitive'
Plug 'zenorocha/dracula-theme', {'rtp': 'vim/'}
Plug 'kchmck/vim-coffee-script'
Plug 'vim-scripts/dbext.vim'
Plug 'tpope/vim-fugitive'
Plug 'fatih/vim-go'
"Plug 'rust-lang/rust.vim'
Plug 'zah/nim.vim'
Plug 'scrooloose/syntastico'
Plug 'eagletmt/ghcmod-vim'
Plug 'katusk/vim-qkdb-syntax'
Plug 'junegunn/vim-easy-align'
call plug#end()


let mapleader = "\<Space>"
let mapleader = "\<Space>"
nnoremap <Leader>x :bp\|bd #<CR> 
nnoremap <Leader>w :w<CR> 
nnoremap <Leader>p :CtrlPMRU<CR> 
nnoremap <Leader>g :Ggrep -w <C-r><C-w><CR>
nnoremap <Leader>d :bd<CR>
nnoremap <Leader>t :w<CR>:TsuReload<CR>:TsuGeterr<CR>
nnoremap <Leader>s :w<CR>:SyntasticCheck<CR>
nnoremap <Leader>b :w<CR>:GoBuild<CR>
nnoremap <Leader>r :w<CR>:GoRun<CR>

set cursorline
hi CursorLine term=underline ctermbg=4 guibg=#293739 

inoremap jj <Esc>
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set tabstop=4
set shiftwidth=4
set expandtab

set shell=/bin/bash
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

hi Search guibg='LightBlue' guifg='Black'
color dracula  

"let g:semanticEnableFileTypes = ['python', 'vim']

let g:dbext_default_profile_adgear_ro = 'type=PGSQL:integratedlogin=1:user=readonly:dbname=rtbopt:host=rtbopt-adgear.cja5vw8btxcx.us-east-1.rds.amazonaws.com'

au FileType go nmap <leader>r <Plug>(go-run)

set statusline+=%#warningmsg#
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['pylint', 'flake8']

autocmd FileType python,cpp autocmd BufWritePre <buffer> %s/\s\+$//e

"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/


let g:syntastic_typescript_tsc_fname = ''
let g:syntastic_html_tidy_ignore_errors=['proprietary attribute']

nmap ga <Plug>(EasyAlign)
set foldmethod=indent
