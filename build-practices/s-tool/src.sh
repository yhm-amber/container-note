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

proptools ()
{
    : ::: demos ::: :
    
    : 'cat | (proptools t XXX=xxx ...)'
    : 'cat | (proptools t XXX=xxx ...) | (proptools d -D " ")'
    : 'cat | (proptools d -D " ") | (proptools t XXX=xxx ...)'
    
    : ...
    : ...
    
    
    : ::: codes ::: :
    
    
    t ()
    {
        : :: demo :: :
        
        : cat some.properties.template '|' t SERV_NAME=abc SERV_NS=abc-ns ...
        : properties.template such as: '

spring.cloud.nacos.discovery.ip={SERV_NAME}.{SERV_NS}.svc.cluster.local

server.port={SERV_PORT}
spring.cloud.nacos.discovery.port={SERV_PORT}
spring.cloud.nacos.discovery.server-addr={SERV_NACOS}

basic.gateway.url={SERV_GW_URL}
basic.gateway.port={SERV_GW_PORT}

spring.datasource.url=jdbc:mysql://{SERV_MYSQL}/{SERV_MYSQL_DB}?{SERV_MYSQL_PROPS}
spring.datasource.username={SERV_MYSQL_UNAME}
spring.datasource.password={SERV_MYSQL_UPASS}

spring.profiles.active={SERV_PROF_ACTIVE} '
        
        
        : :: codes :: :
        
        
        cat "${PROPERTIES_TEMPLATE_FILE:--}" |
            
            eval "$(
                
                echo "$@" | xargs -n1 |
                    
                    xargs -i -- echo '
                        (tmp="$(cat -)" && __ parse_template {} "$tmp") |' ) cat -" &&
        :;
    } &&
    
    d ()
    {
        : cat some.propertirs '|' d '-D' ' '  ::  out: -Dxxx.xxx=xxx -Dxxx.xxx=xxx ...
        
        local pre="$1" && shift &&
        local tal="$1" && shift &&        
        
        cat "${PROPERTIES_FILE:--}" |
            
            xargs -i -- printf "$pre"%s"$tal" {} &&
        
        :;
    } &&
    
    
    __ ()
    {
        parse_template ()
        {
            : parse_template AAA=c 'a b {AAA} d'
            : should get 'a b c d'
            
            :;
            
            local para="$1" && shift 1 &&
            local temp="$1" && shift 1 &&
            
            local para_name="$(parse_para_name "$para")" &&
            
            eval "$para" &&
            
            eval printf %s '${'"$para_name"'}' |
                
                xargs -0I {"$para_name"} -- echo "$temp" &&
            
            :;
        } &&
        
        parse_para_name ()
        {
            : parse_para_name AAA=c
            : get 'AAA'
            
            :;
            
            local para="$1" && shift 1 &&
            
            echo "$para" | cut -d= -f1 &&
            
            :;
        } &&
        
        : || { 1>&2 echo fun err ; exit 6 ; }
        
        
        : :: main :: :
        
        "$@" &&
        
        :;
    } &&
    
    export -f -- __ &&
    
    : || { 1>&2 echo fun err ; exit 7 ; }
    
    
    : ::: main ::: :
    
    "$@" &&
    
    :;
} ;



