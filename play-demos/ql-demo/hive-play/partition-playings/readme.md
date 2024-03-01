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



