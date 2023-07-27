replacer ()
(
    : rgx=foo to=bar sp='?' replacer files...
    : rgx=ccc to=aaaa sp='x' replacer xx xxx
    
    
    for f in "$@" ;
    do
        local s="${sp}${rgx}${sp}${to}${sp}" &&
        local p="${sp}${rgx}${sp}" &&
        
        (
            echo &&
            echo "$f": &&
            echo &&
            echo '~~~~~~~~ before' &&
            echo "$(cat -n -- "$f" | sed -n -- "\\${p}p" - | grep --color=always -- "${rgx}" -)" &&
            echo '~~~~~~~~' &&
            echo &&
            echo '~~~~~~~~ after' &&
            echo "$(cat -n -- "$f" | sed -n -- "s${s}pg" - | grep --color=always -- "${to}" -)" &&
            echo '~~~~~~~~' &&
            echo &&
            
            : ) &&
        
        while read -p '(y/n)> ' -- a ;
        do
            case "$a" in yes|ok|y|o) sed -i -- "s${s}g" "$f" ; break ;; no|n|dame|d) break ;; *) ;; esac ;
        done &&
        
        :;
    done )
