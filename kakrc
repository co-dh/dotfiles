set global grepcmd 'rg --column'

define-command -override -hidden -params 2 swap-key %{eval %{ echo -debug %arg{1} %arg{2} }}
#%sh{echo 'swaps[]' | q ~/kak.q}
map global normal "'" :
map global normal <space> ,
map global normal  , <space>
map global normal <c-l> x:tmux-send-text<ret>j
map global insert <c-l> <esc>x:tmux-send-text<ret>ji

   #test
# tab to space
hook global InsertChar \t %{ exec -draft -itersel h@ }

define-command -override -docstring 'list file by git' git-edit -params 1 -shell-candidates %{git ls-files} %{edit %arg{1}}
alias global ge git-edit
#define-command -override -params 1.. run-shell info %{pwd}

#info %sh{printf "%%{$(ls | head -53)}"}

colorscheme solarized-light
add-highlighter global/ show_matching
add-highlighter global/ number_lines -relative -hlcursor

map -docstring 'Eval in kak' global user e :<c-r>.<ret>
map -docstring 'Buffer' global user b :b<space>
map -docstring 'Project' global user p :ge<space>
map -docstring 'Kill buffer' global user k :db<ret>
map -docstring 'Write buffer' global user w :w<ret>
map -docstring 'command' global user <space> :

set global lintcmd %{
    pylintplus1()
    {
        pylint --msg-template='{path}:{line:}:{column}: {category}: {msg}' -rn -sn $1 \
        |awk '{split($0,a,":"); printf( "%s:%s:%s: %s: %s\n",a[1],a[2],a[3]+1,a[4],a[5])}'
    }
    pylintplus1  }

#add-highlighter window dynregex '%reg{/}' 0:+ui
#rmhl window/dynregex_\%reg{<slash>}
declare-user-mode toggle
#map global toggle /
