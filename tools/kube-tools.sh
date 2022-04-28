klsctl ()
{
    : usage demo:
    : klsctl nodexx/NotReady status kubelet
    
    : ::::::::::: :
    
    (($# != 3)) && echo para err 🥲 && exit 233 ;
    
    local namefix="${1}" &&
    local cmd="${2}" &&
    local svc="${3}" &&
    
    kubectl get no |
        
        awk /"$namefix"/'{print$1}' |
        
        xargs -i -- ssh {} -- '
            
            echo : :::: $HOSTNAME ... start ... $(date +%s) :::: : ;
            
            systemctl '"$cmd"' '"$svc"' ;
            
            echo : :::: $HOSTNAME ... done ... $(date +%s) :::: : ' |
        
        tee kubelet-"$namefix"-"$cmd"-"$svc".log &&
    
    
    (
        echo ==================== ;
        ls kubelet-"$namefix"-"$cmd"-"$svc".log ) &&
    
    :;
} ;
