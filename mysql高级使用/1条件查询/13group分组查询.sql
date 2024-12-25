-- 13group分组查询
'''
什么是分组？
所谓的分组就是将一个数据集划分成若干个小区域，然后针对若干个小区域进行数据处理
group by 分组
	使用特点
	group by的含义:将查询结果按照1个或多个字段进行分组，字段值相同的为一组
	group by可用于单个字段分组，也可用于多个字段分组

'''

--按照性别分组，查询所有的性别
select gender from students group by gender;
'''
mysql> select gender from students group by gender;
+--------+
| gender |
+--------+
| 女     |
| 男     |
| 保密   |
| 中性   |
+--------+
4 rows in set (0.01 sec)
'''

--计算每个性别的人数
select gender,count(gender) from students group by gender;
'''
mysql> select gender,count(gender) from students group by gender;
+--------+---------------+
| gender | count(gender) |
+--------+---------------+
| 女     |             8 |
| 男     |             6 |
| 保密   |             1 |
| 中性   |             1 |
+--------+---------------+
4 rows in set (0.00 sec)
'''

-- group_concat(...) 在分组查询中可以用来表示一组字段的内容
-- 查询同种性别中的姓名
select gender,count(gender),group_concat(name) from students group by gender;
'''
mysql> select gender,count(gender),group_concat(name) from students group by gender;
+--------+---------------+---------------------------------------------------------------------+
| gender | count(gender) | group_concat(name)                                                  |
+--------+---------------+---------------------------------------------------------------------+
| 男     |             6 | 彭于晏,刘德华,周杰伦,程坤,郭靖,司马二狗                             |
| 女     |             8 | 小明,小月月,黄蓉,王祖贤,刘亦菲,静香,周杰,凌小小                     |
| 中性   |             1 | 金星                                                                |
| 保密   |             1 | 凤姐                                                                |
+--------+---------------+---------------------------------------------------------------------+
'''

--查询每组性别的平均年龄
select gender,avg(age) from students group by gender;
'''
mysql> select gender,avg(age) from students group by gender;
+--------+----------+
| gender | avg(age) |
+--------+----------+
| 女     |  23.8750 |
| 男     |  31.8333 |
| 保密   |  28.0000 |
| 中性   |  33.0000 |
+--------+----------+
'''

--having(重点)
-- having与where的区别:
-- having是在分组后对数据进行过滤
-- where是在分组前对数据进行过滤
-- having后面可以使用聚合函数
-- where后面不可以使用聚合
-- 查询平均年龄超过38岁的性别，以及姓名
select gender,group_concat(name) from students group by gender having avg(age)>30;
'''
mysql> select gender,group_concat(name) from students group by gender having avg(age)>30;
+--------+----------------------------------------------------------+
| gender | group_concat(name)                                       |
+--------+----------------------------------------------------------+
| 男     | 彭于晏,刘德华,周杰伦,程坤,郭靖,司马二狗                  |
| 中性   | 金星                                                     |
+--------+----------------------------------------------------------+
2 rows in set (0.00 sec)
'''
-- 查询平均高度大于150的性别以及姓名
select group_concat(name),height from students group by height having avg(height)>150;
'''
mysql> select group_concat(name),height from students group by height having avg(height)>150;
+-----------------------------------+--------+
| group_concat(name)                | height |
+-----------------------------------+--------+
| 黄蓉                              | 160.00 |
| 金星                              | 162.00 |
| 刘亦菲                            | 166.00 |
| 郭靖                              | 170.00 |
| 王祖贤                            | 172.00 |
| 刘德华                            | 175.00 |
| 周杰                              | 176.00 |
| 小明,小月月,静香,凌小小           | 180.00 |
| 程坤                              | 181.00 |
| 彭于晏                            | 185.00 |
+-----------------------------------+--------+
10 rows in set (0.00 sec)
'''




--with rollup 汇总的作用(了解)
select gender,count(gender) from students group by gender with rollup;
'''
mysql> select gender,count(gender) from students group by gender with rollup;
+--------+---------------+
| gender | count(gender) |
+--------+---------------+
| 男     |             6 |
| 女     |             8 |
| 中性   |             1 |
| 保密   |             1 |
| NULL   |            16 |
+--------+---------------+
5 rows in set (0.00 sec)

mysql> 
'''