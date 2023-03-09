
### 定义如下

为解包结果自定义接口：

~~~ tsx
interface AsyncResult<T>
{
  is_complete: boolean;
  result?: T;
  error?: any;
} ;
~~~

完成解包的类型转换逻辑：

~~~ tsx
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
~~~

### 使用示例

取得一个简单的异步流程的结果接口：

~~~ tsx
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
~~~

从结果接口中取得结果，解包就完成了：

~~~ tsx
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
~~~

即当结果 `async_result1` 的 `is_complete` 属性为 `true` 时，
就能够从 `result` 属性取得异步流程整个成功后的最终返回，
要么就能够从 `error` 属性取得一个该次异步流程给出的错误（可能是任何类型）。

