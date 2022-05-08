: have a lot of fun 🤗 :



klsctl ()
{
    : usage demo:
    : klsctl nodexx/NotReady status kubelet
    
    : ::::::::::: :
    
    (($# != 3)) && echo para err 🥲 && return 233 ;
    
    local namefix="${1}" &&
    local cmd="${2}" &&
    local svcs="${3}" &&
    
    kubectl get no |
        
        awk /"$namefix"/'{print$1}' |
        
        xargs -i -- ssh {} -- '
            
            echo : :::: $HOSTNAME ... start ... $(date +%s) :::: : ;
            
            systemctl '"'$cmd'"' -- '"$svcs"' ;
            
            echo : :::: $HOSTNAME ... done ... $(date +%s) :::: : ' |
        
        tee "($svcs)"-"$namefix"-"$cmd".log &&
    
    
    (
        echo : =========== : ;
        ls "($svcs)"-"$namefix"-"$cmd".log ) &&
    
    :;
} ;





kubej_chks ()
{
    : 这个工具用于不太妥当的容器使用的场景
    : 所以需要获取 jvm 的 pid
    
    
    
    : ::: usage demo ::: :;
    
    : kubejchks -n default podname
    
    
    : ::: libs ::: :;
    
    kubejps ()
    {
        : ::: usage demo ::: :;
        
        : kubejps 0 -n default podname ;
        : kubejps 1 -n default podname ;
        : kubejps 2 -n default podname ;
        
        : ::: libs ::: :;
        
        : kubectl ;
        
        : ::: codes ::: :;
        
        local field="${1}" &&
        shift 1 &&
        
        kubectl exec "$@" -- jps | awk '!'/Jps/'{print$'"${field:-0}"'}' &&
        :;
    } ;
    
    : kubectl ;
    
    
    
    : ::: codes define ::: :;
    
    kubejstat ()
    {
        : 'kubejstat "-gcutil -t" "$(kubejps 1 -n default podname)" 1000 5 -n default podname' ;
        
        local opts="${1}" &&
        local jvm_pid="${2}" &&
        local wait_interval="${3}" &&
        local chk_count="${4}" &&
        
        shift 4 &&
        
        kubectl exec "$@" -- jstat $opts "${jvm_pid:-$(kubejps 1 "$@")}" "${wait_interval:-1000}" "${chk_count:-8}" &&
        
        :;
    } &&
    
    kubejmap ()
    {
        : 'kubejmap hive "-histo:live" "$(kubejps 1 -n default podname)" -n default podname' ;
        
        local user="${1}" &&
        local opts="${2}" &&
        local id="${3}" &&
        
        shift 3 &&
        
        kubectl exec "$@" -- sudo -u "${user:-hive}" -- jmap ${opts:--histo:live} "${id:-$(kubejps 1 "$@")}" &&
        
        :;
    } &&
    
    kubejstark ()
    {
        : 'kubejstark hive "-l" "$(kubejps 1 -n default podname)" -n default podname' ;
        
        local user="${1}" &&
        local opts="${2}" &&
        local id="${3}" &&
        
        shift 3 &&
        
        kubectl exec "$@" -- sudo -u "${user:-hive}" -- jstack ${opts:-} "${id:-$(kubejps 1 "$@")}" &&
        
        :;
    } &&
    
    : || { return_code=$? ; 2>&1 echo define fun err 🤔 ; return $return_code ; } ;
    
    
    
    : ::: codes run ::: :;
    
    main___ ()
    {
        set -o pipefail ;
        
        local dir="$(mktemp --directory -- kube_java_checks.XXXXXXXXXX)" &&
        {
            (kubejstat "-gcutil -t" "$(kubejps 1 "$@")" 1000 5 "$@" | tee "$dir"/jstat-"$(kubejps 2 "$@")":"$*".log | wc -l && echo :ok kubejstat) &
            (kubejmap hive "-histo:live" "$(kubejps 1 "$@")" "$@" | tee "$dir"/hive-jmap-"$(kubejps 2 "$@")":"$*".log | wc -l && echo :ok kubejmap) &
            (kubejstark hive "-l" "$(kubejps 1 "$@")" "$@" | tee "$dir"/hive-jstark-"$(kubejps 2 "$@")":"$*".log | wc -l && echo :ok kubejstark) &
            
            wait ;
        } ;
        
        tar -cf- "$dir" | xz -T0 --best > /mnt/disk4/kube_java_checks:"$*"-logs.tar.xz && ls /mnt/disk4/kube_java_checks:"$*"-logs.tar.xz ;
    } ;
    
    main___ ;
} ;
