#! /bin/sh

mknginx_stream ()
{
    local service_name="${1:-$SERVICE_NAME}" &&
    local port_here="${2:-$PORT_HERE}" &&
    local ip_port_remotes="${3:-$IP_PORT_REMOTES}" &&
    
    
    para_tester ()
    {
        (
            eval "
                $(
                    echo "$@" | xargs -n1 |
                        xargs -i -- echo 'test ! -z "${}" &&' )
                : " ) ||
        {
            1>&2 echo para err: $(
                eval "$(
                    echo "$@" | xargs -n1 |
                        xargs -i -- echo 'echo {}="'"'"'${}'"'"'" ' )" ) ;
            return 232 ; } ;
    } &&
    
    para_tester service_name port_here ip_port_remotes || { return $? ; } ;
    
    
    :;
    
    
    echo '

upstream '"$service_name"'_servers {
    least_conn ;
'"$(
    
    echo $ip_port_remotes | tr , ' ' | xargs -n1 |
        
        xargs -i -- echo '    ''server {} max_fails='"${max_fails:-3}"' fail_timeout='"${fail_timeout:-8s}"' ;' )"'
}
server {
    listen '"$port_here"' ;
    proxy_pass '"$service_name"'_servers ;
}' |
        
        cat &&
    
    :;
} &&

echo '#' $(
    
    eval "$(
        echo max_fails fail_timeout SERVICE_NAME PORT_HERE IP_PORT_REMOTES | xargs -n1 |
            xargs -i -- echo 'echo {}="'"'"'${}'"'"'" ')" ) sh "'$0'" "$(
    
    for arg in "$@";do printf "'$arg'"' ';done )" &&

mknginx_stream "$@" ; exit $? ;

