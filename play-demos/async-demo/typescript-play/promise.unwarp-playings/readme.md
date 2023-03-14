
## ...

...

## Promise Result Getter

示例程序： [<kbd>./promising-getter.tsx</kbd>](./promising-getter.tsx)

### 定义如下

为解包结果自定义接口：

~~~ tsx
interface PromisingGetter<T>
{
    is_complete: boolean;
    result?: T;
    error?: any;
} ;
~~~

完成解包的类型转换逻辑：

~~~ tsx
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
~~~

### 使用示例

为一个 `Promise` 实例创建它的 `Getter` 接口：

~~~ tsx
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
~~~

轮询，从结果接口中取得结果：

~~~ tsx
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
~~~

当这个 `promise_getter` 的 `is_complete` 属性为 `true` 时，
就要么能够从它的 `result` 属性取得异步流程整个成功后的最终返回、
要么能够从它的 `error` 属性取得一个该次异步流程给出的错误（可能是任何类型），
如果成功，解包即完成。

