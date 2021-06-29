hook global WinSetOption filetype=python %{
    set global lintcmd kak_pylint
    lint-enable
}

#set global grepcmd 'rg --column'
map global normal <space> ,
map global normal , <space>
map global normal <c-l> '<c-s><a-x><a-;>Gi:tmux-send-text<ret>j'
map global insert <c-l> '<esc><a-x><a-;>Gi:tmux-send-text<ret>jghi'
map global insert <c-a> <home>
map global insert <c-e> <end>
#map global normal * <a-i>w*
map global normal f <c-s>f
map global normal v <a-i>

map global normal <c-w> <a-i>w

# When I don't have ErgoDox
#map global normal h m
#map global normal j n
#map global normal k e
#map global normal m h
#map global normal n j
#map global normal e k

def -override pwd 'echo %sh{pwd}'

#evaluate-commands %sh{
    #if [ -z "$TMUX" ]; then
        #echo ""
    #else
        ##echo "colorscheme solarized-light"
    #fi
#}

addhl global/ column 100 Error

map -docstring 'command'               global user <space> :
map -docstring 'cpp-alternative-file'  global user a :cpp-alternative-file<ret>
map -docstring 'align by | '           global user | s\|<ret>&
map -docstring 'load q block'          global user B <a-i>p<a-|>dd<space>of=/tmp/dh.q<ret>:tmux-send-text<space>'\l<space>/tmp/dh.q'<ret>ghh:tmux-send-text<ret>
map -docstring 'switch buffer'         global user b :fzf-buffer<ret>
map -docstring 'ctags-search'          global user c :ctags-search<ret>
map -docstring 'escape'                global user e :tmux-send-slash<ret>:tmux-send-line<ret>
map -docstring 'escape'                global user d :tmux-send-text<space>"echo<space>$"<ret>:tmux-send-text<ret>:tmux-send-line<ret>
map -docstring 'Eval in Kak'           global user E :<space><c-r>.<ret>
map -docstring 'search'                global user f :fzf-search<space>'<c-r>.'<ret>
map -docstring 'Focus'                 global user F :set-option<space>global<space>tmux_repl_id<space>'%
map -docstring 'kill buffer'           global user k :<space>db<ret>
map -docstring 'kill'                  global user K :<space>kill<ret>
map -docstring 'reload q'              global user L :<space>write<ret>:<space>tmux-send-text<space>'\l<space><c-r>%'<ret>gll:send-text<ret>
map -docstring 'send select + ret'     global user l :tmux-send-text<ret>:tmux-send-line<ret>
map -docstring 'repl-ver'              global user v :tmux-repl-vertical<ret>
map -docstring 'make'                  global user m :wa<ret>:make<ret>
map -docstring 'grep-next-match'       global user n :<space>grep-next-match<ret>
map -docstring 'grep-previous-match'   global user N :<space>grep-previous-match<ret>
map -docstring 'Project'               global user p :fzf-file<ret>
map -docstring 'Open file in git'      global user P :fzf-file<space>1<ret>
map -docstring 'write buffer'          global user w :<space>w<ret>
map -docstring 'grep'                  global user / :fzf-grep<space>
#map -docstring 'grep buffer'           global user G :grep<space>-wg<space><c-r>%<space><c-r>.<ret>
map -docstring 'plan grep word. '      global user G <a-i>w:grep<space>-w<space><c-r>.<ret>
map -docstring 'grep word'             global user * :fzf-grep<space>-w<space><c-r>.<ret>
map -docstring 'quit'                  global user q :q<ret>
map -docstring 'repl-ver'              global user v :tmux-repl-vertical<ret>
map -docstring 'new-vert'              global user V :tmux-terminal-vertical<space>kak<space>-c<space>%val{session}<ret>
map -docstring 'underline -'           global user u 'xypjx_s.<ret>r- /xxx<ret><esc>'
map -docstring 'underline ='           global user = 'xypjx_s.<ret>r= /xxx<ret><esc>'

hook global InsertChar \t %{ exec -draft h@ }

set global tabstop 4

#set-option global toolsclient tools
#set-option global docsclient docs
def sel-trailing-space -override %{exec '%s\h+$<ret>'}


hook global ModeChange push:normal:insert %{ face window PrimaryCursor +u;  addhl window/ws show-whitespaces -spc ' '}
hook global ModeChange  pop:insert:normal %{ face window PrimaryCursor rgb:002b36,rgb:839496; rmhl window/ws}

# To tell which window is focused.
#hook global FocusIn .*  %{ addhl window/line number-lines -relative -hlcursor}
#hook global FocusOut .* %{ rmhl window/line}

remove-highlighter global/match
add-highlighter global/match  show-matching

hook global BufCreate .*/?mk %{
    set-option buffer filetype makefile
}

def  -override -params 0..1 -docstring 'invoke fzf to open a file. If any argument, open from git room' \
  fzf-file %{eval %sh{
      if [ $# -ne 0 ]; then
          FROM=" $(git rev-parse --show-toplevel)"
      else
          FROM=.
      fi
      FILE=$(find $FROM -type f| fzf-tmux --reverse --exact --preview='less {} ')
      #FILE=$(fd -t file $FROM | fzf-tmux --reverse --exact --preview='highlight -O ansi --force {} | head -n 100')
      if [ -n "$FILE" ]; then
        printf 'edit %%{%s}' "${FILE}"
      fi
} }

define-command -override gitroot %{cd %sh(git rev-parse --show-toplevel); pwd}
declare-user-mode git

map -docstring 'git'        global user g :enter-user-mode<space>-lock<space>git<ret>
map -docstring 'add'        global git a :git<space>add<space>
map -docstring 'blame'      global git b :git<space>blame<ret>
map -docstring 'hide-blame' global git B :git<space>hide-blame<ret>
map -docstring 'status'     global git s :git<space>status<ret>
map -docstring 'commit'     global git c :git<space>commit<space>-m<space>
map -docstring 'checkout'   global git C ghww:git<space>checkout<space><c-r>.<ret>
map -docstring 'diff buf'   global git d ':git diff <c-r>%<ret>'
map -docstring 'diff'       global git D ':git diff<ret>'
map -docstring 'log'        global git l :git<space>log<ret>
map -docstring 'cd root'    global git r :gitroot<ret>
map -docstring 'pull'       global git p ge<a-!>git<space>pull<ret>
map -docstring 'push'       global git P ge<a-!>git<space>push<ret>
map -docstring 'branch'     global git h ge!git<space>branch<ret>

define-command -override send-line %{ execute-keys <c-s><a-x>:tmux-send-text<ret><c-o> }
map global normal <c-l> ':send-line<ret>j'


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

#FUN=$(grep --color=always -nE $1 ${kak_buffile} | fzf-tmux --ansi --delimiter=: --exact --no-sort --reverse --preview="cat ${kak_buffile} | tail -n +{1}")
#FUN=$(grep --color=always -nE $1 ${kak_buffile} | fzf-tmux --ansi --delimiter=: --exact --no-sort --reverse --preview="highlight -O ansi --force ${kak_buffile} | tail -n +{1}")

def -override -docstring 'search word inside buffer' -params 1 \
  fzf-search %{execute-keys %sh{
      export FILE=${kak_buffile}
      FUN=$(grep --color=always -nE $1 ${kak_buffile} | fzf-tmux --ansi --delimiter=: --exact --no-sort --reverse --preview="tail -n +(expr {1} - 10) ${kak_buffile}") #this depends on fish.
      if [ -n "$FUN" ]; then
        echo "$(echo ${FUN}| cut -d: -f 1)g"
      fi
}}

hook global WinSetOption filetype=rust %{
    set window formatcmd 'rustfmt'
}

def -override -docstring 'grep in current folder' -params 1.. \
  fzf-grep %{eval %sh{
      #FILE=$(rg --color always -n "$@" | fzf-tmux --exit-0 --exact --no-sort --ansi --delimiter=: --layout=reverse --preview="highlight -O ansi --force {1} | tail -n +{2}")
      FILE=$(rg --color always -n "$@" | fzf-tmux --exit-0 --exact --no-sort --ansi --delimiter=: --layout=reverse --preview="cat {1} | tail -n +{2} ")
      if [ -n "$FILE" ]; then
        echo "$(echo "edit -existing ${FILE}"| cut -d: -f 1,2 | tr : " ")"
      fi
}}

set-face global search +bi
add-highlighter global/search dynregex '%reg{/}' 0:search

hook global BufCreate .*\.nasm$ %{
    set-option buffer filetype gas
}


def -override -docstring 'send line return to tmux pane' \
  tmux-send-line %{eval %sh{
      printf 'tmux-send-text "\n"'
}}


def -override -docstring 'send \ return to tmux pane' \
  tmux-send-slash %{eval %sh{
      printf 'tmux-send-text "\\"'
}}

map global insert <c-s>  'select from where<esc>bi   <left><left>'


define-command -hidden -override tmux-send-text -params 0..1 -docstring %{
        tmux-send-text [text]: Send text(append new line) to the REPL pane.
        If no text is passed, then the selection is used
    } %{
    nop %sh{
        if [ $# -eq 0 ]; then
            tmux set-buffer -b kak_selection -- "${kak_selection}"
        else
            tmux set-buffer -b kak_selection -- "$1"
        fi
        tmux paste-buffer -b kak_selection -t "$kak_opt_tmux_repl_id"
    }
}

source ~/dotfiles/q.kak
