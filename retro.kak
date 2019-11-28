# Detection
hook global BufCreate .*\.(retro|forth) %{
    set-option buffer filetype retro
}


rmhl shared/retro
add-highlighter shared/retro regions
add-highlighter shared/retro/code default-region group
add-highlighter shared/retro/code/comment regex '\s\([^\s]+\)' 0:comment
add-highlighter shared/retro/code/fun regex '\s(:)([^\s]+)' 1:meta 2:function


add-highlighter shared/retro/code/ regex  '\s#[-]\d+' 0:value
add-highlighter shared/retro/code/ regex '\s(\[|\])\s' 1:operator
add-highlighter shared/retro/code/ regex "'[^\s]+" 0:string

add-highlighter shared/retro/code/assign regex '\s![^\s]+' 0:meta
#attribute builtin function keyword meta operator type value


hook -group retro-highlight global WinSetOption filetype=retro %{ add-highlighter window/retro ref retro }
hook -group retro-highlight global WinSetOption filetype=(?!retro).* %{ remove-highlighter window/retro }
