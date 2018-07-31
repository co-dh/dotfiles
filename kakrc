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
map global normal <c-l> '<a-x><a-;>Gi:tmux-send-text<ret>j'
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
map -docstring 'switch buffer'         global user b :b<space>
map -docstring 'Eval in Kak'           global user e :<space><c-r>.<ret>
map -docstring 'kill buffer'           global user k :<space>db<ret>
map -docstring 'reload q'              global user L :<space>write<ret>:<space>tmux-send-text<space>'\l<space><c-r>%'<ret>
map -docstring 'send select'           global user l :<space>tmux-send-text<ret>gll:send-text<ret>
map -docstring 'send select'           global user h <a-i>w:<space>tmux-send-text<space><c-r>..head()<ret>gll:send-text<ret>
map -docstring 'grep-next-match'       global user n :<space>grep-next-match<ret>
map -docstring 'grep-previous-match'   global user N :<space>grep-previous-match<ret>
map -docstring 'Project'               global user p :fzf-file<ret>
map -docstring 'Open file in git'      global user P :fzf-file<space>1<ret>
map -docstring 'turn off number_lines' global user T :<space>rmhl<space>window/mynumber<ret>
map -docstring 'Line Num'              global user <c-t> :addhl<space>window/mynumber<space>number-lines<space>-relative<space>-hlcursor<ret>
map -docstring 'make test'             global user t :make<space>test<ret>
map -docstring 'write buffer'          global user w :<space>w<ret>
map -docstring 'grep'                  global user / :grep<space> 

hook global InsertChar \t %{ exec -draft h@ }

set global tabstop 4

set-option global toolsclient toolsclient
def sel-trailing-space -override %{exec '%s\h+$<ret>'}


#add-highlighter window dynregex '%reg{/}' 0:u

hook -group UnCursor global InsertBegin .* %{ face window PrimaryCursor +u;                    addhl window/ws show-whitespaces -spc ' '}
hook -group UnCursor global InsertEnd   .* %{ face window PrimaryCursor rgb:002b36,rgb:839496; rmhl window/ws}
set-option global ui_options ncurses_assistant=off  # poor clippy

# Work related
define-command -override dse %{cd /apps/ramdisk/dse}
define-command -override rcd -docstring "relative cd to current buffer" %{cd %sh{dirname ${kak_reg_percent} | tr --delete "'"}}

hook global BufCreate .*/?mk %{
    set-option buffer filetype makefile
}

def  -override -params 0..1 -docstring 'invoke fzf to open a file. If any argument, open from git room' \
  fzf-file %{eval %sh{
      if [ $# -ne 0 ]; then  
          FROM=" . $(git rev-parse --show-toplevel)"
      fi
      FILE=$(fd -t file $FROM | fzf-tmux --exact --preview='head -n 100 {}')
      if [ -n "$FILE" ]; then
        printf 'edit %%{%s}' "${FILE}"
      fi
} }

