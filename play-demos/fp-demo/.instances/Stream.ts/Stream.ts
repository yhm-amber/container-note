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
    <T, R> (initHead: T, f: Fn<T, { bloom: R; iter: T } | undefined>)
    : Stream<R> => 
        
        new Stream
        ( function* ()
        : Generator<R> 
        {
            let head = initHead;
            let next: { bloom: R, iter: T } | undefined = f(head);
            
            while (!(next === undefined)) 
            {
                yield next.bloom ;
                
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
                const { value: head, done } = iterator.next() ;
                if (done) break;
                yield f(head) ;
            } ;
        } ).bind(this)) ;
    
    
    readonly filter = 
    (f: Fn<T, boolean>)
    : Stream<T> => 
        
        new Stream
        (( function* (this: Stream<T>)
        : Generator<T> 
        {
            const iterator = this.generatorFunction() ;
            while (true) 
            {
                const { value: head, done } = iterator.next() ;
                if (done) break;
                if (f(head)) yield head ;
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
            const { value: head, done } = iterator.next();
            
            if (done) return;
            let acc = head;
            yield acc;
            
            while (true) 
            {
                const { value: head, done } = iterator.next() ;
                if (done) break;
                acc = f(acc, head);
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
                const { value: head, done } = iterator.next() ;
                
                if (done) break;
                buffer.push(head);
                
                if (buffer.length === size) 
                {
                    yield buffer;
                    buffer = buffer.slice(step);
                } ;
            } ;
            
        } ).bind(this));
    
    
    readonly zip = 
    <U,> (stream: Stream<U>)
    : Stream<[T, U]> => 
        
        new Stream
        (( function* (this: Stream<T>)
        : Generator<[T, U]> 
        {
            const iteratorz = 
                [this.generatorFunction(), stream.generatorFunction()] ;
            
            while (true) 
            {
                const [{ value: head0, done: done0 }, { value: head1, done: done1 }] = 
                    [iteratorz[0].next(), iteratorz[1].next()] ;
                
                if (done0 || done1) break;
                yield [head0, head1];
            }
        } ).bind(this)) ;
    
    
    readonly tookUntil = 
    (when: Fn<T, boolean>)
    : [T[], Stream<T>] => 
    {
        const result: T[] = [] ;
        const iterator = this.generatorFunction() ;
        
        while (true) 
        {
            const { value: head, done } = iterator.next() ;
            result.push(head);
            if (done || when(head)) break;
        } ;
        
        return [result, new Stream(() => iterator)] ;
    } ;
    
    readonly took = 
    (n: number)
    : [T[], Stream<T>] => 
    {
        let count = 1;
        return this.tookUntil(() => !(count++ < n));
    } ;
    
    
    readonly takeUntil = 
    (when: Fn<T, boolean>)
    : T[] => 
        
        this.tookUntil(when)[0] ;
    
    readonly take = 
    (n: number)
    : T[] => 
        
        this.took(n)[0] ;
    
    
    readonly dropUntil = 
    (when: Fn<T, boolean>)
    : Stream<T> => 
        
        this.tookUntil(when)[1] ;
    
    readonly drop = 
    (n: number)
    : Stream<T> => 
        
        this.took(n)[1] ;
    
    
    
    [Symbol.iterator] = () => this.generatorFunction() ;
} ;


console.log("--------")

const fibonacci = Stream.iterate([0, 1], ([a, b]) => [b, a + b]).map(([x]) => x) ;
console.log(fibonacci.take(16)); // [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610]
console.log(fibonacci.drop(10).take(6)); // [55, 89, 144, 233, 377, 610]

const fibacc_scan = fibonacci.scan((acc, x) => acc + x) ;
console.log(fibacc_scan.take(10)); // [0, 1, 2, 4, 7, 12, 20, 33, 54, 88]

const fibacc = fibonacci.fold((acc, x) => acc + x, 0) ;
console.log(fibacc.take(11)); // [0, 0, 1, 2, 4, 7, 12, 20, 33, 54, 88]

const fibb = fibonacci.fold((acc, x) => x, 777) ;
console.log(fibb.take(10)); // [777, 0, 1, 1, 2, 3, 5, 8, 13, 21]

const fibh = fibonacci.follow(88).follow(99) ;
console.log(fibh.take(10)); // [99, 88, 0, 1, 1, 2, 3, 5, 8, 13]
console.log(fibh.drop(4).take(10)); // [1, 2, 3, 5, 8, 13, 21, 34, 55, 89]

const fibw = fibonacci.window(3,2) ;
console.log(fibw.take(5)); // [[0, 1, 1], [1, 2, 3], [3, 5, 8], [8, 13, 21], [21, 34, 55]]
console.log(fibw.drop(2).take(3)); // [[3, 5, 8], [8, 13, 21], [21, 34, 55]]

const fibz = fibonacci.zip(fibacc_scan) ;
console.log(fibz.take(7)); // [[0, 0], [1, 1], [1, 2], [2, 4], [3, 7], [5, 12], [8, 20]]
console.log(fibz.drop(5).take(2)); // [[5, 12], [8, 20]]


const naturals = Stream.iterate(2, x => x + 1) ;
console.log(naturals.take(8)); // [2, 3, 4, 5, 6, 7, 8, 9]
const primes = Stream.unfold(naturals, naturals => 
    {
        const [[h], t] = naturals.took(1) ;
        return { bloom: h, iter: t.filter(x => x % h != 0) }
    } ) ;
console.log(primes.take(20)); // [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71]

// better
const primenums = Stream.unfold
(
    Stream.iterate(2, x => x + 1) , 
    naturals => 
    {
        const [[h], t] = naturals.took(1) ;
        return { bloom: h, iter: t.filter(x => x < h * h || x % h != 0) } ;
    } , 
) ;
console.log(primenums.take(20)); // [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71]

// fibo
const primesfibo = Stream.unfold
(
    Stream.iterate([0, 1], ([a, b]) => [b, a + b]).map(([x]) => x).dropUntil(x => !(x < 2)) ,
    fibonacci => 
    {
        const [[h], t] = fibonacci.took(1) ;
        return { bloom: h, iter: t.filter(x => x < h * h || x % h != 0) } ;
    } , 
) ;

console.log(primesfibo.take(12)); // [3, 5, 8, 13, 34, 89, 233, 1597, 4181, 28657, 514229, 1346269]
