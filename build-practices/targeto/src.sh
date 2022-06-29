: ::::::::::::::::::::::::::::::::::::::::::: :
: :::: 💿 Welcome to tasting Targeto 💿 :::: :
: :::: 🎛️ Having Fun to play with me 🎛️ :::: :
: ::::::::::::::::::::::::::::::::::::::::::: :
: :::::::::::::::: :
: :: version: 1 :: :
: :::::::::::::::: :



: ::::::::: lib toys ::::::::: :

targeto ()
{
    : demo
    
    : targeto take img-name /opt/sdk1:/opt/sdk0 $PWD/app:/opt/app
    
    
    : should be
    
    
    : then: docker run --rm -v sdk:/opt/sdk1 -v app:$PWD/app -- img-name
    
    : out: name='img-name' from='/opt/sdk1' moon='/opt/sdk0' sing=':::: ~ 💿 fly me to the moon 💿 ~ ::::'
    : ...: name='img-name' from='$PWD/app' moon='/opt/app' sing=':::: ~ 💿 fly me to the moon 💿 ~ ::::'
    
    
    : and
    
    : targeto disc /opt/sdk1:sdk-initer:/opt/sdk0 $PWD/app:app-initer:/opt/app
    
    
    : need to same as
    
    : targeto take sdk-initer /opt/sdk1:/opt/sdk0
    : targeto take app-initer $PWD/app:/opt/app
    
    
    
    :;
    
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
    
    test "$(type -t -- try)" == function ||
        
        { 1>&2 echo lib "'try'" lost ; return 6 ; } ;
    
    export SING_MOON=':::: ~ 💿 fly me to the moon 💿 ~ ::::' &&
    
    :;
    
    
    
    take ()
    {
        :;
        
        local image_name="$1" && shift 1 &&
        
        
        mkdir -p -- "$image_name" ;
        
        if : &&
        
        (
            cd "$image_name" &&
            
            
            d "$image_name" "$@" > Dockerfile &&
            
            c $(F=1 rtb "$@") > "$image_name".tar.zst &&
            
            eval "$(p "$image_name")" &&
            
            : ) ;
        
        then
            
            o "$image_name" &&
            
            :;
            
        else
            
            :;
            
        fi &&
        
        :;
        
    } &&
    
    disc ()
    {
        : disc /opt/sdk1:sdk-initer:/opt/sdk0 $PWD/app:app-initer:/opt/app
        
        : be
        
        : targeto take sdk-initer /opt/sdk1:/opt/sdk0
        : targeto take app-initer $PWD/app:/opt/app
        
        :;
        
        
        disc_per ()
        {
            : disc_per /opt/sdk1 sdk-initer /opt/sdk0
            
            : moon means where should be MOunt ON
            
            :;
            
            local disc_from="$1" && shift 1 &&
            local disc_name="$1" && shift 1 &&
            local disc_moon="$1" && shift 1 &&
            
            local X_SING="$X_SING" &&
            local X_MSGS="from='${disc_from}' name='disc-${disc_name}' moon='${disc_moon}'" &&
            
            X_MSG="$X_MSGS sing='$X_SING'" targeto gettor disc-"$disc_name" "$disc_from"/*:. &&
            
            echo "$X_MSGS" &&
            
            :;
            
        } &&
        
        export -f -- $(try t function zstd && echo zstd) targeto disc_per ||
            
            { 1>&2 echo disc: fun or lib err ; return 7 ; } ;
        
        :;
        
        if : &&
        
        ( rtb "$@" | xargs -i -- $SHELL -c 'X_SING="$SING_MOON" disc_per {}' ) ;
        
        then
            
            ( echo ; echo :::::::: :: :::::::: :: :::::::: :: :::::::: ; echo ) &&
            
            ( echo ; echo "$SING_MOON" ; echo ) &&
            
            :;
            
        else
            
            echo 👿 '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!' 👿 &&
            echo 👿 '!!!!!!!!!!' disc: Err have '!!!!!!!!!!' 👿 &&
            echo 👿 '!!!!!!!!!!' disc: Check It '!!!!!!!!!!' 👿 &&
            echo 👿 '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!' 👿 &&
            
            :;
            
        fi &&
        
        :;
        
    } &&
    
    
    d ()
    {
        : d img-name /opt/sdk1:/opt/sdk0 $PWD/app:/opt/app
        
        
        : then: docker run --rm -v sdk:/opt/sdk1 -v app:$PWD/app -- img-name
        
        : out: from='/opt/sdk1' img='img-name' moon='/opt/sdk0' sing=':::: ~ 💿 fly me to the moon 💿 ~ ::::'
        : ...: from='$PWD/app' img='img-name' moon='/opt/app' sing=':::: ~ 💿 fly me to the moon 💿 ~ ::::'
        
        
        :;
        
        local image_name="$1" && shift 1 &&
        
        local X_MSG="$X_MSG" &&
        
        
        
        dockerfile_echos ()
        {
            
            
            echo        FROM targeto                                      &&
            echo                                                          &&
            echo        WORKDIR /"$IMG_NAME"                              &&
            echo                                                          &&
            echo        COPY Dockerfile src.sh ./                         &&
            echo        COPY "$IMG_NAME".tar.zst ./                       &&
            echo                                                          &&
            echo        ENV DIR_PAIRS="'$DIR_PAIRS'"                      &&
            echo                                                          &&
            echo        ENTRYPOINT '["bash","/targeto/src.sh"]'                    &&
            echo        CMD '["targeto","x","'"$IMG_NAME"'.tar.zst"]'     &&
            echo                                                          &&
            echo                                                          &&
            echo        ENV X_MSG='"'"$X_MSG"'"'                          &&
            
            :;
            
        } &&
        
        
        IMG_NAME="$image_name" DIR_PAIRS="$*" X_MSG="${X_MSG:-}" dockerfile_echos &&
        
        :;
        
    } &&
    
    
    c ()
    {
        : c /opt/sdk0 $PWD/app
        
        :;
        
        tar -cPf- -- "$@" |
            
            zstd -c -13 -T0 &&
        
        :;
        
    } &&
    
    
    p ()
    {
        : p img-name
        
        :;
        
        local image_name="$1" && shift 1 &&
        
        echo docker build -t "'$image_name'" -f Dockerfile -- . &&
        
        :;
        
    } &&
    
    o ()
    {
        : o img-name tgtdir-name
        
        :;
        
        local image_name="$1" && shift 1 &&
        local tgtdir_name="$1" && shift 1 &&
        
        
        ( echo ; echo  :::::::: :: :::::::: :: :::::::: :: :::::::: ; echo ) &&
        echo 💿 img name : "'$image_name'" --- you can use it as an init-container. &&
        echo 🔩 use like : docker run --rm -v volume-"$image_name":"/${image_name}/${tgtdir_name}" -- "$image_name" &&
        echo 🎛️ chk like : docker run --rm -v volume-"$image_name":/look-it -- alpine ls -l /look-it &&
        ( echo ; echo  🦾 '~' and You will have your aim things in your volume '~' 🦾 ; echo ) &&
        
        :;
        
    } &&
    
    x ()
    {
        : x img-name.tar.zst
        
        : xz/zst: -c, --stdout, --to-stdout
        : xz/zst: -d, --decompress, --uncompress
        
        :;
        
        local xzfile="$1" && shift 1 &&
        
        
        zstd -c -d -- ../"$xzfile" |
            
            tar -xf- -- &&
        
        
        echo "$X_MSG" &&
        
        :;
        
    } &&
    
    rtb ()
    {
        : rtb /opt/sdk1:/opt/sdk0 $PWD/app:/opt/app
        : get: /opt/sdk1 /opt/sdk0'<br>'$PWD/app /opt/app
        
        : F=1 rtb /opt/sdk1:/opt/sdk0 $PWD/app:/opt/app
        : get: /opt/sdk1'<br>'$PWD/app
        
        : W=app rtb /opt/sdk1:/opt/sdk0 $PWD/app:/opt/app
        : get: $PWD/app /opt/app
        
        : W=app F='(NF+1)"mv","from/"$1,"to/"$2' rtb /opt/sdk1:/opt/sdk0 /xxx/app:/opt/app
        : get: mv from//xxx/app to//opt/app
        
        :;
        
        for pair in "$@" ;
        do
            echo "$pair" | tr : ' ' ;
        done |
            
            awk /"$W"/'{print$'"${F:-0}"'}' &&
        
        :;
    } &&
    
    : || { echo fun err ; return 7 ; }
    
    :;
    
    set -o pipefail ;
    
    "$@" ;
} ;



: ::::::::: fun toys ::::::::: :

installer ()
{
    local img_name="$1" && shift 1 &&
    
    echo '
    
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
        } ; ' &&
    
    echo "$@" | xargs -n1 | xargs -I {F} -- echo '
        
        {F} ()
        {
            try t file podman && alias docker=podman ;
            docker run --rm -i -- '"'$img_name'"' {F} "$@" ;
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
