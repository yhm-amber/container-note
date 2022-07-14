
## 利用重复函数切数字

~~~~ sql
select 1234567 div cast(concat(1,repeat(0,4)) as int) ; --> 123
select 1234567 % cast(concat(1,repeat(0,4)) as int) ; --> 4567
~~~~

or

~~~~ sql
select split(cast(1234567 / cast(concat(1,repeat(0,4)) as int) as string),"\\.")[0] ; --> 123
select split(cast(1234567 / cast(concat(1,repeat(0,4)) as int) as string),"\\.")[1] ; --> 4567
~~~~


