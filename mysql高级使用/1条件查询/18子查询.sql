--18子查询
'''
子查询：把一个查询结果当成另一个查询的条件


子查询分为三类
标量子查询：子查询返回的结果是一个数据（一列一行）
列子查询：返回的结果是一列（一列多行）
行子查询：返回的结果是一行（一行多列）

'''
-- 使用students表
--查询平均身高
select avg(height) from students
'''
mysql> select avg(height) from students;
+-------------+
| avg(height) |
+-------------+
|  169.133333 |
+-------------+
1 row in set (0.08 sec)

'''
--查询身高高于平均身高的信息
select * from students where height>(select avg(height) from students);
'''
mysql> select * from students where height>(select avg(height) from students);
+----+-----------+------+--------+--------+--------+----------------------+
| id | name      | age  | height | gender | cls_id | is_delete            |
+----+-----------+------+--------+--------+--------+----------------------+
|  1 | 小明      |   18 | 180.00 | 女     |      1 | 0x00                 |
|  2 | 小月月    |   18 | 180.00 | 女     |      2 | 0x01                 |
|  3 | 彭于晏    |   29 | 185.00 | 男     |      1 | 0x00                 |
|  4 | 刘德华    |   59 | 175.00 | 男     |      2 | 0x01                 |
|  7 | 王祖贤    |   18 | 172.00 | 女     |      1 | 0x01                 |
|  9 | 程坤      |   27 | 181.00 | 男     |      2 | 0x00                 |
| 12 | 静香      |   12 | 180.00 | 女     |      4 | 0x00                 |
| 13 | 郭靖      |   12 | 170.00 | 男     |      4 | 0x00                 |
| 14 | 周杰      |   34 | 176.00 | 女     |      5 | 0x00                 |
| 15 | 凌小小    |   28 | 180.00 | 女     |      1 | 0x00                 |
+----+-----------+------+--------+--------+--------+----------------------+
10 rows in set (0.08 sec)
'''
-- 查询学生的班级号能够对应学生的学生名字
-- 之前的内连接方式
select students.name from students inner join classes on students.cls_id=classes.id; 
-- 新方式,利用子查询
select name from students where cls_id in (select id from classes);
'''
mysql> select name from students where cls_id in (select id from classes);
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
| 凌小小       |
| 司马二狗     |
+--------------+
12 rows in set (0.00 sec)
'''
-- 查出classes所有的班级id
select id from classes;
'''
mysql> select id from classes;
+----+
| id |
+----+
|  1 |
|  2 |
|  8 |
+----+
3 rows in set (0.00 sec)
'''

-- 查出能够对应上班级号的学生信息
select * from students where(select id from classes);
'''
mysql> select * from students where students.cls_id in  (select id from classes)
;
+----+--------------+------+--------+--------+--------+----------------------+
| id | name         | age  | height | gender | cls_id | is_delete            |
+----+--------------+------+--------+--------+--------+----------------------+
|  1 | 小明         |   18 | 180.00 | 女     |      1 | 0x00                 |
|  2 | 小月月       |   18 | 180.00 | 女     |      2 | 0x01                 |
|  3 | 彭于晏       |   29 | 185.00 | 男     |      1 | 0x00                 |
|  4 | 刘德华       |   59 | 175.00 | 男     |      2 | 0x01                 |
|  5 | 黄蓉         |   38 | 160.00 | 女     |      1 | 0x00                 |
|  6 | 凤姐         |   28 | 150.00 | 保密   |      2 | 0x01                 |
|  7 | 王祖贤       |   18 | 172.00 | 女     |      1 | 0x01                 |
|  8 | 周杰伦       |   36 |   NULL | 男     |      1 | 0x00                 |
|  9 | 程坤         |   27 | 181.00 | 男     |      2 | 0x00                 |
| 10 | 刘亦菲       |   25 | 166.00 | 女     |      2 | 0x00                 |
| 15 | 凌小小       |   28 | 180.00 | 女     |      1 | 0x00                 |
| 16 | 司马二狗     |   28 | 120.00 | 男     |      1 | 0x00                 |
+----+--------------+------+--------+--------+--------+----------------------+
12 rows in set (0.01 sec)
'''