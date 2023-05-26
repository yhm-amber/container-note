
# How Iter Transes

TCO and Streams ...

## Transes

### `tailcall.ts`

转换 Loop 为描述迭代的接口。

*idea from :*  
- *[Tail Recursion in JAVA 8 - Knoldus Blogs](https://blog.knoldus.com/tail-recursion-in-java-8/)*

#### `class TailCall`

~~~ ts
class TailCall
<T> 
{
    constructor
    (
        public readonly isComplete: boolean ,
        public readonly result: T ,
        public readonly nextCall: () => TailCall<T> ,
    ) {} ;
    
    static done
    <T>(value: T)
    : TailCall<T> 
    {
        return new TailCall(true, value, () => { throw new Error("not implemented"); }) ;
    } ;
    
    static call
    <T>(nextCall: () => TailCall<T>)
    : TailCall<T> 
    {
        return new TailCall(false, null as any, nextCall);
    } ;
    
    invoke(): T 
    {
        let tailcall: TailCall<T> = this ;
        while (!tailcall.isComplete) 
        { tailcall = tailcall.nextCall(); } ;
        return tailcall.result ;
    } ;
} ;
~~~

test: 

~~~ ts
const rb = 
(n: number, r: number)
: TailCall<number> =>
    
    (n < r) ? TailCall.done(n) 
    : TailCall.call(() => rb(n-r, r)) ;

console.log(rb(10000001,2).invoke());

// wait, ans: 1
// won't err: Maximum call stack size exceeded
~~~

#### `interface Tailcall`

~~~ ts
interface Tailcall
<T> 
{
    (): Tailcall<T> ;
    completed?: boolean ;
    result?: T ;
} ;

const tailcall = 
{
    call: 
        
        <T,>(nextcall: Tailcall<T>)
        : Tailcall<T> => nextcall ,
    
    done: 
        
        <T,>(value: T)
        : Tailcall<T> =>
            
            Object.assign
            (
                () => { throw new Error(":tailcall: not implemented"); } , 
                { completed: true, result: value }
            ) ,
    
    invoke: 
        
        <T,>(tailcall: Tailcall<T>)
        : T =>
        {
            let result = tailcall;
            while (!result.completed) 
            { result = result(); } ;
            return result.result! ;
        } ,
    
} ;
~~~

test: 

~~~ ts
const rb = 
(n: number, r: number)
: Tailcall<number> =>
    
    (n < r) ? tailcall.done(n) 
    : tailcall.call(() => rb(n-r, r)) ;

console.log(tailcall.invoke(rb(10000001,2)));

// wait, ans: 1
// won't err: Maximum call stack size exceeded
~~~


### `stream.ts`

转换生成器定义接口为描述迭代的接口。

*ref by :*  
- *[Stream.unfold/2. The Stream module in Elixir is full of… | by Dunya Kirkali | Medium](https://haagwee.medium.com/stream-unfold-2-5c22e5cf1a3d)*
- *[Scala Unfold | Genuine Blog](https://blog.genuine.com/2020/07/scala-unfold/)*

#### `class Stream`

~~~ ts
class Stream
<T> 
{
    
    generatorFunction: () => Generator<T> ;
    
    constructor(generatorFunction: () => Generator<T>)
    { this.generatorFunction = generatorFunction ; } ;
    
    static iterate
    <T>(initialValue: T, f: (value: T) => T)
    : Stream<T> 
    {
        return new Stream
        ( function* ()
        : Generator<T> 
        {
            let value = initialValue ;
            while (true) 
            {
                yield value ;
                value = f(value) ;
            } ;
        } ) ;
    } ;
    
    static unfold
    <T, R>(initialValue: T, f: (value: T) => { mapper: R; iter: T } | undefined)
    : Stream<R> 
    {
        return new Stream
        ( function* ()
        : Generator<R> 
        {
            let value = initialValue ;
            while (true) 
            {
                const next = f(value) ;
                if (next === undefined) break ;
                yield next.mapper ;
                value = next.iter ;
            } ;
        } ) ;
    } ;
    
    map
    <R>(f: (value: T) => R)
    : Stream<R> 
    {
        return new Stream
        (( function* (this: Stream<T>)
        : Generator<R> 
        {
            const iterator = this.generatorFunction() ;
            while (true) 
            {
                const { value, done } = iterator.next() ;
                if (done) break ;
                yield f(value) ;
            } ;
        } ).bind(this)) ;
    } ;
    
    filter
    (predicate: (value: T) => boolean)
    : Stream<T> 
    {
        return new Stream
        (( function* (this: Stream<T>)
        : Generator<T> 
        {
            const iterator = this.generatorFunction() ;
            while (true) 
            {
                const { value, done } = iterator.next() ;
                if (done) break ;
                if (predicate(value)) yield value ;
            }
        } ).bind(this)) ;
    } ;
    
    takeUntil
    (predicate: (value: T) => boolean)
    : T[] 
    {
        const result: T[] = [] ;
        const iterator = this.generatorFunction() ;
        while (true) 
        {
            const { value, done } = iterator.next() ;
            result.push(value) ;
            if (done || predicate(value)) break ;
        } ;
        return result ;
    }
    
    take
    (n: number)
    : T[] 
    {
        let count = 1 ;
        return this.takeUntil(() => !(count++ < n)) ;
    } ;
} ;
~~~

use: 

~~~ ts
/* simple */

const s = Stream.unfold(0, x => x < 10 ? { mapper: x, iter: x + 1 } : undefined ) ;
console.log(s.take(3)); // [0, 1, 2]
~~~

~~~ ts
/* Fibonacci */

// unfold
const fibs = Stream.unfold
(
    { x: 0, y: 0, z: 1 },
    ({ x, y, z }) => ({ mapper: { x, y }, iter: { x: x + 1, y: z, z: y + z } })
) ;

// or iterate
const fibs = 
Stream
    .iterate({x: 0, y: 0,z: 1}, ({ x, y, z }) => ({ x: x + 1, y: z, z: y + z }))
    .map(({ x, y, z }) => ({ x, y }))
    .filter(({ x, y }) => x % 2 === 1) ;

// take
console.log(fibs.take(3));
console.log(fibs.take(14));
~~~

#### `interface Streamming`

...

## Tailcall by Stream

替换 Loop 为 Stream ，转换 Stream 接口为 TailCall 接口。

### `tailcall.ts` by `class Stream`

*相应的测试代码同上*

#### `class TailCall`

~~~ ts
class TailCall
<T> 
{
    constructor
    (
        public readonly isComplete: boolean ,
        public readonly result: T ,
        public readonly nextCall: () => TailCall<T> ,
    ) {} ;
    
    static done
    <T>(value: T)
    : TailCall<T> 
    {
        return new TailCall(true, value, () => { throw new Error("not implemented"); }) ;
    } ;
    
    static call
    <T>(nextCall: () => TailCall<T>)
    : TailCall<T> 
    {
        return new TailCall(false, null as any, nextCall);
    } ;
    
    invoke
    (): T 
    {
        return Stream
            .iterate(this as TailCall<T>, f => (f.nextCall()))
            .takeUntil(f => f.isComplete)
            .reduce((_, f) => f.result, this.result) ;
    } ;
} ;
~~~

#### `interface Tailcall`

~~~ ts
interface Tailcall
<T> 
{
    (): Tailcall<T> ;
    completed?: boolean ;
    result?: T ;
} ;

const tailcall = 
{
    call: 
        
        <T,>(nextcall: Tailcall<T>)
        : Tailcall<T> => nextcall ,
    
    done: 
        
        <T,>(value: T)
        : Tailcall<T> =>
            
            Object.assign
            (
                () => { throw new Error(":tailcall: not implemented"); } , 
                { completed: true, result: value }
            ) ,
    
    invoke: 
        
        <T,>(tailcall: Tailcall<T>)
        : T =>
            
            Stream.iterate(tailcall, f => f() ) // or, `f => f()` could be `(f) => (f.completed ? f : f())` also.
                .takeUntil(f => f.completed!)
                .reduce((_, f) => f.result!, tailcall.result!) ,
    
} ;
~~~

