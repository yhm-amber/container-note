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
