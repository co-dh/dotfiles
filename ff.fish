function ff
	set cmd (ls --all --color --indicator-style=slash \
        | fzf --exact --ansi --expect=right,left,enter --preview='browse {}' --header=(pwd)\
        | tr '\n' ' '                                                                \
        )
    test -z $cmd ; and return 0
    switch $cmd
    	case 'right *'
        	eval (echo $cmd | sed 's|right \(.*\)|cd \1 2>/dev/null |')
        	ff
        case 'left *'
            cd .. 2>/dev/null 
            ff
        case 'enter *'
           	eval (echo $cmd | sed 's/enter /kak /')
        case '*'
            echo $cmd
    end    	
end

#fd --color always --hidden --no-ignore                                                             \
