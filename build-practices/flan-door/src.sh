: ::::::::::::::::::::::::::::::::::::::::::: :
: :::: 🥰 Welcome Into Flandre Doors 🥰 :::: :
: :::: 🤗 Having Fun With These Toys 🤗 :::: :
: ::::::::::::::::::::::::::::::::::::::::::: :



: ::::::::: lib toys ::::::::: :

try ()
{
    t ()
    {
        : t function f_name
        : t xxx xxx_name
        
        :;
        
        local t="$1" && shift 1 &&
        local n="$1" && shift 1 &&
        
        test "$(type -t -- "$n")" == "$t" &&
        
        :;
    } &&
    
    "$@" ;
} ;

metas ()
{
    : from hmrg-grmh/meta-shells
    
    :;
    
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
    } &&
    
    historisch ()
    {
        : '"历史什么也没有做。"'
        : '"History is did Nothing ."'
        
        : ::: 使用例 ::: :;
        : ::: usage ::: :;
        
        : historisch {K} '(f="$(cat -)" && echo "${{K}}" | xargs -i:..{K}..: -- echo "$f") |' 'cat -' K1 K2
        : historisch {K} '(f="$(cat -)" && echo "${{K}}" | xargs -i:_{K}_: -- echo "$f") |' 'cat -' K1 K2
        : historisch {} 'local {}="$1" && shift 1 &&' ':' K1 K2
        
        
        
        : ::: 知识 ::: :;
        : ::: lib ::: :;
        
        test function = "$(type -t histories)" || { echo :: lib err 😅 ; return 231 ; } ;
        
        
        
        : ::: 应用 ::: :;
        : ::: run ::: :;
        
        
        
        eval "$(histories 'local {}="${1}" && shift 1 &&' {} head log tail) :" &&
        
        eval "$(histories "$log" "$head" "$@") $tail" &&
        
        :;
    } &&
    
    histories ()
    {
        : 'Today, is History !!'
        : 'Today, we Make History !!'
        : 'and Today, we Are the Part of History !!'
        
        : '"历史什么也没有做。"'
        : '"History is did Nothing ."'
        
        : ::: 使用例 ::: :;
        : ::: usage ::: :;
        
        : see commands inner historisch fun define ;
        
        : ::: 代码 ::: :;
        : ::: codes ::: :;
        
        local log="${1}" && shift 1 &&
        local mod="${1}" && shift 1 &&
        
        echo "$@" | xargs -n1 | xargs -i"${mod}" -- echo "$log" &&
        
        :;
    } &&
    
    
    
    : || { 1>&2 echo fun err ; exit 7 ; }
    
    :;
    
    "$@" ;
} ;

dateinner ()
{
    : dateinner 2020-02-02 2020-03-01 ;
    : dateinner 2020-02-02 2020-01-01 ;
    : dateinner 2020-02-02T10:13:00 2020-02-03 hour %FT%T ;
    
    :;
    
    local bg_s="$(date -d"$1" -- +%s)" && shift 1 &&
    local ed_s="$(date -d"$1" -- +%s)" && shift 1 &&
    
    local stp="${1}" && shift 1 &&
    local fmt="${1}" && shift 1 &&
    
    : &&
    
    local step_to="$(echo "$ed_s - $bg_s" | bc | tr -d '.|[0-9]')" &&
    local step_len="$(date -d "next ${stp:-day} $(date -d@0 -- +%FT%T%z)" -- +%s)" &&
    
    seq -- "$bg_s" "${step_to}${step_len}" "$ed_s" |
        xargs -i -P1 -- date -d@{} -- +"${fmt:-%F}" &&
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







dbtoys ()
{
    meta_db ()
    {
        : meta_db my svc1 svc-foo svc-000
        : meta_db pg svc1 svc-foo svc-000
        : PSWD_FIX='P@88w0rd' meta_db my svc1 svc-foo svc-000
        : PSWD_FIX='P@88w0rd' meta_db pg svc1 svc-foo svc-000
        
        :;
        
        local db_type="$1" && shift 1 &&
        
        
        
        my ()
        {
            echo 'create database if not exists `{}` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci ;'
            echo 'grant all on `{}`.* to "{}"@"%" identified by "'"${PSWD_FIX}"'--{}" ; show grants for "{}"@"%" ;'
        } &&
        
        pg () { :; } &&
        
        
        local passfix='' && ! test -z $PSWD_FIX ||
        read -p 'input your passwd fix: ' -- passfix &&
        
        
        for svc_name in "$@" ;
        do
            echo "$svc_name" ;
        done |
            
            xargs -i -- echo "$(PSWD_FIX="${passfix:-$PSWD_FIX}" "$db_type")" &&
        
        :;
        
    } &&
    
    row_table ()
    {
        : row_table : /opt/sdk:/opt/sdk $PWD/app:/opt/app
        : get: /opt/sdk /opt/sdk'<br>'$PWD/app /opt/app
        
        : F=1 row_table : /opt/sdk:/opt/sdk $PWD/app:/opt/app
        : get: /opt/sdk'<br>'$PWD/app
        
        : F=1 row_table , /opt/sdk,/opt/sdk $PWD/app,/opt/app
        : get: /opt/sdk'<br>'$PWD/app
        
        : W=app row_table : /opt/sdk:/opt/sdk $PWD/app:/opt/app
        : get: $PWD/app /opt/app
        
        : W=app F='(NF+1)"mv","from/"$1,"to/"$2' row_table : /opt/sdk:/opt/sdk /xxx/app:/opt/app
        : get: mv from//xxx/app to//opt/app
        
        : in dbtoys, plz use like
        : F=1 dbtoys row_table , /opt/sdk,/opt/sdk $PWD/app,/opt/app
        : or like
        : dbtoys eval F=1 row_table , /opt/sdk,/opt/sdk $PWD/app,/opt/app
        
        
        :;
        
        local sp="$1" && shift 1 &&
        
        for pair in "$@" ;
        do
            echo "$pair" | tr "$sp" ' ' ;
        done |
            
            awk /"$W"/'{print$'"${F:-0}"'}' &&
        
        :;
    } &&
    
    : || { echo fun err ; return 7 ; }
    
    "$@" ;
} ;








: ::::::::: fun toys ::::::::: :

installer ()
{
    local img_name="$1" && shift 1 &&
    
    echo "$@" | xargs -n1 | xargs -I {F} -- echo '
        {F} ()
        {
            podman run --rm -i -- '"'$img_name'"' {F} "$@" ;
        } ' ;
} ;



: ::::::::: man toys ::::::::: :

helper ()
{
    declare -f -- ''"$@" ||
        cat readme ;
} &&

?? () { helper "$@" ; } ;

lister ()
{
    declare -F -- ''"$@" ||
        declare -F ;
} &&

,, () { lister "$@" ; } ;



: ::::::::: main run ::::::::: :

"$@" ;
