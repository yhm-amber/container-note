: 🥦 : 😊

dateinner ()
{
    : dateinner 2020-02-02 2020-03-01 ;
    : dateinner 2020-02-02 2020-01-01 ;
    
    local bg_s="$(date -d"$1" +%s)" && shift 1 &&
    local ed_s="$(date -d"$1" +%s)" && shift 1 &&
    
    seq -- "$bg_s" "$(echo "$ed_s - $bg_s" | bc | tr -d '.|[0-9]')86400" "$ed_s" |
        xargs -i -P1 -- date -d@'{}' +%F &&
    :;
} ;







