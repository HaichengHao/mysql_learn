--14limit限制查询
'''
当数据表中的数据过多时，如果采用select * from 数据表
可能会直接给电脑干死机
譬如淘宝的用户数据表，要是采用select * from 淘宝用户数据表;真的会死机的
所有我们引出了limit 限制查询

limit 限制查询可以使用limit限制取出记录的数量，但limit要写在sql语句的最后

语法 limit 起始记录,记录数

说明:
	起始记录是指从第几条记录开始取，第一条记录的下标是0
	记录数是指从起始记录开始向后依次取的记录数

注意 可以使用limit限制取出记录的数量，但是limit要写在sql语句的最后
'''
--取students表中索引为10开始(即第11条数据)，取5个数
select * from students limit 10,5;
'''
mysql> select * from students limit 10,5;
+----+-----------+------+--------+--------+--------+----------------------+
| id | name      | age  | height | gender | cls_id | is_delete            |
+----+-----------+------+--------+--------+--------+----------------------+
| 11 | 金星      |   33 | 162.00 | 中性   |      3 | 0x01                 |
| 12 | 静香      |   12 | 180.00 | 女     |      4 | 0x00                 |
| 13 | 郭靖      |   12 | 170.00 | 男     |      4 | 0x00                 |
| 14 | 周杰      |   34 | 176.00 | 女     |      5 | 0x00                 |
| 15 | 凌小小    |   28 | 180.00 | 女     |      1 | 0x00                 |
+----+-----------+------+--------+--------+--------+----------------------+
5 rows in set (0.00 sec)
'''

-- 每页显示两个，第一个页面
select * from students limit 0,2;
-- 每页显示两个，第二个页面
select * from students limit 2,2;
-- 每页显示两个，第三个页面
select * from students limit 4,2;
-- 每页显示n个，第m个页面的计算limit 就是 limit (m-1)*n , n

-- 每页显示两个，显示第四页信息,按照年龄从小到大(即默认升序排序asc)排序
select * from students order by age asc limit 6,2;

'''
mysql> select * from students order by age limit 6,2;
+----+--------+------+--------+--------+--------+----------------------+
| id | name   | age  | height | gender | cls_id | is_delete            |
+----+--------+------+--------+--------+--------+----------------------+
|  9 | 程坤   |   27 | 181.00 | 男     |      2 | 0x00                 |
|  6 | 凤姐   |   28 | 150.00 | 保密   |      2 | 0x01                 |
+----+--------+------+--------+--------+--------+----------------------+
2 rows in set (0.00 sec)
'''