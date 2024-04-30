## 单次插入多分区

### 简单示例

数据准备

~~~ sql
create table part_test (a int) partitioned by (h int);
create table part_test_src (a int, b int);

insert into part_test_src select 1,2 ;
insert into part_test_src select 3,4 ;
insert into part_test_src select 5,6 ;
~~~

查看内容

~~~ sql
select * from part_test_src
-- -- -- -- 
--   a b
-- 1 5 6
-- 2 3 4
-- 3 1 2

select a, (b - 6) as h from part_test_src
-- -- -- -- 
--   a  h
-- 1 5  0
-- 2 1 -4
-- 3 3 -2
~~~

全分区插入

~~~ sql
> insert into part_test PARTITION (h) select a, (b - 6) as h from part_test_src
~~~

结果验证

~~~ sql
select * from part_test where h in (0)
-- -- -- --
--   a h
-- 1 5 0

select * from part_test where h in (0,-2,-4)
-- -- -- -- 
--   a  h
-- 1 5  0
-- 2 1 -4
-- 3 3 -2
~~~

如果想要覆盖插入，改用 `INSERT OVERWRITE` 即可。

相关资料： [hadoop - Hive : Insert overwrite multiple partitions | Stack Overflow]

[hadoop - Hive : Insert overwrite multiple partitions | Stack Overflow]: https://stackoverflow.com/questions/18667553/hive-insert-overwrite-multiple-partitions

## 用 CREATE TABLE AS SELECT 创建分区表

新版本可以在原来的 `partitioned by` 前面加上 `as select ...`　即可，但早期版本不支持。

如不支持，可以先创建 View ，就用原本 `as` 后的查询语句，然后需要能够处理通过 View 获取到的元信息，然后借助该信息可在指定分区键的情况下拼接出没有 `as` 的普通的建表 DDL ， 然后把 View 中的内容插入其中即可。

这可能需要在其它语言中实现，关键就在于能够通过从 View 获取元数据从而可以拼接建表 DDL 。这是一个例子： [`crossingview.R`](./crossingview.R)
