/* CPS type */

type Tailcall <T> = { head: T, tail: () => Tailcall<T>, done: boolean } ;

const Tailcall = 
(done: boolean) => 
<T,> (head: T) => 
(tail: () => Tailcall<T>)
: Tailcall<T> => 
    
    ({ head: head, tail: tail, done: done }) as Tailcall <T> ;

Tailcall.done = 
<T,> (head: T)
: Tailcall<T> => 
    
    Tailcall (true) (head) 
        (() => { throw new Error("not implemented"); }) ;

Tailcall.call = 
<T,> (tail: () => Tailcall<T>)
: Tailcall<T> => 
    
    Tailcall (false) (null as any) (tail) ;

Tailcall.RUN = 
<T,> (self: Tailcall<T>)
: T => 
{
    let RUNNING = self;
    while (!RUNNING.done) 
    { RUNNING = RUNNING.tail (); }
    return RUNNING.head ;
} ;




const rem = 
(n: number, r: number)
: Tailcall<number> =>
    
    (n < r) ? Tailcall.done(n) 
    : Tailcall.call(() => rem(n-r, r)) ;


const pipeline = <T,> (x: T) => <R,> (f: (x: T) => R) => pipeline((f) (x)) ;

pipeline (rem(10000002,2))
    (Tailcall.RUN)
    (console.log); // 0, won't stack overflow
