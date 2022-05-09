packer ()
{
    : usage demo: packer '*.log*' kubelet 2021-10-11 2021-12-22 /mnt/logs.bak --remove-files ;
    
    local file_mod="${1}" &&
    local service_name="${2}" &&
    local date_bg="${3}" &&
    local date_ed="${4}" &&
    local save_place="${5:-.}" &&
    local tar_more_flags="${6}" &&
    
    local outname="$(echo "$service_name" | tr / : | tr . _)"-"$(echo "$file_mod" | tr -d '*' | tr / :)"-"$HOSTNAME"-"$date_bg"_"$date_ed" &&
    
    getfiles_at_time ()
    {
        : usage demo: getfiles_at_time /var/log/kubelet '*.log*' 2021-10-11 2021-12-22 ;
        
        find -- "${1:-/var/log/$service_name}" \
          -name "${2:-*.log*}" \
          -newermt "${3:-$date_bg}" \
          -and ! -newermt "${4:-$date_ed}" |
            
            while read p ;
            do
                echo "'$p'" ;
            done &&
        
        :;
    } &&
    
    tar $tar_more_flags -chf- -- $(getfiles_at_time /var/log/"$service_name" "$file_mod" "$date_bg" "$date_ed") |
        xz -T0 --best > "$save_place"/"$outname".tar.xz &&
    
    ls "$save_place"/"$outname".tar.xz &&
    :;
} ;



allnodesrun ()
{
    : usage demo:
    : 
    : awk /somefix/'{print$1}' /etc/hosts |
    :     allnodesrun : dmidecode -t system ';' dmidecode -s system-serial-number ';' dmidecode -s system-product-name
    
    NODES="$(cat -)" &&
    
    local msg_cmd="$(for a in "$@";do printf "'$a'"' ';done)" &&
    local msg_bg='">" ::: "$HOSTNAME" : start : "$(date +%s.%N)" ::: "<"' &&
    local msg_ed='">" ::: "$HOSTNAME" : done"($?)" : "$(date +%s.%N)" ::: "<"' &&
    
    echo command = "$msg_cmd" &&
    
    echo "$NODES" |
        
        xargs -i{host} -- ssh {host} -- \
          set -o pipefail ';' \
          echo "$msg_bg" "$msg_cmd" ';' \
          "$@" ';' echo "$msg_ed" "$msg_cmd" ';' \
          echo &&
    :;
} ;

