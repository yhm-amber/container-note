: :::::::::::::::::::::::::::::::::::::::::::::::::: :
: :::: 🦝 Welcome to using the tool Targeto 🦝 :::: :
: :::: 🦾 Having Fun to play With This tool 🦾 :::: :
: :::::::::::::::::::::::::::::::::::::::::::::::::: :


: ::::::::: lib toys ::::::::: :

targeto ()
{
    : demo
    
    : targeto gettor img-name /opt/sdk:/opt/sdk $PWD/app:/opt/app
    : targeto gettor _disc /opt/sdk:sdk:/opt/sdk $PWD/app:app:/opt/app
    
    : should
    
    : get a oci img include tar.zst
    : get some oci imgs include their tar.zst
    
    : and
    
    : descs
    : descs
        
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
    
    :;
    
    gettor ()
    {
        :;
        
        local image_name="$1" && shift 1 &&
        
        local TGT="$TGT" &&
        
        
        mode__disc ()
        {
            : make
            
            : mode__disc /opt/sdk:sdk:/opt/sdk $PWD/app:app:/opt/app
            
            : as
            
            : gettor disc-sdk /opt/sdk/*:.
            : gettor disc-app $PWD/app/*:.
            
            :;
            
            export SING_MOON=':::: ~ 💿 fly me to the moon 💿 ~ ::::' &&
            
            
            disc_per ()
            {
                : disc_per $PWD/app app /opt/app
                
                :;
                
                local disc_dir="$1" && shift 1 &&
                local disc_name="$1" && shift 1 &&
                local disc_for="$1" && shift 1 &&
                
                local X_SING="$X_SING" &&
                local X_MSGS="from='${disc_dir}' img='disc-${disc_name}' moon='${disc_for}'" &&
                
                X_MSG="$X_MSGS sing='$X_SING'" TGT=.disc targeto gettor disc-"$disc_name" "$disc_dir"/*:. &&
                
                :;
                
            } &&
            
            disc_per_o ()
            {
                : disc_o $PWD/app app /opt/app
                
                :;
                
                local disc_dir="$1" && shift 1 &&
                local disc_name="$1" && shift 1 &&
                local disc_for="$1" && shift 1 &&
                
                echo disc: from="'$disc_dir'" img=disc-"$disc_name" moon="'$disc_for'" &&
                
                :;
                
            } &&
            
            
            export -f -- $(try t function zstd && echo zstd) targeto disc_per disc_per_o ||
                
                { echo fun or lib err ; return 7 ; } ;
            
            :;
            
            
            rtb "$@" | xargs -i -- $SHELL -c 'X_SING="$SING_MOON" disc_per {}' &&
            
            ( echo ; echo :::::::: :: :::::::: :: :::::::: :: :::::::: ; echo ) &&
            
            rtb "$@" | xargs -i -- $SHELL -c 'disc_per_o {}' &&
            
            ( echo ; echo "$SING_MOON" ; echo ) &&
            
            :;
            
        } &&
        
        
        
        
        if try t function mode_"$image_name" ;
        
        then
            
            : special mode way
            
            (mode_"$image_name" "$@") &&
            
            :;
            
        else
            
            : normal mode way
            
            mkdir -p -- "$image_name" ;
            
            (
                cd "$image_name" &&
                
                
                d "$image_name" "${TGT:-.tgt}" "$@" > Dockerfile &&
                s targeto > src.sh &&
                
                c $(F=1 rtb "$@") > "$image_name".tar.zst &&
                
                eval "$(p "$image_name")" &&
                
                : ) &&
            
            o "$image_name" "${TGT:-.tgt}" &&
            
            :;
            
        fi &&
        
        
        
        :;
        
    } &&
    
    
    d ()
    {
        : d img-name tgtdir-name /opt/sdk:/opt/sdk $PWD/app:/opt/app
        
        :;
        
        local image_name="$1" && shift 1 &&
        local tgtdir_name="$1" && shift 1 &&
        
        local X_MSG="$X_MSG" &&
        
        
        
        dockerfile_echos ()
        {
            echo  FROM targeto
            
            echo  WORKDIR /"$IMG_NAME"
            
            echo  COPY Dockerfile src.sh ./
            echo  COPY "$IMG_NAME".tar.zst ./
            
            echo  ENV DIR_PAIRS="'$DIR_PAIRS'"
            echo  RUN mkdir "$DIR_AIM" '&&' cd "$DIR_AIM" '&&' mkdir -p -- $DIR_AIMS
            
            echo  ENTRYPOINT '["bash","src.sh"]'
            echo  CMD '["targeto","x","'"$IMG_NAME"'.tar.zst","'"$DIR_AIM"'"]'
            
            
            echo  ENV X_MSG='"'"$X_MSG"'"'
            
            :;
            
        } &&
        
        
        IMG_NAME="$image_name" DIR_PAIRS="$*" DIR_AIM="$tgtdir_name" DIR_AIMS=$(
            
            F='(NF+1)"./\""$2"\""' rtb "$@" &&
            
            : ) X_MSG="${X_MSG:-popout=.tgt}" dockerfile_echos &&
        
        :;
        
    } &&
    
    s ()
    {
        : s targeto
        
        :;
        
        local fname="$1" && shift 1 &&
        
        (
            declare -f -- "${fname:-targeto}" &&
            
            echo && echo '"$@"' ) &&
        
        :;
        
    } &&
    
    c ()
    {
        : c /opt/sdk xxx/app
        
        :;
        
        tar -cf- -- "$@" |
            
            zstd -c -18 -T0 &&
        
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
        echo  img name : "'$image_name'" --- you can use it as an init-container. &&
        echo  use like : docker run --rm -v volume-"$image_name":"/${image_name}/${tgtdir_name}" -- "$image_name" &&
        echo  chk like : docker run --rm -v volume-"$image_name":/look-it -- alpine ls -l /look-it &&
        ( echo ; echo  🦾 ~ and You will have your aim things in your volume ~ 🦾 ; echo ) &&
        
        :;
        
    } &&
    
    x ()
    {
        : x img-name.tar.zst target-dir
        
        : xz: -c, --stdout, --to-stdout
        : xz: -d, --decompress, --uncompress
        
        :;
        
        local xzfile="$1" && shift 1 &&
        local tgtdir="$1" && shift 1 &&
        
        (
            mkdir -p -- from ;
            
            cd from &&
            
            zstd -c -d -- ../"$xzfile" |
                
                tar -xf- -- &&
            
            : ) &&
        
        
        eval "$(
            
            F='(NF+1)"mv","from/"$1,"'"$tgtdir"'/"$2' rtb $DIR_PAIRS &&
            
            : )" &&
        
        echo "$X_MSG" &&
        
        :;
        
    } &&
    
    rtb ()
    {
        : rtb /opt/sdk:/opt/sdk $PWD/app:/opt/app
        : get: /opt/sdk /opt/sdk'<br>'$PWD/app /opt/app
        
        : F=1 rtb /opt/sdk:/opt/sdk $PWD/app:/opt/app
        : get: /opt/sdk'<br>'$PWD/app
        
        : W=app rtb /opt/sdk:/opt/sdk $PWD/app:/opt/app
        : get: $PWD/app /opt/app
        
        : W=app F='(NF+1)"mv","from/"$1,"to/"$2' rtb /opt/sdk:/opt/sdk /xxx/app:/opt/app
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

"$@" ; exit $? ;

: :::::::::::::::::::::::::::: :


# (
#     cd && cd container-note/build-practices/targeto &&
#     git pull && docker build -t "$(basename $PWD)" -f Dockerfile -- . &&
#     eval "$(echo docker.io/amberyhm ghcr.io/yhm-amber | xargs -n1 | xargs -i -- echo docker tag targeto {}/targeto)" &&
#     ( docker push docker.io/amberyhm/targeto ; docker push ghcr.io/yhm-amber/targeto ) )

