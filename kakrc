hook global WinSetOption filetype=python %{
    set global lintcmd kak_pylint
    lint-enable
}

set global grepcmd 'rg --column'
map global normal <space> ,
map global normal , <space>
map global normal <c-t> '<c-s><a-x><a-;>Gi:send-text<ret><c-o>i'
map global insert <c-t> '<esc><c-s><a-x><a-;>Gi:send-text<ret><c-o>i'
map global insert <c-a> <home>
map global insert <c-e> <end>
map global normal * <a-i>w*
map global normal f <c-s>f
map global normal v <a-i>

# When I don't have ErgoDox
#map global normal h m
#map global normal j n
#map global normal k e
#map global normal m h
#map global normal n j
#map global normal e k

def -override pwd 'echo %sh{pwd}'

evaluate-commands %sh{
    if [ -z "$TMUX" ]; then
        echo ""
    else
        echo "colorscheme github"
    fi
}

addhl global/ column 120 Error

map -docstring 'command'               global user <space> :
map -docstring 'cpp-alternative-file'  global user a :cpp-alternative-file<ret>
map -docstring 'align by | '           global user | s\|<ret>&
map -docstring 'load q block'          global user B <a-i>p<a-|>dd<space>of=/tmp/dh.q<ret>:send-text<space>'\l<space>/tmp/dh.q'<ret>ghh:send-text<ret>
map -docstring 'switch buffer'         global user b :fzf-buffer<ret>
map -docstring 'ctags-search'          global user c :ctags-search<ret>
map -docstring 'Eval in Kak'           global user e :<space><c-r>.<ret>
map -docstring 'search'                global user f :fzf-search<space><c-r>.<ret>
map -docstring 'kill buffer'           global user k :<space>db<ret>
map -docstring 'reload q'              global user L :<space>write<ret>:<space>tmux-send-text<space>'\l<space><c-r>%'<ret>gll:send-text<ret>
map -docstring 'send select + ret'     global user l :tmux-send-text<ret><c-s>ghh:send-text<ret><c-o>
map -docstring 'repl-ver'              global user v :tmux-repl-vertical<ret>
map -docstring 'make'                  global user m :make<ret>
map -docstring 'grep-next-match'       global user n :<space>grep-next-match<ret>
map -docstring 'grep-previous-match'   global user N :<space>grep-previous-match<ret>
map -docstring 'Project'               global user p :fzf-file<ret>
map -docstring 'Open file in git'      global user P :fzf-file<space>1<ret>
map -docstring 'write buffer'          global user w :<space>w<ret>
map -docstring 'grep'                  global user / :fzf-grep<space>
#map -docstring 'grep buffer'           global user G :grep<space>-wg<space><c-r>%<space><c-r>.<ret>
map -docstring 'plan grep word. '      global user G <a-i>w:grep<space>-w<space><c-r>.<ret>
map -docstring 'grep word'             global user * <a-i>w:fzf-grep<space>-w<space><c-r>.<ret>
map -docstring 'quit'                  global user q :q<ret>
map -docstring 'repl-ver'              global user v :tmux-repl-vertical<ret>
map -docstring 'new-vert'              global user V :tmux-terminal-vertical<space>kak<space>-c<space>%val{session}<ret>

hook global InsertChar \t %{ exec -draft h@ }

set global tabstop 4

set-option global toolsclient tools
set-option global docsclient docs
def sel-trailing-space -override %{exec '%s\h+$<ret>'}

hook -group UnCursor global InsertBegin .* %{ face window PrimaryCursor +u;                    addhl window/ws show-whitespaces -spc ' '}
hook -group UnCursor global InsertEnd   .* %{ face window PrimaryCursor rgb:002b36,rgb:839496; rmhl window/ws}

# To tell which window is focused.
hook global FocusIn .*  %{ addhl window/line number-lines -relative -hlcursor}
hook global FocusOut .* %{ rmhl window/line}

add-highlighter global/match  show-matching

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
map -docstring 'git'        global user g :enter-user-mode<space>-lock<space>git<ret>
map -docstring 'blame'      global git b :git<space>blame<ret>
map -docstring 'hide-blame' global git B :git<space>hide-blame<ret>
map -docstring 'status'     global git s :git<space>status<ret>
map -docstring 'commit'     global git c :git<space>commit<space>-m<space>
map -docstring 'checkout'   global git C :git<space>checkout<space>
map -docstring 'diff'       global git d :git<space>diff<space>
map -docstring 'log'        global git l :git<space>log<ret>
map -docstring 'cd root'    global git r :gitroot<ret>
map -docstring 'add'        global git a :git<space>add<space>

map global normal <c-l> '<c-s><a-x><a-;>Gi:tmux-send-text<ret>j'
map global insert <c-l> '<esc><a-x><a-;>Gi:tmux-send-text<ret>jghi'
map global normal <c-l> ':send-line<ret>'

define-command -override send-line %{ execute-keys <c-s><a-x>:tmux-send-text<ret><c-o> }
define-command -override -params 1 send-word %{ execute-keys i %arg{1} <space><esc>:send-line<ret>gi }
declare-user-mode kk
map -docstring 'kk' global normal k :enter-user-mode<space>-lock<space>kk<ret>

map -docstring 'dup'    global kk d :send-word<space>dup<ret> 
map -docstring 'enlist' global kk , :send-word<space>enlist<ret> 
map -docstring 'count'  global kk c :send-word<space>count<ret> 
map -docstring 'Each'   global kk \' iEach[<esc>ea]<esc><a-b>:send-line<ret>gi;
map -docstring 'Group'  global kk g :send-word<space>Group<ret>
map -docstring 'idesc'  global kk > :send-word<space>Idesc<ret>
map -docstring 'First'  global kk 0 :send-word<space>First<ret>
map -docstring '='      global kk = :send-word<space>Eq<ret>
map -docstring 'where'  global kk & :send-word<space>Where<ret>
map -docstring 'swap'   global kk s :send-word<space>swap<ret>
map -docstring '@'      global kk @ :send-word<space>At<ret>

def -override rcd -docstring "cd to current buffer" %{cd %sh{dirname ${kak_reg_percent} | tr --delete "'"}; pwd}
declare-user-mode toggle
map -docstring 'toggle'      global user t :enter-user-mode<space>toggle<ret>
map -docstring 'line off'    global toggle T :<space>rmhl<space>window/line<ret>
map -docstring 'line on' global toggle t ':addhl window/line number-lines -relative -hlcursor<ret>'
map -docstring 'pwd'         global toggle p :pwd<ret>
map -docstring 'rcd'         global toggle c :rcd<ret>
map -docstring 'lint'        global toggle l :lint<ret>
map -docstring 'next error'  global toggle n :lint-next-error<ret>

def -override -docstring 'invoke fzf to select a buffer' \
  fzf-buffer %{eval %sh{
      BUFFER=$(printf %s\\n ${kak_buflist} | sed "s/'//g" |fzf-tmux --reverse --exact -d 15 )
      if [ -n "$BUFFER" ]; then
        echo buffer ${BUFFER}
      fi
}}

def -override -docstring 'search word inside buffer' -params 1 \
  fzf-search %{execute-keys %sh{
      export FILE=${kak_buffile}
      FUN=$(grep --color=always -nE $1 ${kak_buffile} | fzf-tmux --ansi --delimiter=: --exact --no-sort --reverse --preview="highlight -O ansi --force ${kak_buffile} | tail -n +{1}")
      if [ -n "$FUN" ]; then
        echo "$(echo ${FUN}| cut -d: -f 1)g"
      fi
}}

hook global WinSetOption filetype=rust %{
    set window formatcmd 'rustfmt'
}

def -override -docstring 'grep in current folder' -params 1.. \
  fzf-grep %{eval %sh{
      FILE=$(rg --color always -n "$@" | fzf-tmux --exit-0 --exact --no-sort --ansi --delimiter=: --layout=reverse --preview="highlight -O ansi --force {1} | tail -n +{2}")
      if [ -n "$FILE" ]; then
        echo "$(echo "edit -existing ${FILE}"| cut -d: -f 1,2 | tr : " ")"
      fi
}}

set-face global search +bi
add-highlighter global/search dynregex '%reg{/}' 0:search

hook global BufCreate .*\.nasm$ %{
    set-option buffer filetype gas
}
