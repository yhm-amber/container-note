use alpine shell ...

--------


# fp.sh

~~~ md
😈 Just using basic feature of SHell, and pass the tests on the `ash`. 🥗
~~~

一个仅基于基本 SHell 特性的 Functional Programming 工具集。
在 Alpine Ash SHell 通过测试。

## Thanks for

- [you-dont-need/You-Dont-Need-Loops: Avoid The One-off Problem, Infinite Loops, Statefulness and Hidden intent.](https://github.com/you-dont-need/You-Dont-Need-Loops)

## Playings

使用例

### Fibonacci

*iterator style :*

~~~ sh
# use tmp asigns (more quick ... maybe)
fib () 
(
    _x=0 _y=0 _z=1 \
    iterator='
        
        test "$x" -eq "'"${n:-13}"'" && break ; 
        _x="$((x + 1))" _y="$((z))" _z="$((y + z))"
        
        ' fp iterate \
    eval '
        
        x="$_x" y="$_y" z="$_z" ; 
        printf '"'${fmt:-%d: %d\\n}' ${mapas:-\"\$x\" \"\$y\"}" &&
    
    : ) ;

# or use the Tuple inside the fp (more simple ~)
fib () 
(
    x=0 y=0 z=1 \
    iterator='
        
        test "$x" -eq "'"${n:-13}"'" && break ; 
        fielder=",$IFS" Tuple -- x y z < <(echo "$((x + 1)), $((z)), $((y + z))")
        
        ' fp iterate \
    eval printf "'${fmt:-%d: %d\\n}' ${mapas:-\"\$x\" \"\$y\"}" &&
    
    : ) ;
~~~        

~~~ sh
fmt='%i %i, ' n=13 fib
# 0 0, 1 1, 2 1, 3 2, 4 3, 5 5, 6 8, 7 13, 8 21, 9 34, 10 55, 11 89, 12 144, 13 233, 
~~~

*reduce style :*

~~~ sh
fib ()
(
    acc="0${ofs:-, }0${ofs:-, }1${ofs:-, }_" \
    f='
        
        echo "$(
            
            fielder="${ofs:-,}$IFS" Tuple -d "${concater:-${IFS: -1}}" -- x y z _ < <(echo "$acc") ;
            echo "$((x + 1))${ofs:-, }$((z))${ofs:-, }$((y + z))${ofs:-, }${q}"
            
            )${concater:-${IFS: -1}}${acc}"
        
        ' fp reduce q < <(seq "$@") &&
    
    : ) ;
~~~

~~~ sh
ofs=' ' fib 13 | f='"$x $y"' fp map -- x y _ _ | tac | f='printf "%s, " "$x $y"' fp per -- x y
# 0 0, 1 1, 2 1, 3 2, 4 3, 5 5, 6 8, 7 13, 8 21, 9 34, 10 55, 11 89, 12 144, 13 233, 
~~~

*unfold style :*

~~~ sh
: style 1
# codegen then pipe (meta-programming like)

fib ()
(
    n="${n}" echoer="${echoer:-echo \"\$x \$y \$z\"}" \
    init='Tuple -- x y z < <(echo "$initer") && '"$echoer" \
    unfolder=' { Tuple -- x y z < <(echo "$((x + 1)) $((z)) $((y + z))") && '"$echoer"' ; } ' \
    folder='echo "${acc} ${processes}"' delimiter=' &&' \
    initer='0 0 1' fp unfold eval 'eval "$(cat -) :"' &&
    
    : ) ;

echoer='printf "%s, " "$x $y"' n=13 fib
# 0 0, 1 1, 2 1, 3 2, 4 3, 5 5, 6 8, 7 13, 8 21, 9 34, 10 55, 11 89, 12 144, 13 233, 

: style 2
# direct run inner the reduce and message to stderr (side effect like)

fib ()
(
    n="${n}" echoer='echo "$x $y $z"' init='0 0 1' returner="${returner:-$echoer}" \
    unfolder=' { Tuple -- x y z < <(echo "$((x + 1)) $((z)) $((y + z))") && '"$echoer"' ; } ' \
    folder='Tuple -- x y z < <(echo "$acc") && erro '"$returner"' && eval "$processes"' \
    fp unfold cat - | f="$returner" fp per -- x y z &&
    
    : ) ;

returner='printf "%s, " "$x $y"' n=13 fib
# 0 0, 1 1, 2 1, 3 2, 4 3, 5 5, 6 8, 7 13, 8 21, 9 34, 10 55, 11 89, 12 144, 13 233, 
# --- attention: only last one is stdout, other all before it both are stderr.
~~~

## Funcs

简介

### `Tuple`

~~~ sh
Tuple -- x y < <(echo X Y) # then $x will be "X" and $y will be "Y"
fielder=",$IFS" Tuple -- x y < <(echo 'XX, YY') # then $x will be "XX" and $y will be "YY"
~~~

*Just use it inside these fp tools.*

### `trim`

~~~ sh
fp trim $'  \n  U W U \n   \n\n ' $'  \n  U W U \n   \n\n '
~~~

~~~
U W U



  U W U
~~~


### `formatf`

~~~ sh
formatter=' _%s' fp formatf $(seq 12)
~~~

~~~
 _1 _2 _3 _4 _5 _6 _7 _8 _9 _10 _11 _12
~~~

*equal with :*

~~~ sh
f='printf \ _%s "$x"' fp per x < <(seq 12)
~~~


### `iterate`

*see the Fibonacci ...*

*and many things are warppings on `iterate` ...*

### `per`

~~~ sh
seq 2 2 8 | cat -n | f='echo "$x -> $y"' fp per x y
~~~

~~~
1 -> 2
2 -> 4
3 -> 6
4 -> 8
~~~

~~~ sh
echo a,b,c:d,e,f: | fielder=, f='echo "$z ~ $x -> $y"' fp per -d : -- y x z
~~~

~~~
c ~ b -> a
f ~ e -> d
~~~

### `reduce`

~~~ sh
seq 7 | acc=3 f='echo $((x + acc))' fp reduce -- x # 31
echo a,b,c:d,e,f: | fielder=, acc='' f='echo "$y .. $z .. $x ~ $acc"' fp reduce -d : -- x y z # e .. f .. d ~ b .. c .. a ~
~~~

*or see the Fibonacci ...*

*and `map` is a func that warpping on `reduce` ...*

### `map`

~~~ sh
seq 2 2 8 | cat -n | f='"$x -> $y"' fp map x y
~~~

~~~
1 -> 2
2 -> 4
3 -> 6
4 -> 8
~~~

~~~ sh
echo a,b,c:d,e,f: | fielder=, f='"$z ~ $x -> $y"' fp map -d : -- y x z
~~~

~~~

c ~ b -> a
f ~ e -> d

~~~


### `repeat`

~~~ sh
repeater=21 fp repeat AA BBB CCCC
~~~

~~~
AA AA AA AA AA AA AA AA AA AA AA AA AA AA AA AA AA AA AA AA AA
BBB BBB BBB BBB BBB BBB BBB BBB BBB BBB BBB BBB BBB BBB BBB BBB BBB BBB BBB BBB BBB
CCCC CCCC CCCC CCCC CCCC CCCC CCCC CCCC CCCC CCCC CCCC CCCC CCCC CCCC CCCC CCCC CCCC CCCC CCCC CCCC CCCC
~~~

~~~ sh
ofs='!?::' repeater=5 fp repeat AA BBB CCCC
~~~

~~~
!?::AA!?::AA!?::AA!?::AA!?::AA!?::
!?::BBB!?::BBB!?::BBB!?::BBB!?::BBB!?::
!?::CCCC!?::CCCC!?::CCCC!?::CCCC!?::CCCC!?::
~~~

~~~ sh
ofs=' ' concater=$'\n:;;:' repeater=3 fp repeat AA BBB CCCC
~~~

~~~
:;;:AA AA AA
:;;:BBB BBB BBB
:;;:CCCC CCCC CCCC
:;;:
~~~

### `unfold`

*also see the Fibonacci ...*

*and `unfold` is a warpping on `map` and `reduce` ...*

## See also

- [We all know `iter` is faster than `loop`, but why? | The Rust Programming Language Forum](https://users.rust-lang.org/t/we-all-know-iter-is-faster-than-loop-but-why)



