: :::::::::::::::::::::::::::::::::::::::::::::::::: :
: :::: 🦝 Welcome to using the tool Targeto 🦝 :::: :
: :::: 🦾 Having Fun to play With This tool 🦾 :::: :
: :::::::::::::::::::::::::::::::::::::::::::::::::: :


: ::::::::: lib toys ::::::::: :

targeto ()
{
    : demo
    : targeto gettor pkg/disc img-name /opt/sdk:/opt/sdk $PWD/app:/opt/app
    
    : should
    : get a oci img include tar.xz/zst
    
    : and
    : descs
        
    :;
    
    
    gettor ()
    {
        :;
        
        
        local tgt_type="$1" && shift 1 &&
        local image_name="$1" && shift 1 &&
        
        
        (
            mkdir -p -- "$image_name" ;
            
            cd "$image_name" &&
            
            
            d "$image_name" "$tgt_type" "$@" > Dockerfile &&
            s targeto > src.sh &&
            
            c $(F=1 rtb "$@") > "$image_name".tar.zst &&
            
            eval "$(p "$image_name")" &&
            
            
            : ) &&
        
        o "$image_name" "$tgt_type" &&
        
        :;
        
    } &&
    
    
    d ()
    {
        : d img-name tgt/disc /opt/sdk:/opt/sdk $PWD/app:/opt/app
        
        :;
        
        local image_name="$1" && shift 1 &&
        local tgt_type="$1" && shift 1 &&
        
        
        
        
        dockerfile_echos_pkg ()
        {
            echo  FROM targeto
            
            echo  WORKDIR /"$IMG_NAME"
            
            echo  COPY Dockerfile src.sh ./
            echo  COPY "$IMG_NAME".tar.zst ./
            
            echo  ENV DIR_PAIRS="'$DIR_PAIRS'"
            echo  RUN mkdir .pkg '&&' cd .pkg '&&' mkdir -p -- $DIR_AIMS
            
            echo  ENTRYPOINT '["bash","src.sh"]'
            echo  CMD '["targeto","x","pkg","'"$IMG_NAME"'.tar.zst"]'
            
            :;
            
        } &&
        
        dockerfile_echos_disc ()
        {
            echo  FROM targeto
            
            echo  WORKDIR /"$IMG_NAME"
            
            echo  COPY Dockerfile src.sh ./
            echo  COPY "$IMG_NAME".tar.zst ./
            
            echo  ENV DIR_PAIRS="'$DIR_PAIRS'"
            echo  RUN mkdir .disc
            
            echo  ENTRYPOINT '["bash","src.sh"]'
            echo  CMD '["targeto","x","disc","'"$IMG_NAME"'.tar.zst"]'
            
            :;
            
        } &&
        
        
        IMG_NAME="$image_name" DIR_PAIRS="$*" DIR_AIMS=$(
            
            F='(NF+1)"./\""$2"\""' rtb "$@" &&
            
            : ) dockerfile_echos_"$tgt_type" &&
        
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
    
    c () # need type.
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
        : o img-name pkg/disc
        
        :;
        
        local image_name="$1" && shift 1 &&
        local tgt_type="$1" && shift 1 &&
        
        
        echo ; echo  :::::::: :: :::::::: :: :::::::: :: ::::::::
        echo  img: "'$image_name'"
        echo  usage: docker run --rm -v volume-"'$image_name'":"'/${image_name}/.${tgt_type}'" -- "'$image_name'"
        echo  then: You have your things in your volume now 🦾！ ; echo
    } &&
    
    x ()
    {
        : x pkg/disc img-name.tar.zst
        
        : xz: -c, --stdout, --to-stdout
        : xz: -d, --decompress, --uncompress
        
        :;
        
        local tgt_type="$1" && shift 1 &&
        local xzfile="$1" && shift 1 &&
        
        (
            mkdir -p -- from ;
            
            cd from &&
            
            zstd -c -d -- ../"$xzfile" |
                
                tar -xf- -- &&
            
            : ) &&
        
        
        eval "$(
            
            F='(NF+1)"mv","from/\""$1"\"","'".$tgt_type"'/\""$2"\""' rtb $DIR_PAIRS &&
            
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
