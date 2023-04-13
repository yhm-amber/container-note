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

// const ffs =
// {
//     f1: (env: { [key: string]: Function }) => 
//         
//         (n: number): number => 1 + n ,
//     
//     f2: (env: { [key: string]: Function }) => 
//         
//         (x: number): number => env.f1(x * 2) ,
//     
// } ;
// 
// console.log( Echoes.echoes(ffs).f2(3) ); // 7
// 
// const xx =
// {
//     x0: (env: { [key: string]: any }) => 
//         
//         1 ,
//     
//     f: (env: { [key: string]: any }) => 
//         
//         (s: string)
//         : number => s.length ,
//     
//     f2: (env: { [key: string]: any }) => 
//         
//         (s: string, n: number)
//         : Promise<number> => Promise.resolve(env.f(s) + n - env.x0) ,
// } ;
// 
// Echoes.echoes<{f2: ReturnType<typeof xx.f2>}>(xx).f2('a',3).then(r => console.log(r)); // 3
// Echoes.echoes(xx).f2('a',3).then( (r: number) => console.log(r) ); // 3
// 
// Echoes.call(xx,'f2')('a',3).then(r => console.log(r)); // 3
// 
