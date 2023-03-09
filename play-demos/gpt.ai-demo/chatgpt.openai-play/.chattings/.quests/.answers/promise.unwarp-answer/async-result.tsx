interface AsyncResult<T>
{
  is_complete: boolean;
  result?: T;
  error?: any;
} ;

const run_async = 
    <T,> (promising: Promise<T> | PromiseLike<T>)
    : AsyncResult<T> =>
    {
        const result: AsyncResult<T> = {is_complete: false} ;
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

const async_result
: AsyncResult<string> = 
    run_async
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
        if (async_result.is_complete)
        {
            clearInterval(interval_id);
            
            if (async_result.error)
            { console.log(`Error occurred: ${async_result.error}`); } else
            { console.log(`Result is: ${async_result.result}`); }
        } else
        {
            console.log(`... wait, plz ...`)
        }
    }, 400) ;
