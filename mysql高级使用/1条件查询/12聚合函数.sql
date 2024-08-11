--12聚合函数
-- 学习本节可以理解为mysql中的内置函数，结合python来理解学习
'''
命令                作用
count(字段)        计算总行数
max(字段)		   求此字段的最大值
min(字段)			求此字段的最小值
sum(字段)		  求此字段之和
avg(字段)	      求此字段的平均值
'''				
-- 聚合函数的作用:聚合函数会把当前所在表当做一个组进行统计
'''
聚合函数有以下几个特点:
每个组函数接受一个参数(字段名或者表达式)
统计结果中默认忽略字段为NULL的记录
不允许出现嵌套 比如sum(max())
'''

-- 查询男性有多少人
select sum(gender='男') from students;
select count(*) from students where gender='男'; --也可以这样写
'''
mysql> select sum(gender='男') from students;
+-------------------+
| sum(gender='男')  |
+-------------------+
|                 6 |
+-------------------+
1 row in set (0.00 sec)
'''

-- 查询最大的年龄
select max(age) from students;
'''
mysql> select max(age) from students;
+----------+
| max(age) |
+----------+
|       59 |
+----------+
1 row in set (0.01 sec)
'''

-- 查询最矮的身高
select min(height) from students;
'''
mysql> select min(height) from students;
+-------------+
| min(height) |
+-------------+
|      120.00 |
+-------------+
1 row in set (0.00 sec)
'''

-- 计算所有人年龄的总和
select sum(age) from students;
'''
mysql> select sum(age) from students;
+----------+
| sum(age) |
+----------+
|      443 |
+----------+
1 row in set (0.00 sec)
'''

--求平均年龄
select avg(age) from students;
'''
mysql> select avg(age) from students;
+----------+
| avg(age) |
+----------+
|  27.6875 |
+----------+
1 row in set (0.00 sec)
'''

--四舍五入 round(123.23,1)保留一位小数
-- 计算所有人的平均年龄，保留两位小数
select round(avg(age),2) from students;
'''
mysql> select round(avg(age),2) from students;
+-------------------+
| round(avg(age),2) |
+-------------------+
|             27.69 |
+-------------------+
1 row in set (0.00 sec)
'''