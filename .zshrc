
export PATH="/home/hao/local/bin:/home/hao/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"

mkdir -p $HOME/local/bin
mkdir -p $HOME/local/lib

export LD_LIBRARY_PATH="$HOME/local/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="$HOME/local/lib/pkgconfig/:$HOME/local/lib/pkg-config/"

bindkey "^f" end-of-line
bindkey -s '^z' 'fg^M'


# disable ctrl s that freeze the terminal
stty -ixon
#. $HOME/dotfiles/z.sh




### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
