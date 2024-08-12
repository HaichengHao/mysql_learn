-- 22视图
'''
视图的作用
使用关联查询，sql如下
select goods.name,goods_cates.name,goods_brands.name
from goods
	inner join goods_cates on goods.cate_id = goods_cates.cate_id
	inner join goods_brands on goods.brand_id = goods_brands.id;

上述复杂的查询，往往是有多个数据表进行关联查询而得到，我们可能非常频繁的使用

为了简化用户的复杂操作，我们可以考虑使用视图
通过视图可以对用户展示指定字段而屏蔽其他字段的数据，更加安全


'''
'''
什么是视图
视图就是一个能够把复杂sql语句的功能封装起来的一个虚表。所以我们在创建视图的时候，
主要的工作就落在创建这条sql语句上

视图是对若干张基本表的引用，一张虚表，不存储具体的数据(基本表数据发生了变化，视图也会跟着改变)

视图的好处:方便操作，特别是查询操作，减少复杂的sql语句，增强可读性，复用性


比如说我们将goods表，goods_cates表和goods_brands表关联起来，利用视图我们可以将复杂的查询语句
进行封装，得到一个虚拟的表，这个表不存储数据
'''


-- 视图的基本使用
-- step1 创建视图

--- 定义视图 create view 视图名称 as select语句; 其基本语法和创建表很相似,视图命名多以v开头
create view 视图名;

--实例使用python_test_1数据库
--查出学生的id,姓名,年龄,性别和学生的班级
select s.id,s.name,s.age,s.gender,c.name as cls_name
from students as s
inner join classes as c
on s.cls_id=c.id;
'''
mysql> select s.id,s.name,s.age,s.gender,c.name
    -> from students as s
    -> inner join classes as c
    -> on s.cls_id=c.id;
+----+--------------+------+--------+--------------+
| id | name         | age  | gender | name         |
+----+--------------+------+--------+--------------+
|  1 | 小明         |   18 | 女     | python_01期  |
|  2 | 小月月       |   18 | 女     | python_02期  |
|  3 | 彭于晏       |   29 | 男     | python_01期  |
|  4 | 刘德华       |   59 | 男     | python_02期  |
|  5 | 黄蓉         |   38 | 女     | python_01期  |
|  6 | 凤姐         |   28 | 保密   | python_02期  |
|  7 | 王祖贤       |   18 | 女     | python_01期  |
|  8 | 周杰伦       |   36 | 男     | python_01期  |
|  9 | 程坤         |   27 | 男     | python_02期  |
| 10 | 刘亦菲       |   25 | 女     | python_02期  |
| 15 | 凌小小       |   28 | 女     | python_01期  |
| 16 | 司马二狗     |   28 | 男     | python_01期  |
+----+--------------+------+--------+--------------+
12 rows in set (0.10 sec)
'''
--上面的语句如果每次都要写是很麻烦的，所以我们创建视图
create view v_students as 
select s.id,s.name,s.age,s.gender,c.name as cls_name
from students as s
inner join classes as c
on s.cls_id=c.id;

---step2 查看视图
--视图其实就是一个虚拟的表，所以我们查看表的语法是适用于视图的
show tables;
'''
mysql> show tables;
+-------------------------+
| Tables_in_python_test_1 |
+-------------------------+
| classes                 |
| students                |
| v_students              |
+-------------------------+
3 rows in set (0.01 sec)
'''


--step3 使用视图
--和使用表差不多
select * from 视图名;
select * from v_students;
'''
mysql> select * from v_students;
+----+--------------+------+--------+--------------+
| id | name         | age  | gender | cls_name     |
+----+--------------+------+--------+--------------+
|  1 | 小明         |   18 | 女     | python_01期  |
|  2 | 小月月       |   18 | 女     | python_02期  |
|  3 | 彭于晏       |   29 | 男     | python_01期  |
|  4 | 刘德华       |   59 | 男     | python_02期  |
|  5 | 黄蓉         |   38 | 女     | python_01期  |
|  6 | 凤姐         |   28 | 保密   | python_02期  |
|  7 | 王祖贤       |   18 | 女     | python_01期  |
|  8 | 周杰伦       |   36 | 男     | python_01期  |
|  9 | 程坤         |   27 | 男     | python_02期  |
| 10 | 刘亦菲       |   25 | 女     | python_02期  |
| 15 | 凌小小       |   28 | 女     | python_01期  |
| 16 | 司马二狗     |   28 | 男     | python_01期  |
+----+--------------+------+--------+--------------+
12 rows in set (0.00 sec)
'''

--step4 删除视图
drop view 视图名;
drop view v_students;

