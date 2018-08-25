set global lintcmd %{
    pylintplus1()
    {
        pylint --msg-template='{path}:{line:}:{column}: {category}: {msg}' -rn -sn $1 \
        |awk '{split($0,a,":"); printf( "%s:%s:%s: %s: %s\n",a[1],a[2],a[3]+1,a[4],a[5])}'
    }
    pylintplus1  }

set global grepcmd 'rg --column'
map global normal <space> ,
map global normal , <space> 
map global normal <c-l> '<c-s><a-x><a-;>Gi:tmux-send-text<ret>j'
map global insert <c-l> '<esc><a-x><a-;>Gi:tmux-send-text<ret>jghi'
map global insert <c-a> <home>
map global insert <c-e> <end>
map global normal * <a-i>w*

def -override -docstring 'open file under current dircetory' edit-in-prj -params 1 -shell-candidates %{ag -l} %{edit %arg{1}}
def -override pwd 'echo %sh{pwd}'
def -override k -params 1 %{echo %sh{echo }}
colorscheme solarized-dark
#addhl global/ show_matching 
#addhl global/ column 120 Error

map -docstring 'command'               global user <space> :
map -docstring 'switch buffer'         global user B :b<space>
map -docstring 'switch buffer'         global user b :fzf-buffer<ret>
map -docstring 'Eval in Kak'           global user e :<space><c-r>.<ret>
map -docstring 'kill buffer'           global user k :<space>db<ret>
map -docstring 'reload q'              global user L :<space>write<ret>:<space>tmux-send-text<space>'\l<space><c-r>%'<ret>gll:send-text<ret>
map -docstring 'send select + ret'     global user l :<space>tmux-send-text<ret>gll:send-text<ret>
map -docstring '.head()'               global user h <a-i>w:<space>tmux-send-text<space><c-r>..head()<ret>gll:send-text<ret>
map -docstring 'grep-next-match'       global user n :<space>grep-next-match<ret>
map -docstring 'grep-previous-match'   global user N :<space>grep-previous-match<ret>
map -docstring 'Project'               global user p :fzf-file<ret>
map -docstring 'Function'              global user f :fzf-function<ret>
map -docstring 'Open file in git'      global user P :fzf-file<space>1<ret>
map -docstring 'write buffer'          global user w :<space>w<ret>
map -docstring 'grep'                  global user / :grep<space>
map -docstring 'grep word'             global user * <a-i>w:grep<space><c-r>.<ret> 
map -docstring 'quit'                  global user q :q<ret> 

hook global InsertChar \t %{ exec -draft h@ }

set global tabstop 4

set-option global toolsclient tools
set-option global docsclient docs
def sel-trailing-space -override %{exec '%s\h+$<ret>'}

hook -group UnCursor global InsertBegin .* %{ face window PrimaryCursor +u;                    addhl window/ws show-whitespaces -spc ' '}
hook -group UnCursor global InsertEnd   .* %{ face window PrimaryCursor rgb:002b36,rgb:839496; rmhl window/ws}


hook global BufCreate .*/?mk %{
    set-option buffer filetype makefile
}

def  -override -params 0..1 -docstring 'invoke fzf to open a file. If any argument, open from git room' \
  fzf-file %{eval %sh{
      if [ $# -ne 0 ]; then  
          FROM=" . $(git rev-parse --show-toplevel)"
      fi
      FILE=$(fd -t file $FROM | fzf-tmux --reverse --exact --preview='highlight -O ansi --force {} | head -n 100')
      if [ -n "$FILE" ]; then
        printf 'edit %%{%s}' "${FILE}"
      fi
} }

define-command -override gitroot %{cd %sh(git rev-parse --show-toplevel); pwd}
declare-user-mode git
map -docstring 'git'        global user g :enter-user-mode<space>git<ret> 
map -docstring 'blame'      global git b :git<space>blame<ret>
map -docstring 'hide-blame' global git B :git<space>hide-blame<ret>
map -docstring 'status'     global git s :git<space>status<ret>
map -docstring 'checkout'   global git c :git<space>checkout<space>
map -docstring 'diff'       global git d :git<space>diff<ret>
map -docstring 'log'        global git l :git<space>log<ret>
map -docstring 'cd root'    global git r :gitroot<ret>


define-command -override rcd -docstring "relative cd to current buffer" %{cd %sh{dirname ${kak_reg_percent} | tr --delete "'"}; pwd}
declare-user-mode toggle
map -docstring 'toggle/test'    global user t :enter-user-mode<space>toggle<ret>
map -docstring 'line off'       global toggle T :<space>rmhl<space>window/mynumber<ret>
map -docstring 'line on'        global toggle t :addhl<space>window/mynumber<space>number-lines<space>-relative<space>-hlcursor<ret>
map -docstring 'pwd'            global toggle p :pwd<ret>
map -docstring 'rcd'            global toggle c :rcd<ret>
map -docstring 'lint'           global toggle l :lint<ret>
map -docstring 'next error'     global toggle n :lint-next-error<ret>

def -override -docstring 'invoke fzf to select a buffer' \
  fzf-buffer %{eval %sh{
      BUFFER=$(printf %s\\n ${kak_buflist} | sed "s/'//g" |fzf-tmux --reverse --exact -d 15)
      if [ -n "$BUFFER" ]; then
        echo buffer ${BUFFER}
      fi
}}

def -override -docstring 'invoke fzf to select a python function' \
  fzf-function %{echo %sh{
      export FILE=${kak_buffile}
      FUN=$(grep -nE 'def|class ' ${kak_buffile} | fzf-tmux --delimiter=: --exact --no-sort --reverse --preview="sh -c 'tail -n +{1} ${kak_buffile}'" )
      if [ -n "$FUN" ]; then
        echo ${FUN}
      fi
}}

#sed 's/def //' | sed 's/(.*//' | # function browser
#--preview="sed -n '/def {}(/,/^def /p' ${kak_buffile}"
#

