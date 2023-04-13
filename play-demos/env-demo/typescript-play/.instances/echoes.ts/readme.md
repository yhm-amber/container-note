*“回声”*

----

这是一个高度抽象的依赖关联器，为结构体中的各个属性之间依赖关系的建立提供了一种途径。

### 定义

~~~ tsx
namespace Echoes
{
    export 
    const echoes =
    <T = {[key: string]: any},> (waves: {[key: string]: (env: T) => any})
    : T =>
        Object.entries(waves).reduce
        (
            (envs, [fn, f]) => ({... envs, [fn]: f(envs)}) ,
            {} as T
        ) ;

    export 
    const call = 
    <T extends Record<K, (...args: any) => any>, K extends keyof T>
    (obj: T, key: K): { [P in K]: ReturnType<T[P]>; }[K] =>
        echoes<{[P in K]: ReturnType<T[P]>}>(obj)[key] ;
    
} ;
~~~

### 使用

简单示例：

~~~ tsx
const ffs =
{
    f1: (env: { [key: string]: Function }) => 
        
        (n: number): number => 1 + n ,
        
    f2: (env: { [key: string]: Function }) => 
        
        (x: number): number => env.f1(x * 2) ,
        
} ;

console.log( Echoes.echoes(ffs).f2(3) ); // 结果为 7
~~~

其中的 `(env: { [key: string]: Function }) =>` 是必要的部分。没有这个变量，就不能描述属性之间的依赖关系。

复杂示例：

~~~ tsx
const xx =
{
    x0: (env: { [key: string]: any }) => 
        
        1 ,
    
    f: (env: { [key: string]: any }) => 
        
        (s: string)
        : number => s.length ,
    
    f2: (env: { [key: string]: any }) => 
        
        (s: string, n: number)
        : Promise<number> => Promise.resolve(env.f(s) + n - env.x0) ,
} ;

Echoes.echoes<{f2: ReturnType<typeof xx.f2>}>(xx).f2('a',3).then(r => console.log(r)); // 结果为 3
Echoes.echoes(xx).f2('a',3).then( (r: number) => console.log(r) ); // 结果为 3

Echoes.call(xx,'f2')('a',3).then(r => console.log(r)); // 结果为 3
~~~

其中的 `Echoes.call` 是对 `Echoes.echoes` 指定泛型调用的封装。

在不指定泛型的情况下，（目前的）类型推导无法确定 `Promise` 的泛型，因而 `r` 必须写作 `(r: number)` 。

*本项目的建立与错误排查中使用了基于 GPT-4 AI 的 Bing Chat 。*
