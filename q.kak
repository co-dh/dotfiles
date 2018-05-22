
# Detection

hook global BufCreate .*\.(q) %{
    set-option buffer filetype q
}
rmhl shared/q
add-highlighter shared/ regions -default code q \
    string   '"'   (?<!\\)(\\\\)*"  '' \
    comment  '^/\h*$'   ^\Q\\E\h*$  '' \
    comment  ' /'   '$'             '' \
    comment  '^/'   '$'             '' \
    comment  '^\Q\\E\h*$'   'this match to eof'   ''

 
add-highlighter shared/q/string fill string
add-highlighter shared/q/comment fill comment
# Float formats
add-highlighter shared/q/code regex '\b\d+[eE][+-]?\d+[ef]?\b' 0:value
add-highlighter shared/q/code regex '(\b\d+)?\.\d+[ef]?\b' 0:value
add-highlighter shared/q/code regex '\b\d+\.[ef]?' 0:value
#inf and null
add-highlighter shared/q/code regex '\b0[NW][hijepdnuvt]?\b' 0:value
add-highlighter shared/q/code regex '\b0[nw]\b' 0:value
add-highlighter shared/q/code regex '\b0N[gm]\b' 0:value

hook -group q-highlight global WinSetOption filetype=q %{ add-highlighter window ref q }
hook -group q-highlight global WinSetOption filetype=(?!q).* %{ remove-highlighter window/q }

add-highlighter shared/q/code regex '(?i)\b([1-9]\d*|0)[hij]?\b' 0:value
add-highlighter shared/q/code regex '(?i)\b[01]+b\b' 0:value
add-highlighter shared/q/code regex '(?i)\b0x[\da-f]+\b' 0:value

%sh{
    keywords="abs|acos|asin|atan|avg|bin|binr|cor|cos|cov"
    keywords="${keywords}|delete|dev|div|do|enlist|exec|exit|exp|getenv|if"
    keywords="${keywords}|in|insert|last|like|log|max|min|prd|select|setenv"
    keywords="${keywords}|sin|sqrt|ss|sum|tan|update|var|wavg|while|within"
    keywords="${keywords}|wsum|xexp||neg|not|null|string|reciprocal|floor|ceiling"
    keywords="${keywords}|signum|mod|xbar|xlog|and|or|each|scan|over|prior"
    keywords="${keywords}|mmu|lsq|inv|md5|ltime|gtime|count|first|svar|sdev"
    keywords="${keywords}|scov|med|all|any|rand|sums|prds|mins|maxs|fills"
    keywords="${keywords}|deltas|ratios|avgs|differ|prev|next|rank|reverse|iasc|idesc"
    keywords="${keywords}|asc|desc|msum|mcount|mavg|mdev|xrank|mmin|mmax|xprev"
    keywords="${keywords}|rotate|ema|distinct|group|where|flip|type|key|til|get"
    keywords="${keywords}|value|attr|cut|set|upsert|raze|union|inter|except|cross"
    keywords="${keywords}|sv|vs|sublist|read0|read1|hopen|hclose|hdel|hsym|hcount"
    keywords="${keywords}|peach|system|ltrim|rtrim|trim|lower|upper|ssr|view|tables"
    keywords="${keywords}|views|cols|xcols|keys|xkey|xcol|xasc|xdesc|fkeys|meta"
    keywords="${keywords}|lj|ljf|aj|aj0|ij|ijf|pj|asof|uj|ujf"
    keywords="${keywords}|ww|wj|wj1|fby|xgroup|ungroup|ej|save|load|rsave"
    keywords="${keywords}|rload|dsave|show|csv|parse|eval|reval"

    # Add the language's grammar to the static completion list
    printf %s\\n "hook global WinSetOption filetype=q %{
        set-option window static_words '${keywords}'
    }" | tr '|' ':'


    # Highlight keywords
    printf %s "
        add-highlighter shared/q/code regex '\b(${keywords})\b' 0:keyword
    "
}
