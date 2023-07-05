cdhmeta_init ()
{
    docker rm -f -- cdh-meta ;
    docker volume rm -- cdh-meta-mysqldata ;
    
    local pswd_suffix &&
    
    local port_set="${1:-$PORT}" &&
    local volume_set="${2:-$VOLUME}" &&
    
    ! test -z $PSWD_SUFFIX ||
        read -p 'cdh meta dbs passwd suffix: ' -- pswd_suffix &&
    
    docker run --restart always -d --name cdh-meta \
        --env PSWD_SUFFIX="${pswd_suffix:-$PSWD_SUFFIX}" \
        --env MYSQL_ROOT_PASSWORD="root-${pswd_suffix:-$PSWD_SUFFIX}" \
        -v "${volume_set:-cdh-meta-mysqldata}":/var/lib/mysql \
        -p "${port_set:-3306}":3306 \
        -- cdh-meta &&
    
    :;
    
    local r=$? ;
    unset pswd ;
    return $r ;
} &&

cdhmeta_init 3306 cdh-meta-mysqldata
