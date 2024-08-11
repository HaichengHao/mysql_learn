--04修改查询命令

-- DQL
-- select * from 表名; 查询所有列数据 
select * from student;
-- select * from 表名 where 字段名; 按条件查询
select * from student where gender='女';


-- select 列1,列2，... from 表名;  查询指定列数据 
select name from student;
select gender from student;
select gender,name from student;
-- select 字段名[as 别名],字段名[as 别名] from 数据表;可以实现给字段名起别名的形式查询字段
-- 注意只是起了别名，并不是真正修改了字段的名字
select name as "名字" from student;
'''
+---------+
| 名字    |
+---------+
| 小花    |
| 德华    |
| 小华    |
| 小花2   |
+---------+'''


--DML
-- update 表名 set 列1=值1,列2=值2....where 条件; 修改数据
update student set gender="女" where name="小花";
update student set name="小华" where name="小花1";
update student set gender="男" where name="德华";
update student set cls_id=120, heigh=178.67 where name="德华";

--DQL
-- 改变字段的顺序
select age,name from student;
--DQL 另外的查询方式
-- 使用 select 表名.字段名 from 表名; 的形式查询
select student.name from student;
-- 消除重复行distinct(明显不同的)
-- select distinct 字段名 from 表名;
select distinct gender from student;
'''
mysql> select distinct s.gender from students as s;
+--------+
| gender |
+--------+
| 女     |
| 男     |
| 保密   |
| 中性   |
+--------+
4 rows in set (0.00 sec)
'''

-- 可以通过 as 给表起别名，这样可以缩短表名.字段名查询方式的语句长度
-- select 别名.字段 .... from 表名 as 别名;
select s.name from students as s;
mysql> select s.name from students as s;
'''
+--------------+
| name         |
+--------------+
| 小明         |
| 小月月       |
| 彭于晏       |
| 刘德华       |
| 黄蓉         |
| 凤姐         |
| 王祖贤       |
| 周杰伦       |
| 程坤         |
| 刘亦菲       |
| 金星         |
| 静香         |
| 郭靖         |
| 周杰         |
| 凌小小       |
| 司马二狗     |
+--------------+
'''