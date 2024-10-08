--07where之逻辑运算符查询
'''
and 表示多个条件时，必须同时成立
or 表示多个条件时，满足任意一个即可
not 表示取反操作
'''
select * from students where gender='女' and age>20;
'''
mysql> select * from students where gender='女' and age>20;
+----+-----------+------+--------+--------+--------+----------------------+
| id | name      | age  | height | gender | cls_id | is_delete            |
+----+-----------+------+--------+--------+--------+----------------------+
|  5 | 黄蓉      |   38 | 160.00 | 女     |      1 | 0x00                 |
| 10 | 刘亦菲    |   25 | 166.00 | 女     |      2 | 0x00                 |
| 14 | 周杰      |   34 | 176.00 | 女     |      5 | 0x00                 |
| 15 | 凌小小    |   28 | 180.00 | 女     |      1 | 0x00                 |
+----+-----------+------+--------+--------+--------+----------------------+
4 rows in set (0.00 sec)

'''

-- 选择年龄为18岁或身高小于170的
select * from students where age=18 or height<170;
'''
mysql> select * from students where age=18 or height<170;
+----+--------------+------+--------+--------+--------+----------------------+
| id | name         | age  | height | gender | cls_id | is_delete            |
+----+--------------+------+--------+--------+--------+----------------------+
|  1 | 小明         |   18 | 180.00 | 女     |      1 | 0x00                 |
|  2 | 小月月       |   18 | 180.00 | 女     |      2 | 0x01                 |
|  5 | 黄蓉         |   38 | 160.00 | 女     |      1 | 0x00                 |
|  6 | 凤姐         |   28 | 150.00 | 保密   |      2 | 0x01                 |
|  7 | 王祖贤       |   18 | 172.00 | 女     |      1 | 0x01                 |
| 10 | 刘亦菲       |   25 | 166.00 | 女     |      2 | 0x00                 |
| 11 | 金星         |   33 | 162.00 | 中性   |      3 | 0x01                 |
| 16 | 司马二狗     |   28 | 120.00 | 男     |      1 | 0x00                 |
+----+--------------+------+--------+--------+--------+----------------------+
8 rows in set (0.00 sec)
'''

-- 取反操作，选择不是男性也不是女性的人
select * from students where not (gender='男' or gender='女');
'''
mysql> select * from students where not (gender='男' or gender='女');
+----+--------+------+--------+--------+--------+----------------------+
| id | name   | age  | height | gender | cls_id | is_delete            |
+----+--------+------+--------+--------+--------+----------------------+
|  6 | 凤姐   |   28 | 150.00 | 保密   |      2 | 0x01                 |
| 11 | 金星   |   33 | 162.00 | 中性   |      3 | 0x01                 |
+----+--------+------+--------+--------+--------+----------------------+
2 rows in set (0.00 sec)
'''