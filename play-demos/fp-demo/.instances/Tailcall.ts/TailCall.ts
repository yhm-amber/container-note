//// classic type ////

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
        { tailcall = tailcall.nextCall() ; } ;
        return tailcall.result ;
    } ;
} ;

const rem = 
(n: number, r: number)
: TailCall<number> =>
    
    (n < r) ? TailCall.done(n) 
    : TailCall.call(() => rem(n-r, r)) ;

console.log(rem(10000001,2).invoke()); // wait, ans: 1
