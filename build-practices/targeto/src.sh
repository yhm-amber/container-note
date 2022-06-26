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
    
    
    gettor ()
    {
        :;
        
        local image_name="$1" && shift 1 &&
        
        mode__disc ()
        {
            : make
            
            : mode__disc /opt/sdk:sdk:/opt/sdk $PWD/app:app:/opt/app
            
            : as
            
            : gettor disc-sdk /opt/sdk:.
            : gettor disc-app $PWD/app:.
            
            :;
            
            disc_per ()
            {
                : disc_per $PWD/app app /opt/app
                
                :;
                
                local disc_dir="$1" && shift 1 &&
                local disc_name="$1" && shift 1 &&
                local disc_for="$1" && shift 1 &&
                
                gettor disc-"$disc_name" "$disc_dir":.
                
                :;
                
            } &&
            
            disc_per_o ()
            {
                : disc_o $PWD/app app /opt/app
                
                :;
                
                local disc_dir="$1" && shift 1 &&
                local disc_name="$1" && shift 1 &&
                local disc_for="$1" && shift 1 &&
                
                echo disc: now you may want your "'$disc_dir'" in disc-"$disc_name" mount as "'$disc_for'" in some container.
                
                :;
                
            } &&
            
            
            export -f -- disc_per disc_per_o || { echo fun err ; return 7 ; }
            
            :;
            
            
            rtb "$@" | xargs -i -- $SHELL -c 'disc_per {}' &&
            
            echo :::::::: :: :::::::: :::::::: :: :::::::: &&
            
            rtb "$@" | xargs -i -- $SHELL -c 'disc_per_o {}' &&
            
            :;
            
        } &&
        
        
        if type -f -- mode_"$image_name" ;
        
        then
            
            : special mode way
            
            (mode_"$image_name" "$@") &&
            
            :;
            
        else
            
            : normal mode way
            
            mkdir -p -- "$image_name" ;
            
            (
                cd "$image_name" &&
                
                
                d "$image_name" .tgt "$@" > Dockerfile &&
                s targeto > src.sh &&
                
                c $(F=1 rtb "$@") > "$image_name".tar.zst &&
                
                eval "$(p "$image_name")" &&
                
                : ) &&
            
            o "$image_name" .tgt &&
            
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
            
            :;
            
        } &&
        
        
        IMG_NAME="$image_name" DIR_AIM="$tgtdir_name" DIR_AIMS=$(
            
            F='(NF+1)"./\""$2"\""' rtb "$@" &&
            
            : ) DIR_PAIRS="$*" dockerfile_echos &&
        
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
        
        
        echo ; echo  :::::::: :: :::::::: :: :::::::: :: ::::::::
        echo  img: "'$image_name'"
        echo  usage: docker run --rm -v volume-"'$image_name'":"'/${image_name}/${tgtdir_name}'" -- "'$image_name'"
        echo  then: You have your aim things in your volume now 🦾！ ; echo
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
            
            F='(NF+1)"mv","from/\""$1"\"","'"$tgtdir"'/\""$2"\""' rtb $DIR_PAIRS &&
            
            : )" &&
        
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
