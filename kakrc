set global grepcmd 'rg --column'
map global normal <ret> : 
map global normal <c-l> :tmux-send-text<ret>x
def -override -docstring 'list file by git' git-edit -params 1 -shell-candidates %{git ls-files} %{edit %arg{1}}
def -override pwd 'echo %sh{pwd}'
def -override k -params 1 %{echo %sh{echo }}
colorscheme solarized-light
alias global ge git-edit
addhl global/ show_matching 
addhl global/ number_lines -relative -hlcursor
map -docstring 'write buffer' global user w :w<ret>
map -docstring 'delete buffer' global user d :db<ret>

# tmux: set -g focus-events on
hook -group test global FocusIn .* %{
    face window StatusLine rgb:586e75,rgb:eeffd5+b
}
hook -group test global FocusOut .* %{
    unset-face window StatusLine
}
