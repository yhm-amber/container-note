
# TypeScript 101

### 101

#### 1/20

> 在 Functional programming 里会有函数 apply ，它接收一个函数和它的参数列表、然后返回该函数作用该参数列表后的结果。在 TS 里有这样的东西吗？我可以怎样去实现一个？

* Searching for: **TS apply 函数**
* Searching for: **TS apply 函数实现**
* Generating answers for you…

在 TypeScript 中，你可以使用 `apply()` 方法来调用一个具有给定 `this` 值的函数，以及以一个数组（或类数组对象）的形式提供的参数。它的第一个参数是你需要指向的 `this` 目标，后面的参数是你需要传递的数组参数，无参数可以不写。¹⁶

例如，你可以这样实现一个 `apply` 函数：
```typescript
function applyFunction(func: Function, args: any[]) {
    return func.apply(null, args);
}
```

Source: Conversation with Bing, 2023/5/29
(1) JS中bind、call和apply的作用以及在TS装饰器中的用法 - 鹏多多 - 博客园. https://www.cnblogs.com/-pdd/p/15587105.html.
(2) Function.prototype.apply() - JavaScript | MDN - MDN Web Docs. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/apply.
(3) 详解Typescript里的This - 知乎 - 知乎专栏. https://zhuanlan.zhihu.com/p/104565681.
(4) Pandas数据处理(五) — apply() 方法介绍！ - 知乎 - 知乎专栏. https://zhuanlan.zhihu.com/p/340770847.
(5) Function.prototype.apply() - JavaScript | MDN - MDN Web Docs. https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Function/apply.
(6) Apply CSS class dynamically on TS file - Stack Overflow. https://stackoverflow.com/questions/46849230/apply-css-class-dynamically-on-ts-file.

#### 2/20

> 以后用英文搜索并用中文回我。
> 
> `null` 的位置是什么作用？如果写别的会怎样？
> 

* Searching for: **apply method null this value**
* Generating answers for you…

`null` 的位置是用来指定 `this` 值的。当你使用 `apply()` 方法时，你可以传入一个特定的 `this` 值，或者传入 `null` 或 `undefined`。如果你传入 `null` 或 `undefined`，并且函数不是在严格模式下运行，则它们会被替换为全局对象²。

如果你在 `apply()` 方法中传入一个非 `null` 的值作为第一个参数，那么函数内部的 `this` 值将会被绑定为该值。这样，你就可以在调用现有函数时为其分配任意的 `this` 值，而无需先将该函数作为对象的属性进行绑定²。

Source: Conversation with Bing, 2023/5/29
(1) Function.prototype.apply() - JavaScript | MDN - MDN Web Docs. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/apply.
(2) Why would you pass 'null' to 'apply' or 'call'? - Stack Overflow. https://stackoverflow.com/questions/33640079/why-would-you-pass-null-to-apply-or-call.
(3) How can I make a method take a null value? - Stack Overflow. https://stackoverflow.com/questions/32063904/how-can-i-make-a-method-take-a-null-value.

#### 3/20

> 对于这样的函数签名： `f <A, B, C>(x: A, y: B): C` ，其第一个参数是 `x` 第二个是 `y` 。那对于这个签名 `f <T, A, B, C>(this: T, x: A, y: B): C` 呢？ Still ？

对于函数签名 `f <T, A, B, C>(this: T, x: A, y: B): C`，第一个参数仍然是 `x`，第二个参数是 `y`。`this: T` 不是一个参数，而是一个类型注释，它指定了函数内部 `this` 的类型。这样，在调用该函数时，TypeScript 就可以检查 `this` 的类型是否符合要求。

#### 4/20

> 好吧。那 `f <T, A, B, C>(this: T, x: A, y: B): C` 是否和 `f <T, A, B, C>(x: A, y: B, this: T): C` 一样？或者和 `f <T, A, B, C>(x: A, this: T, y: B): C` 也一样？

不，`f <T, A, B, C>(this: T, x: A, y: B): C` 和 `f <T, A, B, C>(x: A, y: B, this: T): C` 或 `f <T, A, B, C>(x: A, this: T, y: B): C` 不一样。`this: T` 必须放在参数列表的第一个位置，用来指定函数内部 `this` 的类型。如果你将其放在其他位置，TypeScript 将会把它当作一个普通的参数，并报错。

#### 5/20

> 我也可以像这样去实现 `apply` ：
> 
> ~~~ ts
> const apply = 
>     (f: Function, args: any[])
>     : any => 
>         
>         f(...args) ;
> ~~~
> 

是的，你可以使用展开语法（spread syntax）来实现一个 `apply` 函数，就像你所展示的那样。这种方法可以将一个数组展开为函数的参数列表。例如，如果你有一个函数 `f(x, y)`，那么调用 `f(...[1, 2])` 等同于调用 `f(1, 2)`。

#### 6/20

> `call` 和 `bind` 又是什么作用呢？

* Searching for: **call and bind in TypeScript**
* Generating answers for you…

`call` 和 `apply` 都可以用来调用一个函数，并指定函数内部 `this` 的值。它们的区别在于传递参数的方式不同：`call` 方法接受一个参数列表，而 `apply` 方法接受一个参数数组。

例如，如果你有一个函数 `f(x, y)`，那么调用 `f.call(obj, 1, 2)` 等同于调用 `f.apply(obj, [1, 2])`。在这两种情况下，函数内部的 `this` 值都会被绑定为 `obj`。

`bind` 方法与 `call` 和 `apply` 不同，它不会立即调用函数，而是返回一个新的函数。当你调用这个新函数时，它的 `this` 值会被绑定为 `bind` 方法的第一个参数。此外，你还可以在 `bind` 方法中传递一些参数，这些参数会被预先绑定到新函数中。

例如，如果你有一个函数 `f(x, y)`，那么调用 `f.bind(obj, 1)` 会返回一个新函数。当你调用这个新函数时，它相当于调用了 `f.call(obj, 1)`。¹⁴⁵

Source: Conversation with Bing, 2023/5/29
(1) Function.prototype.bind() - JavaScript | MDN - MDN Web Docs. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/bind.
(2) call (), apply () and bind () in JavaScript explained. https://dev.to/sachinkoli/call-apply-and-bind-in-javascript-explained-4kk2.
(3) How to use the apply(?), call(?), and bind( ) methods in JavaScript. https://www.freecodecamp.org/news/how-to-use-the-apply-call-and-bind-methods-in-javascript-80a8e6096a90/.
(4) javascript - bind function and this in typescript - Stack Overflow. https://stackoverflow.com/questions/34499583/bind-function-and-this-in-typescript.
(5) TypeScript: TSConfig Option: strictBindCallApply. https://www.typescriptlang.org/tsconfig/strictBindCallApply.html.

#### 7/20

> `bind` 的作用是部分施用吗？像这样：
> 
> ~~~ ts
> const ff = f.bind(obj, 1) ;
> ff(2)
> ~~~
> 
> 相当于调用 `f.call(obj, 1, 2)` 吗？
> 

是的，你说得对。`bind` 方法可以用来实现部分应用（partial application）。当你调用 `f.bind(obj, 1)` 时，它会返回一个新函数 `ff`。当你调用 `ff(2)` 时，它相当于调用了 `f.call(obj, 1, 2)`。也就是说，`bind` 方法可以将一些参数预先绑定到新函数中。

#### 8/20

> 但只能从前开始绑定对吧？这就有点像柯里化了。

是的，你说得对。`bind` 方法只能从前往后绑定参数。也就是说，你只能预先绑定函数的前几个参数，而不能预先绑定函数的后几个参数。

这种部分应用（partial application）的方式确实与柯里化（currying）有些类似。柯里化是一种将多参数函数转换为一系列单参数函数的技术。例如，如果你有一个接受两个参数的函数 `f(x, y)`，那么你可以将其柯里化为 `f(x)(y)`。这样，你就可以先传递一个参数 `x`，然后再传递一个参数 `y`。

#### 9/20

> 那 `f.call(null, 1, 2)` `f.apply(null, [1, 2])` 是不是相当于 `f(1, 2)` ？

是的，你说得对。如果你调用 `f.call(null, 1, 2)` 或 `f.apply(null, [1, 2])`，那么它们都相当于调用 `f(1, 2)`。在这两种情况下，函数内部的 `this` 值都会被绑定为 `null`。

不过，需要注意的是，如果函数不是在严格模式下运行，则 `null` 和 `undefined` 会被替换为全局对象。也就是说，如果函数不是在严格模式下运行，那么调用 `f.call(null, 1, 2)` 或 `f.apply(null, [1, 2])` 相当于调用 `f.call(globalThis, 1, 2)` 或 `f.apply(globalThis, [1, 2])`。

#### 10/20

> 什么是全局对象？

* Searching for: **global object**
* Generating answers for you…

全局对象是一个在全局作用域中始终存在的对象。在 JavaScript 中，总是有一个全局对象被定义。在浏览器中，当脚本使用 `var` 关键字创建全局变量时，它们会被创建为全局对象的成员（在 Node.js 中则不是这样）。

全局对象的接口取决于脚本运行的执行上下文。例如，在浏览器中，任何脚本没有特意作为后台任务启动的代码都有一个 `Window` 作为其全局对象。这是 Web 上绝大多数 JavaScript 代码。在 `Worker` 中运行的代码具有一个 `WorkerGlobalScope` 对象作为其全局对象。在 Node.js 中运行的脚本具有一个名为 `global` 的对象作为其全局对象。

`globalThis` 全局属性允许你在任何环境中访问全局对象¹²。

Source: Conversation with Bing, 2023/5/29
(1) Global object - The Modern JavaScript Tutorial. https://javascript.info/global-object.
(2) Global object - MDN Web Docs Glossary: Definitions of Web-related terms .... https://developer.mozilla.org/en-US/docs/Glossary/Global_object.

#### 11/20

> `document` 算全局对象吗？

`document` 不是全局对象，但它是全局对象的一个属性。在浏览器中，全局对象是 `window`，而 `document` 是 `window` 的一个属性。因此，你可以直接访问 `document` 对象，就像访问全局变量一样。

#### 12/20

> 或者 `globalThis.windows` ？在浏览器或者 NodeJS 或者 Deno ？

`globalThis` 是一个全局属性，它提供了一种标准化的方式来访问全局对象，无论你的代码运行在什么环境中。在浏览器中，`globalThis` 等同于 `window`；在 Node.js 中，`globalThis` 等同于 `global`；在 Deno 中，`globalThis` 等同于 `self`。

因此，在浏览器中，你可以使用 `globalThis.window` 来访问 `window` 对象。但是，在 Node.js 或 Deno 中，`globalThis.window` 是未定义的，因为这些环境中没有 `window` 对象。

#### 13/20

> 哦抱歉，说错了，我是想问 `globalThis.document` 。以及，除了 `null` 和 `undefined` 以外还有什么类似表示空的关键字？ `null` 和 `undefined` 又有啥区别？

* Searching for: **null and undefined**
* Generating answers for you…

在浏览器中，`globalThis.document` 等同于 `window.document`，可以用来访问 `document` 对象。但是，在 Node.js 或 Deno 中，`globalThis.document` 是未定义的，因为这些环境中没有 `document` 对象。

除了 `null` 和 `undefined` 以外，JavaScript 中没有其他类似表示空的关键字。`null` 和 `undefined` 都表示“没有值”，但它们的用途略有不同。`undefined` 表示变量已经声明，但尚未赋值；而 `null` 表示变量已经声明，并且已经显式地赋值为空。

简单来说，`undefined` 表示“缺少值”，而 `null` 表示“没有值”。¹²³

Source: Conversation with Bing, 2023/5/29
(1) What is the difference between null and undefined in JavaScript?. https://stackoverflow.com/questions/5076944/what-is-the-difference-between-null-and-undefined-in-javascript.
(2) JavaScript checking for null vs. undefined and difference between .... https://stackoverflow.com/questions/5101948/javascript-checking-for-null-vs-undefined-and-difference-between-and.
(3) Undefined Vs Null in JavaScript - GeeksforGeeks. https://www.geeksforgeeks.org/undefined-vs-null-in-javascript/.
(4) Difference between null and undefined in JavaScript - TutorialsTeacher.com. https://www.tutorialsteacher.com/javascript/javascript-null-and-undefined.

#### 14/20

> 那变量未声明用啥表示？

如果你尝试访问一个未声明的变量，JavaScript 会抛出一个 `ReferenceError` 异常。例如，如果你尝试执行 `console.log(x)`，但变量 `x` 没有被声明，那么你会得到一个错误信息，类似于 `ReferenceError: x is not defined`。

因此，未声明的变量没有特定的值来表示它。相反，当你尝试访问它时，程序会抛出一个错误。

#### 15/20

> 好吧。如何检测一个值不是 null 或 undefined ？通过 `x.isNotNull` 或 `x.isNotUndefined` 或者类似的方法吗？

JavaScript 中没有 `isNotNull` 或 `isNotUndefined` 这样的方法来检测一个值是否不是 `null` 或 `undefined`。但是，你可以使用严格相等运算符（`===`）或不等运算符（`!==`）来检查一个值是否不是 `null` 或 `undefined`。

例如，如果你想检查变量 `x` 是否不是 `null`，你可以这样写：
```javascript
if (x !== null) {
    // x 不是 null
}
```

如果你想检查变量 `x` 是否不是 `undefined`，你可以这样写：
```javascript
if (x !== undefined) {
    // x 不是 undefined
}
```

如果你想检查变量 `x` 是否既不是 `null` 也不是 `undefined`，你可以这样写：
```javascript
if (x !== null && x !== undefined) {
    // x 既不是 null 也不是 undefined
}
```

#### 16/20

> 在这里， `===` 和 `==` 会有何区别？以及 `!==` 和 `!=` 会有何区别？以及 `!(a === b)` 相当于 `a !== b` 还是 `a != b` ？ `!(a == b)` 呢？

* Searching for: **difference between == and ===**
* Generating answers for you…

`==` 和 `===` 的区别在于它们比较值时是否进行类型转换。`==` 运算符在比较两个值时，如果它们的类型不同，会先进行类型转换，然后再比较它们的值。而 `===` 运算符在比较两个值时，不仅会比较它们的值，还会比较它们的类型。如果两个值的类型不同，则 `===` 运算符会返回 `false`。

例如，表达式 `1 == '1'` 的结果是 `true`，因为 `==` 运算符会将字符串 `'1'` 转换为数字 `1`，然后再进行比较。但是，表达式 `1 === '1'` 的结果是 `false`，因为两个值的类型不同。

类似地，`!==` 和 `!=` 的区别也在于它们比较值时是否进行类型转换。`!=` 运算符在比较两个值时，如果它们的类型不同，会先进行类型转换，然后再比较它们的值。而 `!==` 运算符在比较两个值时，不仅会比较它们的值，还会比较它们的类型。如果两个值的类型不同，则 `!==` 运算符会返回 `true`。

因此，表达式 `!(a === b)` 等同于 `a !== b`；而表达式 `!(a == b)` 等同于 `a != b`²³。

Source: Conversation with Bing, 2023/5/29
(1) Difference between == and === in JavaScript - Stack Overflow. https://stackoverflow.com/questions/523643/difference-between-and-in-javascript.
(2) Difference Between == and === in Javascript | Scaler Topics. https://www.scaler.com/topics/javascript/difference-between-double-equals-and-triple-equals-in-javascript/.
(3) Difference Between =, ==, and === in JavaScript [Examples] - Guru99. https://www.guru99.com/difference-equality-strict-operator-javascript.html.

#### 17/20

> 我有一个变量，如果它不是 null 或 undefined …… 总之，有指的话，我希望一个由它参与的表达式，其返回为 true ，否则就是 false 。这个表达式要怎么写？

如果你想检查一个变量是否不是 `null` 或 `undefined`，你可以使用逻辑非运算符（`!`）和相等运算符（`==`）来组合一个表达式。例如，如果你想检查变量 `x` 是否不是 `null` 或 `undefined`，你可以这样写：
```javascript
if (x != null) {
    // x 不是 null 或 undefined
}
```
这个表达式会返回 `true`，如果 `x` 不是 `null` 或 `undefined`；否则返回 `false`。

需要注意的是，这里我们使用了相等运算符（`==`），而不是严格相等运算符（`===`）。这是因为相等运算符会在比较两个值时进行类型转换，所以它可以同时检查 `null` 和 `undefined`。如果你使用严格相等运算符（`===`），则只能检查其中一个值。

#### 18/20

> `(x != undefined)` 也可以有类似效果吗？

是的，你说得对。表达式 `x != undefined` 也可以用来检查变量 `x` 是否不是 `null` 或 `undefined`。这是因为相等运算符（`==`）和不等运算符（`!=`）在比较 `null` 和 `undefined` 时，会将它们视为相等的。

因此，表达式 `x != null` 和 `x != undefined` 的效果是一样的。它们都会返回 `true`，如果 `x` 不是 `null` 或 `undefined`；否则返回 `false`。

#### 19/20

> null 和 undefined 这两个值的类型是什么？它们是自类型的吗？有没有别的自类型的值？

* Searching for: **null and undefined types**
* Generating answers for you…

`null` 和 `undefined` 都是 JavaScript 中的原始类型（primitive type）。`null` 类型只有一个值，即 `null`；而 `undefined` 类型也只有一个值，即 `undefined`。

除了 `null` 和 `undefined` 以外，JavaScript 中还有其他几种原始类型，包括布尔类型（`boolean`）、数字类型（`number`）、字符串类型（`string`）、大整数类型（`bigint`）和符号类型（`symbol`）。

需要注意的是，虽然 `null` 是一个原始类型，但如果你使用 `typeof` 运算符检查一个 `null` 值，它会返回 `'object'`。这是 JavaScript 最初实现中的一个错误，后来被 ECMAScript 标准采纳。现在，人们通常认为 `null` 是一个用来表示空对象引用的占位符¹⁴。

Source: Conversation with Bing, 2023/5/29
(1) What is the difference between null and undefined in JavaScript?. https://stackoverflow.com/questions/5076944/what-is-the-difference-between-null-and-undefined-in-javascript.
(2) Null Vs Undefined in TypeScript - TekTutorialsHub. https://www.tektutorialshub.com/typescript/null-undefined-in-typescript/.
(3) Is there a way to check for both `null` and `undefined`?. https://stackoverflow.com/questions/28975896/is-there-a-way-to-check-for-both-null-and-undefined.
(4) Types - Null and Undefined - Beginner JavaScript - Wes Bos. https://wesbos.com/javascript/01-the-basics/types-null-and-undefined/.
(5) How to check null and undefined in TypeScript - GeeksforGeeks. https://www.geeksforgeeks.org/how-to-check-null-and-undefined-in-typescript/.

#### 20/20

> 对于我实现的这个 apply ：
> 
> ~~~ ts
> const apply = 
> (f: Function, args: any[])
> : any => 
>     
>     f(...args) ;
> ~~~
> 
> 调用 `apply(f, [1, 2])` 就相当于调用 `f(1, 2)` ，
> 那么调用 `apply.call(obj, f, [1, 2])` 的话，在效果上能否总是相当于调用 `f.call(obj, 1, 2)` 呢？如果不能，什么情况不能呢？
> 
> 以及还有一个小问题 …… 我必须至少添加什么样的一些代码，才能让我不必写 `fun.call(obj, a, b, c)` 而可以写 `obj.fun(a, b, c)` 呢？
> 

对于你实现的 `apply` 函数，调用 `apply.call(obj, f, [1, 2])` 等同于调用 `apply(f, [1, 2])`，因为你的 `apply` 函数并没有使用 `this` 关键字。在这种情况下，`call` 方法的第一个参数 `obj` 没有任何作用。

如果你想让 `apply.call(obj, f, [1, 2])` 的效果等同于调用 `f.call(obj, 1, 2)`，那么你需要修改你的 `apply` 函数，让它使用 `this` 关键字来调用函数 `f`。例如，你可以这样修改你的 `apply` 函数：
```javascript
const apply = (f: Function, args: any[]): any => f.apply(this, args);
```
这样，当你调用 `apply.call(obj, f, [1, 2])` 时，它相当于调用了 `f.apply(obj, [1, 2])`，进而相当于调用了 `f.call(obj, 1, 2)`。

至于你的第二个问题，如果你想让一个对象拥有一个方法，可以直接在对象上调用该方法，而不必使用 `call` 方法，那么你需要在对象上定义一个方法。例如，如果你想让对象 `obj` 拥有一个名为 `fun` 的方法，可以这样定义：
```javascript
const obj = {
    fun: function(a: any, b: any, c: any) {
        // 在这里实现方法的逻辑
    }
};
```
然后，你就可以直接在对象上调用该方法，而不必使用 `call` 方法：
```javascript
obj.fun(a, b, c);
```

### 102

#### 1/20

> 在 TS ，我有一个函数 `fun` ，一般来说它可以被这样调用： `fun(1,2)` ，但它也可以像这样被调用： `fun.call(someobj, 1, 2)` 或 `fun.apply(someobj, [1,2])` 。这效果是不是相当于，当该函数为 `someobj` 的方法时执行 `someobj.fun(1,2)` ？

* Searching for: **TS call apply 方法**
* Generating answers for you…

是的，你说得对。在 TypeScript 中，`call` 和 `apply` 方法都可以用来改变函数运行时的 `this` 值。`call` 方法接受一个指定的 `this` 值和单独给出的一个或多个参数来调用一个函数，而 `apply` 方法则接受一个指定的 `this` 值和一个参数数组来调用一个函数。因此，当你使用 `fun.call(someobj, 1, 2)` 或 `fun.apply(someobj, [1,2])` 时，它们的效果相当于在 `someobj` 上执行 `someobj.fun(1,2)` ¹²。

你还有其他问题吗？

Source: Conversation with Bing, 2023/5/29
(1) JS中bind、call和apply的作用以及在TS装饰器中的用法 - 鹏多多 - 博客园. https://www.cnblogs.com/-pdd/p/15587105.html.
(2) 浅谈JS中call()和apply()的区别和用途？ - 知乎 - 知乎专栏. https://zhuanlan.zhihu.com/p/414153526.
(3) JS中的call()方法和apply()方法用法总结 - CSDN博客. https://blog.csdn.net/ganyingxie123456/article/details/70855586.

#### 2/20

> 嗯，以后搜索全都用英文搜索。回复我用中文。
> 
> 我想知道，如果不改变 `someobj` 的类或者它的字面量定义，如何向它添加方法？
> 

* Searching for: **add method to object without changing class or literal definition**
* Generating answers for you…

你可以在不改变 `someobj` 的类或者它的字面量定义的情况下，直接向它添加方法。例如，如果你想要添加一个名为 `newMethod` 的方法，你可以这样做：`someobj.newMethod = function() { /* method code here */ }`。这样，你就可以像调用 `someobj` 的其他方法一样调用这个新方法了 ¹。

你还有其他问题吗？

Source: Conversation with Bing, 2023/5/29
(1) JavaScript Object Methods - W3Schools. https://www.w3schools.com/js/js_object_methods.asp.
(2) Adding a Method to an Existing Object Instance - Stack Overflow. https://stackoverflow.com/questions/972/adding-a-method-to-an-existing-object-instance-in-python.
(3) Define a method outside of class definition? - Stack Overflow. https://stackoverflow.com/questions/9455111/define-a-method-outside-of-class-definition.
(4) How to create a method in object literal notation?. https://stackoverflow.com/questions/17486854/how-to-create-a-method-in-object-literal-notation.

#### 3/20

> 如果我有一个对象的名称，但我没有它的类的名称，我要如何向它的类添加静态方法？是所有的类都可以在后续再添加静态方法的吗？

* Searching for: **add static method to class without knowing class name**
* Generating answers for you…

如果你只知道对象的名称，但不知道它的类的名称，那么你无法直接向它的类添加静态方法。你需要知道类的名称才能向它添加静态方法。

你还有其他问题吗？

Source: Conversation with Bing, 2023/5/29
(1) Use static function from a class without naming the class. https://stackoverflow.com/questions/24377333/use-static-function-from-a-class-without-naming-the-class.
(2) How static method call without mentioning the class name. https://stackoverflow.com/questions/49007919/how-static-method-call-without-mentioning-the-class-name.
(3) Static import in Java - GeeksforGeeks. https://www.geeksforgeeks.org/static-import-java/.
(4) Can I call a static method of another class without using the class name?. https://stackoverflow.com/questions/50084012/can-i-call-a-static-method-of-another-class-without-using-the-class-name.

#### 4/20

> 哦？那，我有一个对象的名称，我能否通过 `typeof` 获取它的类？

不行，`typeof` 操作符返回的是一个字符串，表示未经计算的操作数的类型。对于对象，`typeof` 返回的是 `"object"`。如果你想获取对象的类，你可以使用 `Object.prototype.toString.call(obj)` 方法，它会返回一个字符串，格式为 `"[object ClassName]"`，其中 `ClassName` 是对象的类名。你可以通过截取这个字符串来获取类名。

你还有其他问题吗？

#### 5/20

> 这个 `prototype` 是什么东西？不可以 `Object.toString` 吗？

`prototype` 是一个属性，它允许你向对象添加属性和方法。每个构造函数都有一个 `prototype` 属性，它指向原型对象。当你创建一个对象时，它会继承其构造函数的原型。这意味着你可以在原型上定义方法和属性，然后所有的实例都可以访问它们。

`Object.prototype.toString` 是 `Object` 构造函数的原型对象上的一个方法。它返回一个表示对象的字符串。由于 `Object.prototype` 是所有对象的原型链的顶端，所以所有对象都可以访问这个方法。

直接使用 `Object.toString` 是不行的，因为 `toString` 是定义在 `Object.prototype` 上的，而不是在 `Object` 上。你需要使用 `Object.prototype.toString.call(obj)` 来调用这个方法。

你还有其他问题吗？

#### 6/20

> 嗯 …… 我有一个类名，我可以分别怎样为其添加静态或动态的方法？方法体中会用到 this 的那种，具体要怎么写？

如果你有一个类名，你可以通过直接在类定义中添加方法或者在类的原型上添加方法来为其添加动态方法。例如，如果你有一个名为 `MyClass` 的类，你可以这样定义一个名为 `myMethod` 的动态方法：

```javascript
class MyClass {
  myMethod() {
    // method code here
  }
}
```

或者这样在原型上添加方法：

```javascript
MyClass.prototype.myMethod = function() {
  // method code here
}
```

在方法体中，你可以使用 `this` 关键字来访问调用该方法的对象的属性和方法。

要为类添加静态方法，你可以在类定义中使用 `static` 关键字来定义静态方法，或者直接在类上添加方法。例如：

```javascript
class MyClass {
  static myStaticMethod() {
    // method code here
  }
}

// 或者

MyClass.myStaticMethod = function() {
  // method code here
}
```

静态方法是直接挂载在类上的，而不是在类的实例上。因此，在静态方法中，`this` 关键字指向的是类本身，而不是类的实例。

你还有其他问题吗？

#### 7/20

> 什么是原型？以及，静态方法的 `this` 指向类本身，这个 `类本身` 是啥意思？

原型（prototype）是 JavaScript 中实现继承的一种机制。每个构造函数都有一个 `prototype` 属性，它指向一个对象，这个对象称为原型对象。当你使用构造函数创建一个新对象时，这个新对象会继承其构造函数的原型。这意味着你可以在原型上定义方法和属性，然后所有的实例都可以访问它们。

当你在一个对象上调用一个方法或访问一个属性时，JavaScript 引擎会首先在该对象本身上查找这个方法或属性。如果找不到，它会沿着原型链向上查找，直到找到这个方法或属性，或者到达原型链的顶端（`Object.prototype`）。如果仍然找不到，它会返回 `undefined`。

关于静态方法中的 `this` 指向类本身，这里的 `类本身` 指的是类的构造函数。在 JavaScript 中，类实际上就是一个特殊的函数，它可以用来创建对象。当你在静态方法中使用 `this` 时，它指向的就是这个构造函数。你可以通过 `this` 来访问类的静态属性和方法。

你还有其他问题吗？

#### 8/20

> 我不能用 `type X = typeof someobj ; X.prototype.newMethod = ... ; X.newStaticMethod = ...` 来为一个类添加动态或静态方法吗？

不行，你不能使用 `typeof` 来获取对象的类。`typeof` 操作符返回的是一个字符串，表示未经计算的操作数的类型。对于对象，`typeof` 返回的是 `"object"`。

如果你想要获取对象的类，你可以使用 `Object.getPrototypeOf(obj).constructor` 来获取它的构造函数。然后，你可以在构造函数的原型上添加动态方法，或者直接在构造函数上添加静态方法。例如：

```javascript
const MyClass = Object.getPrototypeOf(someobj).constructor;

// 添加动态方法
MyClass.prototype.newMethod = function() {
  // method code here
}

// 添加静态方法
MyClass.newStaticMethod = function() {
  // method code here
}
```

你还有其他问题吗？

#### 9/20

> 有没有什么类或者对象，不允许被添加动态或静态方法？

* Searching for: **objects or classes that cannot have methods added**
* Generating answers for you…

在 JavaScript 中，大多数类和对象都允许添加动态或静态方法。但是，有一些内置的类和对象，如 `Math` 和 `JSON`，它们的原型是只读的，因此你不能向它们添加动态方法。此外，如果一个对象被冻结（使用 `Object.freeze()` 方法），则不能向它添加新属性或方法。

你还有其他问题吗？

Source: Conversation with Bing, 2023/5/29
(1) Adding a Method to an Existing Object Instance - Stack Overflow. https://stackoverflow.com/questions/972/adding-a-method-to-an-existing-object-instance-in-python.
(2) Classes and objects - C# Fundamentals tutorial | Microsoft Learn. https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/tutorials/classes.
(3) python - `object` class has does not have all magic methods, such as .... https://stackoverflow.com/questions/76193921/object-class-has-does-not-have-all-magic-methods-such-as-add-but-how-t.
(4) Object of child class cannot call its own methods. https://stackoverflow.com/questions/25696612/object-of-child-class-cannot-call-its-own-methods.

#### 10/20

> 如何在定义类的时候让原型只读？如何让某个用字面量定义的对象（如 `const x = 3` `const y = (a: number) => a+a` `const z = {a:1,b:"x"}` `const a = [1,2,3]` 等等这些）只读？以及 `Object.freeze()` 具体是咋用的？

你可以使用 `Object.defineProperty()` 方法来定义一个只读的原型属性。例如，如果你有一个名为 `MyClass` 的类，你可以这样定义它的原型：

```javascript
class MyClass {}

Object.defineProperty(MyClass, 'prototype', {
  writable: false,
  configurable: false
});
```

这样，`MyClass.prototype` 属性就变成了只读的，你不能再修改它。

对于用字面量定义的对象，你可以使用 `Object.freeze()` 方法来冻结它们。例如：

```javascript
const x = {a: 1, b: "x"};
Object.freeze(x);
```

这样，对象 `x` 就被冻结了，你不能再向它添加新属性或方法，也不能修改它现有的属性。

`Object.freeze()` 方法接受一个对象作为参数，并将其冻结。被冻结的对象不能添加新属性或方法，也不能修改现有的属性。需要注意的是，`Object.freeze()` 只能冻结对象本身，而不能冻结对象的属性所引用的其他对象。例如：

```javascript
const x = {a: 1, b: {c: 2}};
Object.freeze(x);

x.a = 2; // 报错
x.b.c = 3; // 不报错
```

在上面的例子中，虽然对象 `x` 被冻结了，但是它的属性 `b` 所引用的对象并没有被冻结，因此你仍然可以修改这个对象的属性。

你还有其他问题吗？

#### 11/20

> 如何做到完全冻结？

要完全冻结一个对象，你需要递归地冻结它的所有属性。你可以编写一个函数来实现这个功能。例如：

```javascript
function deepFreeze(obj) {
  // 获取对象上的所有属性名
  const propNames = Object.getOwnPropertyNames(obj);

  // 冻结每个属性
  for (let name of propNames) {
    let value = obj[name];
    // 如果属性值是一个对象，递归冻结它
    if (value && typeof value === "object") {
      deepFreeze(value);
    }
  }

  // 冻结对象本身
  return Object.freeze(obj);
}
```

这样，你就可以使用 `deepFreeze()` 函数来完全冻结一个对象及其所有属性了。

你还有其他问题吗？

#### 12/20

> 对于 `value` 为何要用 `let` ？不可以用 `const` 吗在这里？

在这个例子中，`let` 和 `const` 都可以使用。`let` 和 `const` 的区别在于 `let` 定义的变量可以被重新赋值，而 `const` 定义的变量不能被重新赋值。在这个例子中，变量 `value` 只被赋值一次，因此你可以使用 `const` 来定义它。

```javascript
function deepFreeze(obj) {
  // 获取对象上的所有属性名
  const propNames = Object.getOwnPropertyNames(obj);

  // 冻结每个属性
  for (let name of propNames) {
    const value = obj[name];
    // 如果属性值是一个对象，递归冻结它
    if (value && typeof value === "object") {
      deepFreeze(value);
    }
  }

  // 冻结对象本身
  return Object.freeze(obj);
}
```

你还有其他问题吗？

#### 13/20

> 能不能改为用 reduce 或 map 或 foreach （如有）来写？不要用 `for (...of...)` 或其它任何 for 循环来写。

是的，你可以使用 `forEach` 方法来替代 `for...of` 循环。`forEach` 方法接受一个回调函数作为参数，它会遍历数组中的每个元素，并对每个元素执行回调函数。你可以这样重写 `deepFreeze` 函数：

```javascript
function deepFreeze(obj) {
  // 获取对象上的所有属性名
  const propNames = Object.getOwnPropertyNames(obj);

  // 冻结每个属性
  propNames.forEach(name => {
    const value = obj[name];
    // 如果属性值是一个对象，递归冻结它
    if (value && typeof value === "object") {
      deepFreeze(value);
    }
  });

  // 冻结对象本身
  return Object.freeze(obj);
}
```

需要注意的是，`reduce` 和 `map` 方法不适用于这种情况，因为它们都会返回一个新数组，而我们并不需要返回一个新数组。

你还有其他问题吗？

#### 14/20

> 我想把这个函数添加给 `Object` 使之成为一个静态方法，这可行吗？

是的，你可以把 `deepFreeze` 函数添加到 `Object` 上，使之成为一个静态方法。你可以这样做：

```javascript
Object.deepFreeze = function(obj) {
  // 获取对象上的所有属性名
  const propNames = Object.getOwnPropertyNames(obj);

  // 冻结每个属性
  propNames.forEach(name => {
    const value = obj[name];
    // 如果属性值是一个对象，递归冻结它
    if (value && typeof value === "object") {
      Object.deepFreeze(value);
    }
  });

  // 冻结对象本身
  return Object.freeze(obj);
}
```

这样，你就可以使用 `Object.deepFreeze(obj)` 来调用这个方法了。

需要注意的是，修改内置对象（如 `Object`）可能会导致代码与其他库或框架不兼容。因此，除非你有充分的理由，否则不建议这样做。

你还有其他问题吗？

#### 15/20

> 那么，对于开头的问题，我现在有一个 `obj` 它没有 `fun` 动态方法，我可以 `fun.call(obj, 1, 2)` 或者 `obj.fun = fun ; obj.fun(1,2)` 来达到同样的结果，对吗？只是后者改动了对象的方法而已

是的，你说得对。如果你有一个对象 `obj` 和一个函数 `fun`，你可以使用 `fun.call(obj, 1, 2)` 来调用 `fun` 函数，并将 `obj` 作为 `this` 值传递给它。这样，当 `fun` 函数执行时，它内部的 `this` 关键字就会指向 `obj`。

另外，你也可以将 `fun` 函数赋值给 `obj` 的一个属性，然后通过这个属性来调用它。例如：

```javascript
obj.fun = fun;
obj.fun(1, 2);
```

这样，当你调用 `obj.fun(1, 2)` 时，它实际上就相当于调用了 `fun.call(obj, 1, 2)`。

需要注意的是，这两种方法的效果是相同的，但它们的实现方式不同。使用 `call` 方法时，你并没有修改 `obj` 对象本身；而使用第二种方法时，你向 `obj` 对象添加了一个新的属性。

你还有其他问题吗？

#### 16/20

> 哦？这只是新属性吗？它和用 `prototype` 添加动态方法不一样是吗？

是的，当你使用 `obj.fun = fun` 这种方式来添加方法时，你只是向 `obj` 对象添加了一个新属性，而不是在它的原型上添加了一个动态方法。

当你在一个对象的原型上添加方法时，所有继承自这个原型的对象都可以访问这个方法。例如，如果你有一个名为 `MyClass` 的类，你可以这样在它的原型上添加一个名为 `myMethod` 的动态方法：

```javascript
MyClass.prototype.myMethod = function() {
  // method code here
}
```

然后，所有 `MyClass` 的实例都可以访问这个方法：

```javascript
const obj1 = new MyClass();
const obj2 = new MyClass();

obj1.myMethod(); // 调用 myMethod 方法
obj2.myMethod(); // 调用 myMethod 方法
```

但是，当你直接向一个对象添加方法时，只有这个对象本身可以访问这个方法，它的其他实例无法访问。例如：

```javascript
const obj1 = new MyClass();
const obj2 = new MyClass();

obj1.myMethod = function() {
  // method code here
}

obj1.myMethod(); // 调用 myMethod 方法
obj2.myMethod(); // 报错：myMethod is not a function
```

在上面的例子中，我们只向 `obj1` 对象添加了 `myMethod` 方法，因此只有 `obj1` 可以访问这个方法。当我们试图在 `obj2` 上调用这个方法时，会报错。

你还有其他问题吗？

#### 17/20

> 如果一个类事先创建了实例，我再添加或者改动（我不知道改动是否可以做到所以这个疑问也请您顺便解答一下）动态方法，这当然会对之后再创建的实例产生影响，但对于已经创建过的实例也会有影响吗？

是的，当你在一个类的原型上添加或修改动态方法时，它会影响所有继承自这个原型的对象，包括已经创建过的实例和之后再创建的实例。

例如，如果你有一个名为 `MyClass` 的类，你可以这样创建两个实例：

```javascript
class MyClass {}

const obj1 = new MyClass();
const obj2 = new MyClass();
```

然后，你可以在 `MyClass` 的原型上添加一个名为 `myMethod` 的动态方法：

```javascript
MyClass.prototype.myMethod = function() {
  console.log('myMethod');
}
```

这样，`obj1` 和 `obj2` 都可以访问这个方法：

```javascript
obj1.myMethod(); // 输出 "myMethod"
obj2.myMethod(); // 输出 "myMethod"
```

此外，你也可以修改原型上的方法。例如，你可以这样修改 `myMethod` 方法：

```javascript
MyClass.prototype.myMethod = function() {
  console.log('modified myMethod');
}
```

这样，当你再次调用 `myMethod` 方法时，它会输出新的内容：

```javascript
obj1.myMethod(); // 输出 "modified myMethod"
obj2.myMethod(); // 输出 "modified myMethod"
```

需要注意的是，如果一个对象本身具有与原型上同名的方法，那么它会覆盖原型上的方法。例如：

```javascript
const obj1 = new MyClass();
const obj2 = new MyClass();

obj1.myMethod = function() {
  console.log('my own myMethod');
}

obj1.myMethod(); // 输出 "my own myMethod"
obj2.myMethod(); // 输出 "modified myMethod"
```

在上面的例子中，我们向 `obj1` 对象添加了一个名为 `myMethod` 的方法。当我们在 `obj1` 上调用这个方法时，它会输出自己定义的内容，而不是原型上定义的内容。但是，在 `obj2` 上调用这个方法时，它仍然会输出原型上定义的内容。

你还有其他问题吗？

#### 18/20

> 我注意到你在说 `obj.fun = fun` 的时候，你把这叫作添加（或者改动）一个属性，后来你又管这个叫直接给对象添加方法。在 JS/TS （或者 ES 标准）里，属性和方法是比较模糊的吗？二者难道其实是一回事、只是有很多写起来像 Java 一样的语法糖所以它们看起来不同？

在 JavaScript 中，方法本质上就是一个函数类型的属性。当你使用 `obj.fun = fun` 这种方式来添加方法时，你实际上就是在向 `obj` 对象添加了一个名为 `fun` 的属性，它的值是一个函数。

JavaScript 允许你通过 `obj.fun()` 这种语法来调用对象上的函数类型的属性。当你这样做时，JavaScript 引擎会自动将 `this` 关键字绑定到 `obj` 上，然后调用这个函数。

因此，在 JavaScript 中，属性和方法并不是严格区分的。你可以把方法看作是一种特殊的属性，它的值是一个函数。

你还有其他问题吗？

#### 19/20

> 就是说， `obj.fun = fun` 和 `Object.getPrototypeOf(obj).constructor.prototype.fun = fun` 是完全一样的吗？其实都只是添加或修改了名为 fun 的属性？
> 
> 哦！那我还有一个问题，假设 `obj` 的类的定义中早就设定过名为 `fun` 的方法（或者说属性 —— 就象你所说它们在 JS 里其实是一回事只是有的写法上会看起来不同），并且，这个方法还被 `static` 修饰了，也就是说它是静态的值，那么，执行 `obj.fun = fun` 或 `Object.getPrototypeOf(obj).constructor.prototype.fun = fun` 的话，会发生什么？报错？还是不会报错、而静态动态方法彼此会乖乖地井水不犯河水？
> 

不，`obj.fun = fun` 和 `Object.getPrototypeOf(obj).constructor.prototype.fun = fun` 是不同的。

当你使用 `obj.fun = fun` 时，你是在向 `obj` 对象本身添加或修改一个名为 `fun` 的属性。如果 `obj` 对象本身已经具有一个名为 `fun` 的属性，那么这个属性的值会被覆盖；否则，会在 `obj` 对象上添加一个新的属性。

当你使用 `Object.getPrototypeOf(obj).constructor.prototype.fun = fun` 时，你是在向 `obj` 对象的原型上添加或修改一个名为 `fun` 的方法。这会影响所有继承自这个原型的对象，包括已经创建过的实例和之后再创建的实例。

如果一个类定义中已经定义了一个名为 `fun` 的静态方法，那么执行 `obj.fun = fun` 或 `Object.getPrototypeOf(obj).constructor.prototype.fun = fun` 都不会影响这个静态方法。静态方法是直接挂载在类上的，而不是在类的实例或原型上。因此，当你修改类的实例或原型时，它不会影响类上定义的静态方法。

例如，如果你有一个名为 `MyClass` 的类，它定义了一个名为 `myMethod` 的静态方法：

```javascript
class MyClass {
  static myMethod() {
    console.log('myMethod');
  }
}

const obj = new MyClass();
```

然后，你可以这样修改 `obj` 对象上的 `myMethod` 属性：

```javascript
obj.myMethod = function() {
  console.log('modified myMethod');
}
```

或者这样修改 `MyClass.prototype` 上的 `myMethod` 方法：

```javascript
MyClass.prototype.myMethod = function() {
  console.log('modified myMethod');
}
```

但是，无论你怎样修改，都不会影响类上定义的静态方法：

```javascript
MyClass.myMethod(); // 输出 "myMethod"
```

你还有其他问题吗？

#### 20/20

> 非常感谢。看起来， JS/TS 的底层机制是原型，类也好接口也好都只是语法糖而已。我不知道除了 `class` 或 `interface` 这样的关键字外还有没有类似的关键字来定义类或者与类相似的东西。
> 
> 这些关键字是不是都有对应的它本来的写法（譬如对于 `class` 关键字的定义其 本来的写法就是原型）？我想看看它们都是怎么对应的。
> 
> 哦，对了，我想到了 `namespace` 。它也有对应的本来的写法吗？如果有，是原型吗？
> 

是的，你说得对。在 JavaScript 中，类和接口都是基于原型的语法糖。当你使用 `class` 关键字定义一个类时，JavaScript 引擎会自动为你创建一个构造函数和一个原型对象。你可以在类定义中添加方法和属性，它们会被添加到构造函数或原型对象上。

例如，下面的类定义：

```javascript
class MyClass {
  constructor(x) {
    this.x = x;
  }

  myMethod() {
    console.log(this.x);
  }
}
```

相当于这样使用构造函数和原型对象来定义类：

```javascript
function MyClass(x) {
  this.x = x;
}

MyClass.prototype.myMethod = function() {
  console.log(this.x);
}
```

在 TypeScript 中，`interface` 关键字用于定义接口。接口是一种抽象类型，它只定义了对象应该具有哪些属性和方法，但并不提供具体的实现。由于接口只是一种抽象类型，它并没有对应的 JavaScript 代码。

至于 `namespace` 关键字，它用于定义命名空间。命名空间可以帮助你组织代码，避免命名冲突。在 JavaScript 中，并没有直接对应的概念。但是，你可以使用对象来模拟命名空间。例如，下面的 TypeScript 代码：

```typescript
namespace MyNamespace {
  export function myFunction() {
    console.log('myFunction');
  }
}

MyNamespace.myFunction();
```

相当于这样使用对象来模拟命名空间：

```javascript
const MyNamespace = {
  myFunction: function() {
    console.log('myFunction');
  }
}

MyNamespace.myFunction();
```

你还有其他问题吗？
