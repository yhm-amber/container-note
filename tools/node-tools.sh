pack_servicelogs ()
{
    : usage demo: pack_servicelogs kubelet 2021-10-11 2021-12-22 /mnt/logs ;
    
    local service_name="${1}" &&
    local date_bg="${2}" &&
    local date_ed="${3}" &&
    local save_place="${4:-.}" &&
    
    local outname="$(echo $service_name | tr / :)"-logs-"$HOSTNAME"-"$date_bg"_"$date_ed" &&
    
    get_files ()
    {
        : usage demo: get_files inceptor1 2021-10-11 2021-12-22 ;
        
        find -- /var/log/"${1:-$service_name}" \
          -name '*.log*' \
          -newermt "${2:-$date_bg}" \
          -and ! -newermt "${3:-$date_ed}" &&
        
        :;
    } &&
    
    tar -cf- -- $(get_files "$service_name" "$date_bg" "$date_ed") |
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

