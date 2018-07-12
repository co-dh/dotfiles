def -docstring 'invoke fzf to open a file' \
  fzf-file %{ %sh{
    if [ -z "$TMUX" ]; then
      echo echo only works inside tmux
    else
      FILE=$(find * -type f | fzf-tmux -d 15 --preview "cat {}")
      if [ -n "$FILE" ]; then
        printf 'eval -client %%{%s} edit %%{%s}\n' "${kak_client}" "${FILE}" | kak -p "${kak_session}"
      fi
    fi
} }

def -docstring 'invoke fzf to select a buffer' \
  fzf-buffer %{ %sh{
    if [ -z "$TMUX" ]; then
      echo echo only works inside tmux
    else
      BUFFER=$(printf %s\\n "${kak_buflist}" | tr : '\n' | fzf-tmux -d 15)
      if [ -n "$BUFFER" ]; then
        echo "eval -client '$kak_client' 'buffer ${BUFFER}'" | kak -p ${kak_session}
      fi
    fi
} }

set global lintcmd %{
    pylintplus1()
    {
        pylint --msg-template='{path}:{line:}:{column}: {category}: {msg}' -rn -sn $1 \
        |awk '{split($0,a,":"); printf( "%s:%s:%s: %s: %s\n",a[1],a[2],a[3]+1,a[4],a[5])}'
    }
    pylintplus1  }

set global grepcmd 'ag --column'
map global normal "'" :
map global normal <space> ,
map global normal , <space> 
map global normal <c-l> x_L:tmux-send-text<ret>jgh
map global insert <c-l> <esc>x_L:tmux-send-text<ret>jghi

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
map -docstring 'reload q'              global user L :<space>write<ret>:<space>tmux-send-text1<space>'\l<space><c-r>%'<ret>
map -docstring 'send select'           global user l :tmux-send-text<space><c-r>.<ret>
map -docstring 'grep-next-match'       global user n :<space>grep-next-match<ret>
map -docstring 'grep-previous-match'   global user N :<space>grep-previous-match<ret>
map -docstring 'Project'               global user p :<space>edit-in-prj<space>
map -docstring 'turn off number_lines' global user t :<space>rmhl<space>buffer/number_lines<ret>
map -docstring 'Line Num'              global user t :addhl<space>window/<space>number_lines<space>-relative<space>-hlcursor<ret>
map -docstring 'write buffer'          global user w :<space>w<ret>

# tmux: set -g focus-events on
#hook -group test global FocusIn .* %{
#    #face window StatusLine rgb:586e75,rgb:eeffd5+b
#}
#hook -group test global FocusOut .* %{
#    #unset-face window StatusLine
#    rmhl buffer/number_lines
#}

hook global InsertChar \t %{ exec -draft h@ }


set global tabstop 4

set-option global toolsclient toolsclient
def sel-trailing-space -override %{exec '%s\h+$<ret>'}

define-command -override -hidden tmux-send-text1 -params 1 -docstring "Send text to the repl pane" %{
    nop %sh{
        tmux set-buffer -b kak_selection1 "$@
"
        kak_orig_window=$(tmux display-message -p '#I')
        kak_orig_pane=$(tmux display-message -p '#{pane_id}')
        tmux select-window -t:$(tmux show-buffer -b kak_repl_window)
        tmux select-pane -t:.$(tmux show-buffer -b kak_repl_pane)
        tmux paste-buffer -b kak_selection1
        tmux select-window -t:${kak_orig_window}
        tmux select-pane -t:.${kak_orig_pane}
    }
}

def -override test -params 0..1 %{echo %sh{echo $#}}

#add-highlighter window dynregex '%reg{/}' 0:u
hook global InsertBegin .* %{ face window PrimaryCursor +u}
hook global InsertEnd   .* %{ face window PrimaryCursor rgb:fdf6e3,rgb:657b83}


