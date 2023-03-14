interface PromisingGetter<T>
{
    is_complete: boolean;
    result?: T;
    error?: any;
} ;

const getting_promise = 
    <T,> (promising: Promise<T> | PromiseLike<T>)
    : PromisingGetter<T> =>
    {
        const result: PromisingGetter<T> = {is_complete: false} ;
        promising
            .then
            ( res => 
            {
                result.result = res ;
                result.is_complete = true ; }
            , (err: any) => 
            {
                result.error = err ;
                result.is_complete = true ; }
            )
        
        return result ;
    } ;

const promise_getter
: PromisingGetter<string> = 
    getting_promise
    (
        new Promise<string>
        ((resolve, reject) => 
        {
            setTimeout
            (() => 
            {
                resolve("hello world");
            }, 3000);
        })
    ) ;

const interval_id
: number = 
    setInterval(() => 
    {
        if (promise_getter.is_complete)
        {
            clearInterval(interval_id);
            
            if (promise_getter.error)
            { console.log(`Error occurred: ${promise_getter.error}`); } else
            { console.log(`Result is: ${promise_getter.result}`); }
        } else
        {
            console.log(`... wait, plz ...`)
        }
    }, 400) ;

//
