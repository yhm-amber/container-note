
## ...

...

## Promise Result Getter

示例程序： [<kbd>./promising.tsx</kbd>](./promising.tsx)

### 定义如下

定义接口：

~~~ tsx
interface Promising<T>
{
    completed: boolean ;
    result?: T ;
    error?: any ;
} ;
~~~

创建接口实例的逻辑：

~~~ tsx
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
~~~

这是个工具，接收一个 `Promise` 实例并对完成状态的检查间隔，返回一个函数，该函数接收三个闭包用于分别指定等待、出错、成功时的逻辑：

~~~ tsx
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
~~~

### 使用示例

~~~ tsx
promisingGetter
(
    new Promise<string>
    ((resolve, reject) => 
    {
        setTimeout
        (() => 
        {
            resolve("hello world");
        }, 3000);
    }), 400
)(
    () => { console.log(`... wait, plz ...`) ; } ,
    (error: any) => { console.log(`[Error] occurred ! ${error}`) ; } ,
    (result: string | undefined) => { console.log(`[Result] gotten : ${result}`) ; }
) ;
~~~

被传入的是个简单的等待 3 秒的 `Promise` 实例，检查间隔为 400 毫秒。

指定：

- 每检查一次都会输出一个 `... wait, plz ...`
- 失败时输出 `[Error] occurred !` 和具体错误信息
- 成功时输出 `[Result] gotten :` 以及结果


