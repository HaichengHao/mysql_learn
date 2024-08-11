-- 11order排序查询

--语法: select * from 表名 order by 列1 asc|desc [,列2 asc|desc,....]
-- asc 表示升序排序，即从小到大，desc为降序排序，即从大到小，默认是asc

-- 按年龄默认升序查询姓名和年龄默认asc,即使不写也是默认asc
select s.name, s.age from students as s order by age;
'''
mysql> select s.name, s.age from students as s order by age;
+--------------+------+
| name         | age  |
+--------------+------+
| 静香         |   12 |
| 郭靖         |   12 |
| 小明         |   18 |
| 小月月       |   18 |
| 王祖贤       |   18 |
| 刘亦菲       |   25 |
| 程坤         |   27 |
| 凤姐         |   28 |
| 凌小小       |   28 |
| 司马二狗     |   28 |
| 彭于晏       |   29 |
| 金星         |   33 |
| 周杰         |   34 |
| 周杰伦       |   36 |
| 黄蓉         |   38 |
| 刘德华       |   59 |
+--------------+------+
16 rows in set (0.00 sec)
'''

-- 按年龄降序排序
select name,age from students order by age desc;
'''
mysql> select name,age from students order by age desc;
+--------------+------+
| name         | age  |
+--------------+------+
| 刘德华       |   59 |
| 黄蓉         |   38 |
| 周杰伦       |   36 |
| 周杰         |   34 |
| 金星         |   33 |
| 彭于晏       |   29 |
| 凤姐         |   28 |
| 凌小小       |   28 |
| 司马二狗     |   28 |
| 程坤         |   27 |
| 刘亦菲       |   25 |
| 小明         |   18 |
| 小月月       |   18 |
| 王祖贤       |   18 |
| 静香         |   12 |
| 郭靖         |   12 |
+--------------+------+
16 rows in set (0.00 sec)
'''

-- 选择年龄在18到34岁的男性，身高从矮到高排序
select * from students where gender='男' and  age between 18 and 34 order by height;
'''
mysql> select * from students where gender='男' and  age between 18 and 34 order by height;
+----+--------------+------+--------+--------+--------+----------------------+
| id | name         | age  | height | gender | cls_id | is_delete            |
+----+--------------+------+--------+--------+--------+----------------------+
| 16 | 司马二狗     |   28 | 120.00 | 男     |      1 | 0x00                 |
|  9 | 程坤         |   27 | 181.00 | 男     |      2 | 0x00                 |
|  3 | 彭于晏       |   29 | 185.00 | 男     |      1 | 0x00                 |
+----+--------------+------+--------+--------+--------+----------------------+
3 rows in set (0.00 sec)
'''

-- 查询年龄在18-34岁之间的女性，身高从高到矮降序排序(desc)
select s.name, s.age, s.height from students as s where gender='女' and age between 18 and 34 order by height desc;
-- 也可以这样写
select s.name s.age s.height from students as s where (age between 18 and 34) and gender='女'order by height desc;
'''
mysql> select s.name, s.age, s.height from students as s where gender='女' and age between 18 and 34 order by height desc;
+-----------+------+--------+
| name      | age  | height |
+-----------+------+--------+
| 小明      |   18 | 180.00 |
| 小月月    |   18 | 180.00 |
| 凌小小    |   28 | 180.00 |
| 周杰      |   34 | 176.00 |
| 王祖贤    |   18 | 172.00 |
| 刘亦菲    |   25 | 166.00 |
+-----------+------+--------+
6 rows in set (0.00 sec)

'''

--多字段查询
--查询年龄在18-34岁之间的女性，身高从高到矮排序，如果身高相同的情况下按照年龄从大到小排序
select * from students where gender='女' and age between 18 and 34 order by height desc , age desc;
'''
mysql> select * from students where gender='女' and age between 18 and 34 order by height desc , age desc;
+----+-----------+------+--------+--------+--------+----------------------+
| id | name      | age  | height | gender | cls_id | is_delete            |
+----+-----------+------+--------+--------+--------+----------------------+
| 15 | 凌小小    |   28 | 180.00 | 女     |      1 | 0x00                 |
|  1 | 小明      |   18 | 180.00 | 女     |      1 | 0x00                 |
|  2 | 小月月    |   18 | 180.00 | 女     |      2 | 0x01                 |
| 14 | 周杰      |   34 | 176.00 | 女     |      5 | 0x00                 |
|  7 | 王祖贤    |   18 | 172.00 | 女     |      1 | 0x01                 |
| 10 | 刘亦菲    |   25 | 166.00 | 女     |      2 | 0x00                 |
+----+-----------+------+--------+--------+--------+----------------------+
6 rows in set (0.00 sec)
'''
