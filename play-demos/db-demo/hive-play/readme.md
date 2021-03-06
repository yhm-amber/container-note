
## 利用重复函数切数字

~~~~ sql
-- 简单示例 - 可以
select 1234567 div cast(concat(1,repeat(0,4)) as int) ; --> 123
select 1234567 % cast(concat(1,repeat(0,4)) as int) ; --> 4567

-- 毫秒时间戳里拆出秒和里面的毫秒 - 可以
select 1656646319321 div cast(concat(1,repeat(0,3)) as int) ; --> 1656646319
select 1656646319321 % cast(concat(1,repeat(0,3)) as int) ; --> 321
~~~~

数字不长也可以像下面这样，算一次切一刀：

~~~~ sql
-- 简单示例 - 可以
select split(cast(1234567 / cast(concat(1,repeat(0,4)) as int) as string),"\\.")[0] ; --> 123
select split(cast(1234567 / cast(concat(1,repeat(0,4)) as int) as string),"\\.")[1] ; --> 4567

-- 毫秒时间戳里拆出秒和里面的毫秒 - 失败
select split(cast(1656646319321 / cast(concat(1,repeat(0,3)) as int) as string),"\\.")[0] ; --> 1
select split(cast(1656646319321 / cast(concat(1,repeat(0,3)) as int) as string),"\\.")[1] ; --> 656646319321E9
~~~~

可以看到，太长的话会变成科学计数法就不好弄了，还得用整除（ `div` ）和模（ `%` ）。想用数组可以参考这样的片段：

~~~~ sql
...
, array
(
    cast (max_ts div cast(concat(1,repeat(0,3)) as int) as bigint) ,
    cast (max_ts % cast(concat(1,repeat(0,3)) as int) as int) ) as max_remdiv_ts
...
~~~~

取到数字后，可以转成日期格式并拼接小数点后的位数：

~~~~ sql
...
, concat
(
    from_unixtime (max_remdiv_ts[0], "yyyy-MM-dd HH:mm:ss") ,
    "." , max_remdiv_ts[1] ) max_date
...
~~~~

## 取得上一条的某字段

ref: https://www.cnblogs.com/erlou96/p/13590358.html  

使用 `LAG () OVER ()` 。

我们有这样一张表：

~~~
+--------------+------------+-------------+
| player_name  | point_get  |  play_time  |
+--------------+------------+-------------+
| a            | 1          | 1656604801  |
| b            | 4          | 1656604803  |
| c            | 1          | 1656604802  |
| a            | 3          | 1656604807  |
| a            | 2          | 1656604808  |
| c            | 3          | 1656604800  |
| b            | 7          | 1656604804  |
| a            | 1          | 1656604801  |
| b            | 9          | 1656604805  |
| c            | 2          | 1656604810  |
+--------------+------------+-------------+
~~~

生成产生它的代码的方式之一：

~~~ sh
echo '

    a 1 1656604801
    b 4 1656604803
    c 1 1656604802
    a 3 1656604807
    a 2 1656604808
    c 3 1656604800
    b 7 1656604804
    a 1 1656604801
    b 9 1656604805
    c 2 1656604810
    
    ' |
    
    xargs -i -- echo "'\"{}\"'" |
    tr ' ' '|' | xargs | tr ' ' ',' |
    
    awk '{print"    "$0}BEGIN{print"select explode (array ("}END{print") ) col"}' |
    awk '{print"    "$0}BEGIN{print"select split(x.col,\"\\\\|\") s from";print"("}END{print") x"}' |
    awk '{print"    "$0}BEGIN{print"select p.s[0] player_name, p.s[1] point_get, p.s[2] play_time from";print"("}END{print") p"}'
~~~

上面会给你打印一条 sql 。你可以在任何 hive 的 `beeline` 中执行（它是无状态的），你也可以把它作为子查询使用：

~~~~ sql
select player_name
, point_get, play_time
, lag
(
    array(point_get,play_time) ,
    1 , array(NULL,NULL) ) over
(
    partition by player_name
    order by point_get asc ) pre

from
(
    select p.s[0] player_name, p.s[1] point_get, p.s[2] play_time
    from
    (
        select split(x.col,"\\|") s
        from
        (
            select explode (array
            (
                "a|1|1656604801" ,
                "b|4|1656604803" ,
                "c|1|1656604802" ,
                "a|3|1656604807" ,
                "a|2|1656604808" ,
                "c|3|1656604800" ,
                "b|7|1656604804" ,
                "a|1|1656604801" ,
                "b|9|1656604805" ,
                "c|2|1656604810" ) ) col
        ) x
    ) p
) source ;
~~~~

执行结果：

~~~
+--------------+------------+-------------+---------------------+
| player_name  | point_get  |  play_time  |         pre         |
+--------------+------------+-------------+---------------------+
| a            | 1          | 1656604801  | [null,null]         |
| a            | 1          | 1656604801  | ["1","1656604801"]  |
| a            | 2          | 1656604808  | ["1","1656604801"]  |
| a            | 3          | 1656604807  | ["2","1656604808"]  |
| b            | 4          | 1656604803  | [null,null]         |
| b            | 7          | 1656604804  | ["4","1656604803"]  |
| b            | 9          | 1656604805  | ["7","1656604804"]  |
| c            | 1          | 1656604802  | [null,null]         |
| c            | 2          | 1656604810  | ["1","1656604802"]  |
| c            | 3          | 1656604800  | ["2","1656604810"]  |
+--------------+------------+-------------+---------------------+
~~~

逻辑：在按 `player_name` 分组时、取按照 `play_time` 正序排序时的 `本条的前一条` ，作为本条对应的字段 `pre` 中的内容。

关键的部位：

~~~ sql
, lag
(
    array(point_get,play_time) ,
    1,array(NULL,NULL) ) over
(
    partition by player_name
    order by point_get desc ) pre
~~~

这里：

- 在 `lag ()` 的括号中要指定的，有三方面的事：
  
  1. 最终会被填写在 `pre` 的值，要以什么样的表达式算出。
  2. 表示 `前几行` 的 `lag` ，这个位置写 `1` ，那就是取 `前一行` 的意思。
  3. 如果对当前行而言，被指定的 `前几行` 不存在，那么在当前行这个字段，填个啥。
  
  要取 `后几行` 则要用 `lead` ，参数位置和 `lag` 一样。
  
- 在 `over ()` 的括号中要指定的，在此处有两方面的事：上面的 `lag` 的 `前几行` ，究竟是在一个怎样的分组和排序前提下的 `前几行` 。





