hook global BufCreate .*\.(f) %{
    set-option buffer filetype forth
}

rmhl shared/forth
add-highlighter shared/forth regions

add-highlighter shared/forth/string  region ' \." '   (?<!\\)(\\\\)*"  fill string
add-highlighter shared/forth/string2 region ' S" '   (?<!\\)(\\\\)*"  fill string

add-highlighter shared/forth/comment1 region  '\\'   '$'    fill comment
add-highlighter shared/forth/comment2 region  '\{'   '\}'   fill comment
add-highlighter shared/forth/comment3 region  -recurse \( '[^:] \( '   '\)' fill comment

add-highlighter shared/forth/code default-region group
# integers
add-highlighter shared/forth/code/ regex '\b([1-9]\d*|0)\b' 0:value
add-highlighter shared/forth/code/ regex '^: ([^ ]+) ' 1:function

hook -group q-highlight global WinSetOption filetype=forth       %{ add-highlighter    window/forth ref forth }
hook -group q-highlight global WinSetOption filetype=(?!forth).* %{ remove-highlighter window/forth }




