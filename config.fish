. ~/dotfiles/z.fish
set fish_greeting ""
set PATH ./node_modules/.bin/ $PATH
alias gst "git status"
alias ga "git add"
alias gd "git difftool"
alias gc "git commit -am"
alias gb "git branch"
alias gp "git pull"
alias nv nvim
set -x VISUAL 'subl -w -n'
set -x GOPATH ~/gohome
set -x PATH $PATH /usr/local/go/bin/ $GOPATH/bin

