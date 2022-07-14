
## 利用重复函数切数字

~~~~ sql
select 1234567 div cast(concat(1,repeat(0,4)) as int) ; --> 123
select 1234567 % cast(concat(1,repeat(0,4)) as int) ; --> 4567

-- 毫秒时间戳里拆出秒和里面的毫秒 - 可以
select 1656646319321 div cast(concat(1,repeat(0,3)) as int) ; --> 1656646319
select 1656646319321 % cast(concat(1,repeat(0,3)) as int) ; --> 321
~~~~

数字不长也可以像下面这样，算一次切一刀：

~~~~ sql
select split(cast(1234567 / cast(concat(1,repeat(0,4)) as int) as string),"\\.")[0] ; --> 123
select split(cast(1234567 / cast(concat(1,repeat(0,4)) as int) as string),"\\.")[1] ; --> 4567

-- 毫秒时间戳里拆出秒和里面的毫秒 - 失败
select split(cast(1656646319321 / cast(concat(1,repeat(0,3)) as int) as string),"\\.")[0] ; --> 1
select split(cast(1656646319321 / cast(concat(1,repeat(0,3)) as int) as string),"\\.")[1] ; --> 656646319321E9
~~~~

可以看到，太长的话会变成科学计数法就不好弄了，还得用整除（ `div` ）和模（ `%` ）。
