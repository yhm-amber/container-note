: ::::::::::::::::::::::::::::::::::::::::::: :
: :::: 🌕 Welcome to tasting Targeto 🌕 :::: :
: :::: 🌑 Having Fun to play with me 🌑 :::: :
: ::::::::::::::::::::::::::::::::::::::::::: :
: :::::::::::::::: :
: :: version: 1 :: :
: :::::::::::::::: :



: ::::::::: lib toy ::::::::: :

plan ()
(cat 'plan 🦪') &&
🦪 () (plan) ;

targeto ()
{
    : demo
    
    : targeto take img-name /opt/sdk1:/opt/sdk0 $PWD/app:/opt/app
    
    
    
    : should be
    
    
    : then: docker run --rm -v sdk:/opt/sdk1 -v app:$PWD/app -- img-name
    
    : out: name='img-name' from='/opt/sdk1' moon='/opt/sdk0' sing=':::: ~ 🌕 fly me to the moon 🌑 ~ ::::'
    : ...: name='img-name' from='$PWD/app' moon='/opt/app' sing=':::: ~ 🌕 fly me to the moon 🌑 ~ ::::'
    
    
    
    
    : and
    
    : targeto disc /opt/sdk1:sdk-initer:/opt/sdk0 $PWD/app:app-initer:/opt/app
    
    
    
    : should same as
    
    : targeto take sdk-initer /opt/sdk1:/opt/sdk0
    : targeto take app-initer $PWD/app:/opt/app
    
    
    
    
    :;
    
    export SING_MOON=':::: ~ 🌕 fly me to the moon 🌑 ~ ::::'
    
    
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
    
    
    :;
    
    
    
    take ()
    {
        : take img-name /opt/sdk1:/opt/sdk0 $PWD/app:/opt/app
        
        
        : should be
        
        
        : then: docker run --rm -v sdk:/opt/sdk1 -v app:$PWD/app -- img-name
        
        : out: name='img-name' from='/opt/sdk1' moon='/opt/sdk0' sing=':::: ~ 🌕 fly me to the moon 🌑 ~ ::::'
        : ...: name='img-name' from='$PWD/app' moon='/opt/app' sing=':::: ~ 🌕 fly me to the moon 🌑 ~ ::::'
        
        
        :;
        
        
        
        local image_name="$1" && shift 1 &&
        
        local SING_MOON="$SING_MOON" &&
        local COMP_LEVEL="$COMP_LEVEL" &&
        local RTB_D="$RTB_D" &&
        
        
        
        
        mkdir -p -- "$(basename "$image_name")" ;
        
        if : &&
        
        (
            cd "$(basename "$image_name")" &&
            
            
            RTB_D="$RTB_D" d "$(basename "$image_name")" "$@" > Dockerfile &&
            
            COMP_LEVEL="$COMP_LEVEL" c $(RTB_D="$RTB_D" F=1 rtb "$@") > "$(basename "$image_name")".tar.zst &&
            
            SING_MOON="$SING_MOON" o "$image_name" "$@" > o.msg &&
            
            eval "$(p "$image_name")" &&
            
            : ) ;
        
        then
            
            echo 🥽 :succ :take "'$image_name'" RTB_D="'$RTB_D'" "'$*'" ;
            
            return 0 ;
            
            :;
            
        else
            
            echo 👙 :fail :take "'$image_name'" RTB_D="'$RTB_D'" "'$*'" ;
            
            return 2 ;
            
            :;
            
        fi &&
        
        
        echo :done take &&
        
        :;
        
    } &&
    
    disc ()
    {
        : disc /opt/sdk1:sdk-initer:/opt/sdk0 $PWD/app:app-initer:/opt/app
        
        : be
        
        : targeto take sdk-initer /opt/sdk1:/opt/sdk0
        : targeto take app-initer $PWD/app:/opt/app
        
        :;
        
        
        local SING_MOON="$SING_MOON" &&
        local COMP_LEVEL="$COMP_LEVEL" &&
        local RTB_D="$RTB_D" &&
        
        
        
        
        disc_per ()
        {
            : disc_per /opt/sdk1 sdk-initer /opt/sdk0
            
            : moon means where should be MOunt ON
            
            :;
            
            local disc_from="$1" && shift 1 &&
            local disc_name="$1" && shift 1 &&
            local disc_moon="$1" && shift 1 &&
            
            local SING_MOON="$SING_MOON" &&
            local COMP_LEVEL="$COMP_LEVEL" &&
            local RTB_D="$RTB_D" &&
            
            
            
            SING_MOON="$SING_MOON" COMP_LEVEL="$COMP_LEVEL" RTB_D="$RTB_D" targeto take "$(
                
                dirname "$disc_name" &&
                
                : )"/"disc-$(
                
                basename "$disc_name" &&
                
                : )" "${disc_from}${RTB_D:-:}${disc_moon}" &&
            
            :;
            
        } &&
        
        export -f -- $(try t function zstd && echo zstd) targeto disc_per ||
            
            { 1>&2 echo disc: fun or lib err ; return 7 ; } ;
        
        :;
        
        if : &&
        
        (
            export COMP_LEVEL="$COMP_LEVEL" &&
            export RTB_D="$RTB_D" &&
            
            RTB_D="$RTB_D" F=0 rtb "$@" |
                
                xargs -i -- $SHELL -c 'RTB_D="$RTB_D" COMP_LEVEL="$COMP_LEVEL" SING_MOON="$SING_MOON" disc_per {}' &&
            
            : ) ;
        
        then
            
            echo 🥽 :succ :disc RTB_D="'$RTB_D'" "'$*'" &&
            
            :;
            
        else
            
            echo 👿 '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!' 👿 &&
            echo 👿 '!!!!!!!!!!' disc: Err have '!!' '!!!!!!!!!!' 👿 &&
            echo 👿 '!!!!!!!!!!' disc: Check It '!!' '!!!!!!!!!!' 👿 &&
            echo 👿 '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!' 👿 &&
            
            echo 👙 :fail :disc RTB_D="'$RTB_D'" "'$*'" &&
            
            :;
            
        fi &&
        
        :;
        
    } &&
    
    
    d ()
    {
        : d img-name /opt/sdk1:/opt/sdk0 $PWD/app:/opt/app
        
        
        : then: docker run --rm -v sdk:/opt/sdk1 -v app:$PWD/app -- img-name
        
        : out: from='/opt/sdk1' img='img-name' moon='/opt/sdk0' sing=':::: ~ 🌕 fly me to the moon 🌑 ~ ::::'
        : ...: from='$PWD/app' img='img-name' moon='/opt/app' sing=':::: ~ 🌕 fly me to the moon 🌑 ~ ::::'
        
        
        :;
        
        local image_name="$1" && shift 1 &&
        
        local RTB_D="$RTB_D" &&
        
        
        
        dockerfile_echos ()
        {
            
            echo        FROM targeto                                          &&
            echo                                                              &&
            echo        WORKDIR /"$IMG_NAME"                                  &&
            echo                                                              &&
            echo        ENV DIR_PAIRS="'$DIR_PAIRS'" RTB_D="'$RTB_D'"         &&
            echo                                                              &&
            echo        ENTRYPOINT '["bash","/targeto/src.sh"]'               &&
            echo        CMD '["targeto","x","'"$IMG_NAME"'.tar.zst"]'         &&
            echo                                                              &&
            echo                                                              &&
            echo        COPY Dockerfile "$IMG_NAME".tar.zst ./                &&
            echo        COPY o.msg ./                                         &&
            echo                                                              &&
            echo        RUN awk "'"'{print"💿",$0}'"'" o.msg                  &&
            
            :;
            
        } &&
        
        
        IMG_NAME="$image_name" DIR_PAIRS="$*" RTB_D="$RTB_D" dockerfile_echos &&
        
        :;
        
    } &&
    
    
    c ()
    {
        : c /opt/sdk0 $PWD/app
        : COMP_LEVEL=15 c /opt/sdk0 $PWD/app
        
        :;
        
        local COMP_LEVEL="$COMP_LEVEL" &&
        
        tar -c -P -f- -- "$@" |
            
            zstd -c -"${COMP_LEVEL:-13}" -T0 &&
        
        :;
        
    } &&
    
    
    o ()
    {
        : o ns/img-name /opt/sdk1:/opt/sdk0 $PWD/app:/opt/app
        
        :;
        
        local image_name="$1" && shift 1 &&
        
        local RTB_D="$RTB_D" &&
        
        
        
        
        in_awk ()
        {
            
            printf      '(NF+1)"name=%s"'            "'${IMG_NAME}'"          &&
            printf      ", \"from='\"%s\"'\""        '$1'                     &&
            printf      ", \"moon='\"%s\"'\""        '$2'                     &&
            printf      ', "sing=%s"'                "'${SING_MOON}'"         &&
            
            :;
            
        } &&
        
        RTB_D="$RTB_D" F="$(IMG_NAME="$image_name" SING_MOON="$SING_MOON" in_awk)" rtb "$@" &&
        
        :;
        
    } &&
    
    
    p ()
    {
        : p ns/img-name
        
        :;
        
        local image_name="$1" && shift 1 &&
        
        echo docker build -t "'$image_name'" -f Dockerfile -- . &&
        
        :;
        
    } &&
    
    
    
    x ()
    {
        : x img-name.tar.zst
        
        : xz/zst: -c, --stdout, --to-stdout
        : xz/zst: -d, --decompress, --uncompress
        
        :;
        
        local xzfile="$1" && shift 1 &&
        
        if : &&
        
        (
            zstd -c -d -- "$xzfile" |
                
                tar -x -P -f- -- &&
            
            cat o.msg &&
            
            : ) ;
        
        then
            
            echo 🧊 :succ :x "$xzfile" &&
            
            return 0 ;
            
            :;
            
        else
            
            echo 🍨 :fail :x "$xzfile" &&
            
            return 16 &&
            
            :;
            
        fi &&
        
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
        
        : W=sdk F="(NF+1)\"name='${image_name}'\",\"from='\"\$1\"'\",\"moon='\"\$2\"'\",\"sing='${SING_MOON}'\"" rtb /opt/sdk1:/opt/sdk0 /xxx/app:/opt/app
        : get: name='img-name' from='/opt/sdk1' moon='/opt/sdk0' sing=':::: ~ 🌕 fly me to the moon 🌑 ~ ::::'
        
        :;
        
        local RTB_D="$RTB_D" &&
        
        for pair in "$@" ;
        do
            echo "$pair" | tr "${RTB_D:-:}" ' ' ;
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
