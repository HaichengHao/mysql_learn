--16连接查询_外连接
'''
左(外)连接查询:查询的结果为两个表匹配到的数据和左表特有的数据
注意:对于右表中不存在的数据使用null填充
即A|B-B 其中(B-A交B)的部分用空值填充

在15内连接中我们连接两张表后起始如果students表并不会显示出未能与classes匹配的数据，但是
使用left join实际上左边表的所有数据都会显示出来，即使没有匹配对应的信息


右(外)连接查询把左连接的右左互换即可
'''
'''
外连接语法
左外连: 主表 left join 从表 on 连接条件;
右外连: 从表 right join 主表 on 连接条件;

注意:能够使用连接的前提是，多表之间有字段关联
	左连接和右连接区别在于主表在sql语句中的位置，因此实际左连接就可以满足常见需求
'''

select * from students left  join classes on students.cls_id=classes.id;
'''
mysql> select * from students left  join classes on students.cls_id=classes.id;
+----+--------------+------+--------+--------+--------+----------------------+------+--------------+
| id | name         | age  | height | gender | cls_id | is_delete            | id   | name         |
+----+--------------+------+--------+--------+--------+----------------------+------+--------------+
|  1 | 小明         |   18 | 180.00 | 女     |      1 | 0x00                 |    1 | python_01期  |
|  2 | 小月月       |   18 | 180.00 | 女     |      2 | 0x01                 |    2 | python_02期  |
|  3 | 彭于晏       |   29 | 185.00 | 男     |      1 | 0x00                 |    1 | python_01期  |
|  4 | 刘德华       |   59 | 175.00 | 男     |      2 | 0x01                 |    2 | python_02期  |
|  5 | 黄蓉         |   38 | 160.00 | 女     |      1 | 0x00                 |    1 | python_01期  |
|  6 | 凤姐         |   28 | 150.00 | 保密   |      2 | 0x01                 |    2 | python_02期  |
|  7 | 王祖贤       |   18 | 172.00 | 女     |      1 | 0x01                 |    1 | python_01期  |
|  8 | 周杰伦       |   36 |   NULL | 男     |      1 | 0x00                 |    1 | python_01期  |
|  9 | 程坤         |   27 | 181.00 | 男     |      2 | 0x00                 |    2 | python_02期  |
| 10 | 刘亦菲       |   25 | 166.00 | 女     |      2 | 0x00                 |    2 | python_02期  |
| 11 | 金星         |   33 | 162.00 | 中性   |      3 | 0x01                 | NULL | NULL         |
| 12 | 静香         |   12 | 180.00 | 女     |      4 | 0x00                 | NULL | NULL         |
| 13 | 郭靖         |   12 | 170.00 | 男     |      4 | 0x00                 | NULL | NULL         |
| 14 | 周杰         |   34 | 176.00 | 女     |      5 | 0x00                 | NULL | NULL         |
| 15 | 凌小小       |   28 | 180.00 | 女     |      1 | 0x00                 |    1 | python_01期  |
| 16 | 司马二狗     |   28 | 120.00 | 男     |      1 | 0x00                 |    1 | python_01期  |
+----+--------------+------+--------+--------+--------+----------------------+------+--------------+
16 rows in set (0.00 sec)
''' 
--从上表中可以看到金星、静香、郭靖、周杰这些人虽然没有匹配到班级，但是也显示出来了，这就是和内连接不同的地方