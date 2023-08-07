type Fn <T, R> = (p: T) => R ;

class Stream
<T> 
{
    
    constructor 
    (private readonly generatorFunction: () => Generator<T>) 
    {} ;
    
    
    static readonly iterate = 
    <T,> (initHead: T, f: Fn<T, T>)
    : Stream<T> => 
        
        new Stream
        ( function* ()
        : Generator<T> 
        {
            let head = initHead;
            while (true) 
            {
                yield head ;
                head = f(head);
            } ;
        } ) ;
    
    
    static readonly unfold = 
    <T, R> (initHead: T, f: Fn<T, { mapper: R; iter: T } | undefined>)
    : Stream<R> => 
        
        new Stream
        ( function* ()
        : Generator<R> 
        {
            let head = initHead;
            let next: { mapper: R, iter: T } | undefined = f(head);
            
            while (!(next === undefined)) 
            {
                yield next.mapper ;
                
                head = next.iter;
                next = f(head);
            } ;
        } ) ;
    
    
    readonly map = 
    <R,> (f: Fn<T, R>)
    : Stream<R> => 
        
        new Stream
        (( function* (this: Stream<T>)
        : Generator<R> 
        {
            const iterator = this.generatorFunction() ;
            while (true) 
            {
                const { value, done } = iterator.next() ;
                if (done) break;
                yield f(value) ;
            } ;
        } ).bind(this)) ;
    
    
    readonly filter = 
    (predicate: Fn<T, boolean>)
    : Stream<T> => 
        
        new Stream
        (( function* (this: Stream<T>)
        : Generator<T> 
        {
            const iterator = this.generatorFunction() ;
            while (true) 
            {
                const { value, done } = iterator.next() ;
                if (done) break;
                if (predicate(value)) yield value ;
            }
        } ).bind(this)) ;
    
    
    readonly scan = 
    (f: (acc: T, x: T) => T)
    : Stream<T> => 
                    
        new Stream
        (( function* (this: Stream<T>)
        : Generator<T> 
        {
            const iterator = this.generatorFunction() ;
            const { value, done } = iterator.next();
            
            if (done) return;
            let acc = value;
            yield acc;
            
            while (true) 
            {
                const { value, done } = iterator.next() ;
                if (done) break;
                acc = f(acc, value);
                yield acc;
            } ;
        } ).bind(this)) ;
    
    
    readonly fold = 
    (f: (acc: T, x: T) => T, initHead: T)
    : Stream<T> => 
            
        new Stream
        (( function* (this: Stream<T>)
        : Generator<T> 
        {
            
            yield initHead;            
            yield* this.scan(f);
            
        } ).bind(this)) ;
    
    
    readonly follow = 
    (head: T)
    : Stream<T> => 
        
        this.fold((_, x) => x, head) ;
    
    
    readonly window = 
    (size: number, step: number)
    : Stream<T[]> => 
        
        new Stream
        (( function* (this: Stream<T>)
        : Generator<T[]> 
        {
            const iterator = this.generatorFunction() ;
            let buffer: T[] = [];
            
            while (true) 
            {
                const { value, done } = iterator.next() ;
                
                if (done) break;
                buffer.push(value);
                
                if (buffer.length === size) 
                {
                    yield buffer;
                    buffer = buffer.slice(step);
                } ;
            } ;
            
        } ).bind(this));
    
    
    readonly zip = 
    <U,> (other: Stream<U>)
    : Stream<[T, U]> => 
        
        new Stream
        (( function* (this: Stream<T>)
        : Generator<[T, U]> 
        {
            const iterator1 = this.generatorFunction() ;
            const iterator2 = other.generatorFunction() ;
            
            while (true) 
            {
                const { value: value1, done: done1 } = iterator1.next() ;
                const { value: value2, done: done2 } = iterator2.next() ;
                
                if (done1 || done2) break;
                yield [value1, value2];
            }
        } ).bind(this));
    
    
    readonly takeUntil = 
    (predicate: Fn<T, boolean>)
    : T[] => 
    {
        const result: T[] = [] ;
        const iterator = this.generatorFunction() ;
        while (true) 
        {
            const { value, done } = iterator.next() ;
            result.push(value);
            if (done || predicate(value)) break;
        } ;
        return result ;
    } ;
    
    readonly take = 
    (n: number)
    : T[] => 
    {
        let count = 1;
        return this.takeUntil(() => !(count++ < n));
    } ;
    
    
    
    [Symbol.iterator] = () => this.generatorFunction() ;
} ;


console.log("--------")

const fibonacci = Stream.iterate([0, 1], ([a, b]) => [b, a + b]).map(([x]) => x) ;
console.log(fibonacci.take(16)); // [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610] 

const fibacc_scan = fibonacci.scan((acc, x) => acc + x) ;
console.log(fibacc_scan.take(10)); // [0, 1, 2, 4, 7, 12, 20, 33, 54, 88]

const fibacc = fibonacci.fold((acc, x) => acc + x, 0) ;
console.log(fibacc.take(11)); // [0, 0, 1, 2, 4, 7, 12, 20, 33, 54, 88]

const fibb = fibonacci.fold((acc, x) => x, 777) ;
console.log(fibb.take(10)); // [777, 0, 1, 1, 2, 3, 5, 8, 13, 21]

const fibh = fibonacci.follow(88).follow(99) ;
console.log(fibh.take(10)); // [99, 88, 0, 1, 1, 2, 3, 5, 8, 13]

const fibw = fibonacci.window(3,2) ;
console.log(fibw.take(5)); // [[0, 1, 1], [1, 2, 3], [3, 5, 8], [8, 13, 21], [21, 34, 55]]

const fibz = fibonacci.zip(fibacc_scan) ;
console.log(fibz.take(7)); // [[0, 0], [1, 1], [1, 2], [2, 4], [3, 7], [5, 12], [8, 20]]
