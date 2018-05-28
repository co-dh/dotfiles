
hook -group pylintmypy global WinSetOption filetype=python %{

    set global lintcmd %{
        #pylint result's column index starts with 0, we'll need to add 1 in awk. 
        pylintplus1()
        {
            pylint --msg-template='{path}:{line:}:{column}: {category}: {msg}' -rn -sn $1 \
            |awk '{split($0,a,":"); printf( "%s:%s:%s: %s: %s\n",a[1],a[2],a[3]+1,a[4],a[5])}'
        }
        mypyWithCol()
        {
            mypy --show-column-numbers $1
        }
        pylintAndMypy()
        {
            (mypyWithCol $1; pylintplus1 $1) | cat
        }
        pylintAndMypy }
}

hook global WinSetOption filetype=(?!python).* %{
    remove-hooks window python-indent
}
