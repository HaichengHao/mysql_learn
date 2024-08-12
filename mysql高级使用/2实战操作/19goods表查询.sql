--19goods表查询

--查询类型cate_name为"超极本"的商品名称
select name from goods where cate_name="超极本";


--显示商品的种类
-- 分组的方式(group by)
select cate_name,count(cate_name) from goods group by cate_name;

'''
mysql> select cate_name,count(cate_name) from goods group by cate_name;
+---------------------+------------------+
| cate_name           | count(cate_name) |
+---------------------+------------------+
| 笔记本              |                3 |
| 游戏本              |                1 |
| 超级本              |                3 |
| 平板电脑            |                3 |
| 台式机              |                4 |
| 服务器/工作站       |                4 |
| 笔记本配件          |                3 |
+---------------------+------------------+
7 rows in set (0.09 sec)
'''

-- 去重的方式(distinct 字段名)
select distinct name from goods;
'''
mysql> select distinct name from goods;
+---------------------------------------+
| name                                  |
+---------------------------------------+
| r510vc 15.6英寸笔记本                 |
| y400n 14.0英寸笔记本电脑              |
| g150th 15.6英寸游戏本                 |
| x550cc 15.6英寸笔记本                 |
| x240 超极本                           |
| u330p 13.3英寸超极本                  |
| svp13226scb 触控超极本                |
| ipad mini 7.9英寸平板电脑             |
| ipad air 9.7英寸平板电脑              |
| ipad mini 配备 retina 显示屏          |
| ideacentre c340 20英寸一体电脑        |
| vostro 3800-r1206 台式电脑            |
| imac me086ch/a 21.5英寸一体电脑       |
| at7-7414lp 台式电脑 linux ）          |
| z220sff f4f06pa工作站                 |
| poweredge ii服务器                    |
| mac pro专业级台式电脑                 |
| hmz-t3w 头戴显示设备                  |
| 商务双肩背包                          |
| x3250 m4机架式服务器                  |
+---------------------------------------+
20 rows in set (0.00 sec)
'''

--所有电脑产品的平均价格并保留两位小数
select round(avg(price),2) from goods;
'''

mysql> select round(avg(price),2) from goods;
+---------------------+
| round(avg(price),2) |
+---------------------+
|             5570.57 |
+---------------------+
1 row in set (0.00 sec)
'''

--显示每种类型(cate_name)的平均价格
select cate_name,avg(price) from goods group by cate_name;

'''
mysql> select cate_name,avg(price) from goods group by cate_name;
+---------------------+---------------+
| cate_name           | avg(price)    |
+---------------------+---------------+
| 笔记本              |  3732.3333333 |
| 游戏本              |  8499.0000000 |
| 超级本              |  5726.0000000 |
| 平板电脑            |  2724.6666667 |
| 台式机              |  4821.2500000 |
| 服务器/工作站       | 11363.0000000 |
| 笔记本配件          |  2399.0000000 |
+---------------------+---------------+
7 rows in set (0.00 sec)
'''

--查询每种类型的商品中 最贵（利用max） 最便宜(利用min) 平均价(利用avg) 数量(利用count)
select cate_name, max(price),min(price),avg(price),count(cate_name) from goods group by cate_name;
'''
mysql> select cate_name, max(price),min(price),avg(price),count(cate_name) from goods group by cate_name
;
+---------------------+------------+------------+---------------+------------------+
| cate_name           | max(price) | min(price) | avg(price)    | count(cate_name) |
+---------------------+------------+------------+---------------+------------------+
| 笔记本              |   4999.000 |   2799.000 |  3732.3333333 |                3 |
| 游戏本              |   8499.000 |   8499.000 |  8499.0000000 |                1 |
| 超级本              |   7999.000 |   4299.000 |  5726.0000000 |                3 |
| 平板电脑            |   3388.000 |   1998.000 |  2724.6666667 |                3 |
| 台式机              |   9188.000 |   2899.000 |  4821.2500000 |                4 |
| 服务器/工作站       |  28888.000 |   4288.000 | 11363.0000000 |                4 |
| 笔记本配件          |   6999.000 |     99.000 |  2399.0000000 |                3 |
+---------------------+------------+------------+---------------+------------------+
7 rows in set (0.00 sec)
'''


--查询所有价格大于平均价格的商品，并按照降序排序(order by 字段 desc)
select name,price from goods where price>
--1查询平均价格
select avg(price) from goods;

--2使用子查询查询出价格大于平均价格的商品
select name,price from goods where price>(select avg(price) from goods);
'''
mysql> select name,price from goods where price>(select avg(price) from goods);
+---------------------------------------+-----------+
| name                                  | price     |
+---------------------------------------+-----------+
| g150th 15.6英寸游戏本                 |  8499.000 |
| svp13226scb 触控超极本                |  7999.000 |
| imac me086ch/a 21.5英寸一体电脑       |  9188.000 |
| mac pro专业级台式电脑                 | 28888.000 |
| hmz-t3w 头戴显示设备                  |  6999.000 |
| x3250 m4机架式服务器                  |  6888.000 |
+---------------------------------------+-----------+
6 rows in set (0.00 sec)

'''
--3利用order by降序排序
select name,price from goods where price>(select avg(price) from goods) order by price desc;
'''
mysql> select name,price from goods where price>(select avg(price) from goods) order by price desc;
+---------------------------------------+-----------+
| name                                  | price     |
+---------------------------------------+-----------+
| mac pro专业级台式电脑                 | 28888.000 |
| imac me086ch/a 21.5英寸一体电脑       |  9188.000 |
| g150th 15.6英寸游戏本                 |  8499.000 |
| svp13226scb 触控超极本                |  7999.000 |
| hmz-t3w 头戴显示设备                  |  6999.000 |
| x3250 m4机架式服务器                  |  6888.000 |
+---------------------------------------+-----------+
6 rows in set (0.00 sec)
'''

--查询每种类型中最贵的电脑的信息
--1 查找每种类型中最贵的电脑的价格
select cate_name,max(price) from goods group by cate_name;
'''
mysql> select cate_name,max(price) from goods group by cate_name;
+---------------------+------------+
| cate_name           | max(price) |
+---------------------+------------+
| 笔记本              |   4999.000 |
| 游戏本              |   8499.000 |
| 超级本              |   7999.000 |
| 平板电脑            |   3388.000 |
| 台式机              |   9188.000 |
| 服务器/工作站       |  28888.000 |
| 笔记本配件          |   6999.000 |
+---------------------+------------+
7 rows in set (0.00 sec)
'''
-- 2 关联查询 inner join 每种类型 中最贵的物品信息
select * from goods
inner join 
(select cate_name,max(price) as max_price from goods group by cate_name) as max_price_goods
on goods.cate_name=max_price_goods.cate_name and goods.price = max_price_goods.max_price;

-- 让 goods 表内连接与 新表 max_price_goods(这个新表是由类型名和最高价格组成)
-- on 后面跟的条件是如果goods表中的类型名与max_price_goods的类型名相同 并且 goods表中的价格和max_price_goods的价格一致
-- 则返回查询结果
'''
mysql> select * from goods
    -> inner join 
    -> (select cate_name,max(price) as max_price from goods group by cate_name) as max_price_goods
    -> on goods.cate_name=max_price_goods.cate_name and goods.price = max_price_goods.max_price;
+----+---------------------------------------+---------------------+------------+-----------+------------------+------------------------+---------------------+-----------+
| id | name                                  | cate_name           | brand_name | price     | is_show          | is_saleoff             | cate_name           | max_price |
+----+---------------------------------------+---------------------+------------+-----------+------------------+------------------------+---------------------+-----------+
|  2 | y400n 14.0英寸笔记本电脑              | 笔记本              | 联想       |  4999.000 | 0x01             | 0x00                   | 笔记本              |  4999.000 |
|  3 | g150th 15.6英寸游戏本                 | 游戏本              | 雷神       |  8499.000 | 0x01             | 0x00                   | 游戏本              |  8499.000 |
|  7 | svp13226scb 触控超极本                | 超级本              | 索尼       |  7999.000 | 0x01             | 0x00                   | 超级本              |  7999.000 |
|  9 | ipad air 9.7英寸平板电脑              | 平板电脑            | 苹果       |  3388.000 | 0x01             | 0x00                   | 平板电脑            |  3388.000 |
| 13 | imac me086ch/a 21.5英寸一体电脑       | 台式机              | 苹果       |  9188.000 | 0x01             | 0x00                   | 台式机              |  9188.000 |
| 17 | mac pro专业级台式电脑                 | 服务器/工作站       | 苹果       | 28888.000 | 0x01             | 0x00                   | 服务器/工作站       | 28888.000 |
| 18 | hmz-t3w 头戴显示设备                  | 笔记本配件          | 索尼       |  6999.000 | 0x01             | 0x00                   | 笔记本配件          |  6999.000 |
+----+---------------------------------------+---------------------+------------+-----------+------------------+------------------------+---------------------+-----------+
7 rows in set (0.00 sec)
'''

