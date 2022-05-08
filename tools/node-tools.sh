pack_servicelogs ()
{
    : usage demo: pack_servicelogs kubelet 2021-10-11 2021-12-22 /mnt/logs ;
    
    local service_name="${1}" &&
    local date_bg="${2}" &&
    local date_ed="${3}" &&
    local save_place="${4:-.}" &&
    
    local outname="$(echo $service_name | tr / :)"-logs-"$HOSTNAME"-"$date_bg"_"$date_ed" &&
    
    getfiles_at_time ()
    {
        : usage demo: getfiles_at_time /var/log/inceptor1 '*.log*' 2021-10-11 2021-12-22 ;
        
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
    
    tar -cf- -- $(getfiles_at_time /var/log/"$service_name" '*.log*' "$date_bg" "$date_ed") |
        xz -T0 --best > "$save_place"/"$outname".tar.xz &&
    
    ls "$save_place"/"$outname".tar.xz &&
    :;
} ;



allnodesrun ()
{
    `# usage demo: awk /somefix/'{print$1}' /etc/hosts | allnodesrun cat xxx '|' awk`
    
    local msg_cmd="$(for a in "$@";do printf "'$a'"' ';done)" &&
    local msg_bg=': ::: $(date %s.%N) .. $HOSTNAME .. begin .. '"$msg_cmd"' ::: :' &&
    local msg_ed=': ::: $(date %s.%N) .. $HOSTNAME .. ed($?) .. '"$msg_cmd"' ::: :' &&
    
    xargs -i{host} -- ssh {host} -- set -o pipefail ';' echo "$msg_bg" ';' "$@" ';' echo "$msg_ed" ';' echo ;
} ;

