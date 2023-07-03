# promising.ts

~~~ md
👸🏻 do something while promising
~~~

（实验性项目）在 Promise 期间插入轮询逻辑

## usage

~~~ ts
import { promisingGetter } from "./promising.ts" ;

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


