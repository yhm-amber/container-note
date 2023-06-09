: 🎳 : 😊



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





xfstab_uuid_ ()
{
    : ::: deno ::: :
    
    : xfstab_uuid_ /dev/sdx /var/lib/docker
    : xfstab_uuid_ /dev/sdx /var/lib/containers
    
    
    : ::: lib ::: :
    
    ask_user ()
    {
        predesc="${1:-Hey 👻}"
        ask="${2:-what should i ask ???}" &&
        anss="${3:-[y/n] (:p)}" &&
        
        cases="${4:-
            case \"\$ans\" in 
                
                y|\'\') echo 😦 yup\?\? ; break ;; 
                n) echo 🤔 no\? ; break ;; 
                *) echo 🤨 ahh\? what is \'\$"{"ans:-:p"}"\' \? ;; esac }" &&
        
        
        echo "$predesc" &&
        while read -p "$ask $anss " -- ans ;
        do eval "$cases" ; done ;
    } ;
    
    : ::: pre main ::: :
    
    local rt ;
    
    case "$#" in 1|2) ;; *) 1>&2 echo need one or two args ; return 4 ;; esac ;
    
    :;
    
    dev_uuid ()
    {
        local device="$1" &&
        local field="$2" &&
        (eval "$(blkid -o export -- "$device")"' ; echo $'"${field:-UUID}") ;
    } &&
    
    uuid_fstab ()
    {
        local device="$1" &&
        local dir="${2:-/var/lib/docker}" &&
        
        echo UUID="$(
            dev_uuid "$device" UUID )"  "${dir:-/var/lib/containers}"  "$(
            dev_uuid "$device" TYPE )"  defaults,pquota  0 0 ;
    } &&
    
    : || { echo define err ; exit 7 ; } ;
    
    
    
    : ::: main ::: :
    
    
    local device="$1" &&
    local dir="${2:-/var/lib/libvirt/images/pool0}" &&
    
    mkdir -p -- "$dir" &&
    
    
    {
        ask_user "
$(lsblk)

========

: got 
: 
:   dev: $device 
:   dir: $dir 
" ": make the $device in to xfs ? will clear datas in it ~~ 😬" "[y/n]" '
            
            case "$ans" in 
                y) echo ; return 0 ;; 
                n) echo : quit tool 😋 ; return 2 ;;
                *) ;; esac ' || return ;
        
        
        
        : means: answer y to go-on or n to quit :
        
        :;
        
        mkfs -t xfs -n ftype=1 -f -- "$device" ;
        
    } &&
    
    
    {
        ask_user "
: will add this line to fstab:
$(uuid_fstab "$device" "$dir")
" ': 🤔 go on ?' '[y/n]' '
            
            case "$ans" in
                y) echo ; return 0 ;;
                n) echo : quit tool 😘 ; return 2 ;;
                *) ;; esac ' || return ;
        
        
        
        : means: answer y to go-on or n to quit :
        
        :;
        
        (echo ; uuid_fstab "$device" "$dir" ; echo) | tee -a -- /etc/fstab ;
        
    } &&
    
    
    mount -a ||
    { rt=$? ; echo 😨 may need to check /etc/fstab and recmd mount -a ; return $rt ; } ;
    
    lsblk &&
    
    :;
} ;


