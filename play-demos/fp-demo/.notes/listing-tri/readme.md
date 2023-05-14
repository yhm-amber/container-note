
[⚗]: https://playground.functional-rewire.com
[Elixir]: https://elixir-lang.org/getting-started/enumerables-and-streams.html

[🥑]: https://www.lua.org/demo.html
[Lua]: https://www.lua.org/pil/11.3.html

[🦀]: https://play.rust-lang.org
[Rust]: https://rust-lang.org

[🧊]: https://typescriptlang.org//play
[TypeScript]: https://typescriptlang.org

[🥓]: https://scastie.scala-lang.org
[Scala]: https://scala-lang.org

# Tail recursion, Reduce, and (lazy) Iterator

尾递归、聚合、与惰性迭代器

## Fibonacci

[fib.wiki:simple/wikipedia.org]: https://simple.wikipedia.org/wiki/Fibonacci_number
[fib.wiki:zh/wikipedia.org]: https://zh.wikipedia.org/wiki/%E6%96%90%E6%B3%A2%E9%82%A3%E5%A5%91%E6%95%B0
[fib.wiki:de/wikipedia.org]: https://de.wikipedia.org/wiki/Fibonaccizahl
[fib.wiki:en/wikipedia.org]: https://en.wikipedia.org/wiki/Fibonacci_sequence
[fib.wiki:fr/wikipedia.org]: https://fr.wikipedia.org/wiki/Suite_de_Fibonacci


[🥗 wiki][fib.wiki:simple/wikipedia.org]

### *TL;DR*

#### *[⚗] [Elixir]*

~~~ elixir
### aim: 
### [ {0, 0}, {1, 1}, {2, 1}, {3, 2}, {4, 3}, {5, 5}, {6, 8}, {7, 13}, {8, 21}, {9, 34}, {10, 55}, {11, 89}, {12, 144}, {13, 233} ]

# tail rec

fn n when not(n < 0) ->
    iter = 
    fn
        
        {^n, r, y, _}, _ -> [{n,y} | r] ;
        {x, r, y, z}, i ->
            
            {x + 1, [{x,y} | r], z, y + z} |> i.(i) ;
    end ;
    
    {0, [], 0, 1} |> iter.(iter) ;
end .(13) |> Enum.reverse ;

# reduce / fold / ...

## Enum.reduce/3
fn n when not(n < 0) ->
    0 .. n
    |> Enum.reduce({[], 0, 1}, fn x, {r, y, z} -> {[{x,y} | r], z, y + z} end)
    |> elem 0 ;
end .(13) |> Enum.reverse ;

# stream / lazylist / iterator / unfold / ...

## Stream.unfold/3
fn n when not(n < -1) ->
    Stream.unfold({0, 0, 1}, fn {x, y, z} -> {{x,y}, {x + 1, z, y + z} } end)
    |> Enum.take n+1 ;
end .(13) ;

## Stream.iterate/3
fn n when not(n < -1) ->
    Stream.iterate({0, 0, 1}, fn {x, y, z} -> {x + 1, z, y + z} end)
    |> Stream.map(fn  {x, y, z} -> {x,y} end)
    |> Enum.take n+1 ;
end .(13) ;
~~~

#### *[🥓] [Scala]*

~~~ scala
/**
 * aim: 
 * List((0,0), (1,1), (2,1), (3,2), (4,3), (5,5), (6,8), (7,13), (8,21), (9,34), (10,55), (11,89), (12,144), (13,233)): List[(Int, BigInt)]
 */

/* tail rec */

// def iter
({ case n if !(n < 0) =>
{
    def iter(x: Int, res: List[(Int, BigInt)], y: BigInt, z: BigInt): List[(Int, BigInt)] = 
        if (x < n) iter(x + 1,(x -> y) :: res, z, y + z) else (x -> y) :: res ;
    iter(0, List(), BigInt(0), BigInt(1))
} }: PartialFunction[Int, List[(Int, BigInt)]] ).apply(13).reverse ;

// def y
({ case n if !(n < 0) =>
{    
    def y [X, Y] (f: (X => Y) => (X => Y))
    : X => Y = 
    {
        case class W(f: W => (X => Y)) 
        { def apply(w: W): X => Y = f(w) } ;
        
        ((g: W => (X => Y)) => g(W(g)))
            .apply(w => f(w(w))(_)) ;
    } ;
    
    (y [((Int, List[(Int, BigInt)], BigInt, BigInt)), List[(Int, BigInt)]] 
    (
        f => 
        { case (x: Int, res: List[(Int, BigInt)], y: BigInt, z: BigInt) => 
            if (x < n) f((x + 1,(x -> y) :: res, z, y + z)) else (x -> y) :: res } 
    
    ) ) ( (0, List(), BigInt(0), BigInt(1)) ) ;
    
} }: PartialFunction[Int, List[(Int, BigInt)]] ).apply(13).reverse ;

/* reduce / fold / ... */

// foldLeft
((n: Int) =>
{
    (0 to n).foldLeft
    {
      (List.empty[(Int, BigInt)], BigInt(0), BigInt(1))
    } { case ((r, y, z), x) => ((x, y) :: r, z, y + z) }._1.reverse ;
}) (13) ;

/* stream / lazylist / iterator / unfold / ... */

// Stream.iterate
((n: Int) =>
{
    Stream
        .iterate((0, BigInt(0), BigInt(1))){ case (x, y, z) => (x + 1, z, y + z) }
        .map{ case (x, y, z) => x -> y }
        .take(n+1).toList
}) (13) ;

// LazyList.iterate
((n: Int) =>
{
    LazyList
        .iterate((0, BigInt(0), BigInt(1))){ case (x, y, z) => (x + 1, z, y + z) }
        .map{ case (x, y, z) => x -> y }
        .take(n+1).toList
}) (13) ;
~~~

### *Tail recursion*

#### *[⚗] [Elixir]*

~~~ elixir
fib = 
fn n when not(n < 0) ->
    iter = 
    fn
        
        {^n, r, y, _}, _ -> [{n,y} | r] ;
        {x, r, y, z}, i ->
            
            {x + 1, [{x,y} | r], z, y + z} |> i.(i) ;
    end ;
    
    {0, [], 0, 1} |> iter.(iter) ;
end ;

fib.(0) |> Enum.reverse # [{0, 0}]
fib.(13) |> Enum.reverse # [ {0, 0}, {1, 1}, {2, 1}, {3, 2}, {4, 3}, {5, 5}, {6, 8}, {7, 13}, {8, 21}, {9, 34}, {10, 55}, {11, 89}, {12, 144}, {13, 233} ]
~~~

#### *[🥑] [Lua]*

~~~ lua
function fib
(n)
    if (n < 0)
    then error("dont less than zero") ;
    end ;
    
    function iter
    (x, y, z)
    return
        
        (n ~= x) and
        iter (x + 1, z, y + z) or y ;
    end ;
    
    return iter (0,0,1) ;
end ;

= fib (0) -- 0
= fib (13) -- 233
~~~

#### *[🥓] [Scala]*

~~~ scala
val fib
: PartialFunction[Long, List[(Long,BigInt)]] = 
{ case n if !(n < 0) =>
{
    def iter(x: Long, res: List[(Long,BigInt)], y: BigInt, z: BigInt): List[(Long,BigInt)] = 
        if (x < n) iter(x + 1,(x -> y) :: res, z, y + z) else (x -> y) :: res ;
    iter(0, List(), BigInt(0), BigInt(1))
} } ;

fib(13).reverse ;
// List((0,0), (1,1), (2,1), (3,2), (4,3), (5,5), (6,8), (7,13), (8,21), (9,34), (10,55), (11,89), (12,144), (13,233)): List[(Long, BigInt)]
~~~

~~~ scala
val fib
: PartialFunction[Long, List[(Long,BigInt)]] = 
{ case n if !(n < 0) =>
    
    def y [X, Y] (f: (X => Y) => (X => Y))
    : X => Y = 
    {
        case class W(f: W => (X => Y)) 
        { def apply(w: W): X => Y = f(w) } ;
        
        ((g: W => (X => Y)) => g(W(g)))
            .apply(w => f(w(w))(_)) ;
    } ;
    
    (y [((Long, List[(Long, BigInt)], BigInt, BigInt)), List[(Long, BigInt)]] 
    (
        f => 
        { case (x: Long, res: List[(Long, BigInt)], y: BigInt, z: BigInt) => 
            if (x < n) f((x + 1,(x -> y) :: res, z, y + z)) else (x -> y) :: res } 
    
    ) ) ( (0L, List(), BigInt(0), BigInt(1)) ) ;
}

fib(13).reverse ;
// List((0,0), (1,1), (2,1), (3,2), (4,3), (5,5), (6,8), (7,13), (8,21), (9,34), (10,55), (11,89), (12,144), (13,233)): List[(Long, BigInt)]
~~~


### *Reduce*

#### *[⚗] [Elixir]*

simple: 

~~~ elixir
0..13 |> Enum.reduce({[], 0, 1}, fn x, {r, y, z} -> {[{x,y} | r], z, y + z} end) |> (elem 0) |> Enum.reverse
# [ {0, 0}, {1, 1}, {2, 1}, {3, 2}, {4, 3}, {5, 5}, {6, 8}, {7, 13}, {8, 21}, {9, 34}, {10, 55}, {11, 89}, {12, 144}, {13, 233} ]
~~~

fun: 

~~~ elixir
fib = 
fn n when not(n < 0) ->
    0 .. n
    |> Enum.reduce({[], 0, 1}, fn x, {r, y, z} -> {[{x,y} | r], z, y + z} end)
    |> elem 0 ;
end ;

fib.(0) |> Enum.reverse # [{0, 0}]
fib.(13) |> Enum.reverse # [ {0, 0}, {1, 1}, {2, 1}, {3, 2}, {4, 3}, {5, 5}, {6, 8}, {7, 13}, {8, 21}, {9, 34}, {10, 55}, {11, 89}, {12, 144}, {13, 233} ]
~~~

#### *[🧊] [TypeScript]*

~~~ typescript

~~~

#### *[🥓] [Scala]*

simple: 

~~~ scala
(0 to 13).foldLeft
{
    (List.empty[(Int, BigInt)], BigInt(0), BigInt(1))
} { case ((r, y, z), x) => ((x, y) :: r, z, y + z) }._1.reverse
// List((0,0), (1,1), (2,1), (3,2), (4,3), (5,5), (6,8), (7,13), (8,21), (9,34), (10,55), (11,89), (12,144), (13,233)): List[(Int, BigInt)]

/* safe */
(0 to 0).toList // List(0): List[Int] 
(0 to -1).toList // List(): List[Int]
~~~


### *Stream / Lazy list / Iterator*

#### *[⚗] [Elixir]*

simple: 

~~~ elixir
Stream.unfold({0, 1}, fn {y, z} -> {y, {z, y + z} } end) |> Enum.take(13+1)
# [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233]

Stream.unfold({0, 0, 1}, fn {x, y, z} -> {{x,y}, {x + 1, z, y + z} } end) |> Enum.take(13+1)
# [ {0, 0}, {1, 1}, {2, 1}, {3, 2}, {4, 3}, {5, 5}, {6, 8}, {7, 13}, {8, 21}, {9, 34}, {10, 55}, {11, 89}, {12, 144}, {13, 233} ]
~~~

fun: 

~~~ elixir
fib = 
fn n when not(n < -1) ->
    Stream.unfold({0, 0, 1}, fn {x, y, z} -> {{x,y}, {x + 1, z, y + z} } end)
    |> Enum.take n+1 ;
end ;

fib.(0) # [{0, 0}]
fib.(13) # [ {0, 0}, {1, 1}, {2, 1}, {3, 2}, {4, 3}, {5, 5}, {6, 8}, {7, 13}, {8, 21}, {9, 34}, {10, 55}, {11, 89}, {12, 144}, {13, 233} ]

fib.(-1) # []
~~~

#### *[🦀] [Rust]*

...

#### *[🧊] [TypeScript]*

...

#### *[🥓] [Scala]*

simple: 

~~~ scala
/* stream (scala-2.12.x) */

val fibs: Stream[(Int, BigInt)] = Stream.iterate((0, BigInt(0), BigInt(1))){ case (x, y, z) => (x + 1, z, y + z) }.map{case (x, y, z) => x -> y} ;

/* lazylist (scala-2.13.x) */

val fibs: LazyList[(Int, BigInt)] = LazyList.iterate((0, BigInt(0), BigInt(1))){ case (x, y, z) => (x + 1, z, y + z) }.map{case (x, y, z) => x -> y} ;

/* use */

fibs.take(0+1).toList // List((0,0)): List[(Int, BigInt)]
fibs.take(13+1).toList // List((0,0), (1,1), (2,1), (3,2), (4,3), (5,5), (6,8), (7,13), (8,21), (9,34), (10,55), (11,89), (12,144), (13,233)): List[(Int, BigInt)]

/* safe */

fibs.take(-17).toList // List(): List[(Int, BigInt)]
fibs.take(0).toList // List(): List[(Int, BigInt)]
~~~

## Factorial

[fac.wiki:simple/wikipedia.org]: https://simple.wikipedia.org/wiki/Factorial
[fac.wiki:zh/wikipedia.org]: https://zh.wikipedia.org/wiki/%E9%98%B6%E4%B9%98
[fac.wiki:de/wikipedia.org]: https://de.wikipedia.org/wiki/Fakult%C3%A4t_(Mathematik)
[fac.wiki:en/wikipedia.org]: https://en.wikipedia.org/wiki/Factorial
[fac.wiki:fr/wikipedia.org]: https://fr.wikipedia.org/wiki/Factorielle

[🥗 wiki][fac.wiki:simple/wikipedia.org]


