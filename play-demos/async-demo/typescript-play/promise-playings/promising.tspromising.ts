export 
interface Promising<T>
{
    completed: boolean ;
    result?: T ;
    error?: any ;
} ;

export 
const Promising = 
<T,> (promise: Promise<T> | PromiseLike<T>)
: Promising<T> =>
{
    const promising: Promising<T> = {completed: false} ;
    promise
        .then
        ( res => 
        {
            promising.result = res ;
            promising.completed = true ; }
        , (err: any) => 
        {
            promising.error = err ;
            promising.completed = true ; }
        )
    
    return promising ;
} ;

export 
const promisingGetter = 
<T,> (promise: Promise<T> | PromiseLike<T>, interval: number) => 
    (watting: () => any ,occurred: (error: any) => any, gotten: (result: T | undefined) => any)
    : Promise<T> | PromiseLike<T> =>
    {
        const promising: Promising<T> = Promising(promise) ;

        const intervalID
        : number = 
            setInterval(() => 
            {
                if (promising.completed)
                {
                    clearInterval(intervalID);
                    
                    if (promising.error)
                    { occurred(promising.error) ; } else
                    { gotten(promising.result) ; }
                } else
                { 
                    watting() ;
                }
            }, interval) ;
        
        return promise ;
    } ;


// usage: 
//
// promisingGetter
// (
//     new Promise<string>
//     ((resolve, reject) => 
//     {
//         setTimeout
//         (() => 
//         {
//             resolve("hello world");
//         }, 3000);
//     }), 400
// )(
//     () => { console.log(`... wait, plz ...`) ; } ,
//     (error: any) => { console.log(`[Error] occurred ! ${error}`) ; } ,
//     (result: string | undefined) => { console.log(`[Result] gotten : ${result}`) ; }
// ) ;
