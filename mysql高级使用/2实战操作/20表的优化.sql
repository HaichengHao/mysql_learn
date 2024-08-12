--20表的优化
'''
删除异常:
由于只存在商品信息一张表，其中既有商品信息又有分类名称和品牌名称。当把某个
商品信息删除后，本不应该删除的<独立于商品信息的分类和品牌等>信息结果也随着删除商品信息而被删除
那么此时存在删除异常

如果我们创建两张表 商品种类表 和商品品牌表 存储对应的信息就不会出现异常了

'''
'''
优化步骤
1 创建商品种类表
2 同步数据到商品种类表当中
3 更新商品信息表数据
4 修改商品信息表表结构

'''

-- 第一步 创建表(商品种类表)
create table if not exists goods_cates(
id int unsigned primary key auto_increment,
name varchar(40) not null
);

-- 第二步 同步 商品分类表数据 将商品的所有种类信息写入到商品种类表中
-- 1按照分组的方式查询goods表中所有的种类(cate_name)
select cate_name from goods group by cate_name;
--2 利用子查询，将查询获得的结果插入到新的表中的name字段当中
--注意，当我们把查询的结果一次性插入字段中时是不需要加values的
insert into goods_cates(name)(select cate_name from goods group by cate_name);
'''
mysql> select * from goods_cates;
+----+---------------------+
| id | name                |
+----+---------------------+
|  1 | 笔记本              |
|  2 | 游戏本              |
|  3 | 超级本              |
|  4 | 平板电脑            |
|  5 | 台式机              |
|  6 | 服务器/工作站       |
|  7 | 笔记本配件          |
+----+---------------------+
7 rows in set (0.00 sec)
'''



--第三步 同步商品表数据，通过goods_cates 数据来更新goods表
-- 1因为要通过goods_cates表更新goods表，所以要把两个表连接起来
select * from goods inner join goods_cates on goods.cate_name=goods_cates.name;
'''
mysql> select * from goods inner join goods_cates on goods.cate_name=goods_cates.name;
+----+---------------------------------------+---------------------+------------+-----------+------------------+------------------------+----+---------------------+
| id | name                                  | cate_name           | brand_name | price     | is_show          | is_saleoff             | id | name                |
+----+---------------------------------------+---------------------+------------+-----------+------------------+------------------------+----+---------------------+
|  1 | r510vc 15.6英寸笔记本                 | 笔记本              | 华硕       |  3399.000 | 0x01             | 0x00                   |  1 | 笔记本              |
|  2 | y400n 14.0英寸笔记本电脑              | 笔记本              | 联想       |  4999.000 | 0x01             | 0x00                   |  1 | 笔记本              |
|  3 | g150th 15.6英寸游戏本                 | 游戏本              | 雷神       |  8499.000 | 0x01             | 0x00                   |  2 | 游戏本              |
|  4 | x550cc 15.6英寸笔记本                 | 笔记本              | 华硕       |  2799.000 | 0x01             | 0x00                   |  1 | 笔记本              |
|  5 | x240 超极本                           | 超级本              | 联想       |  4880.000 | 0x01             | 0x00                   |  3 | 超级本              |
|  6 | u330p 13.3英寸超极本                  | 超级本              | 联想       |  4299.000 | 0x01             | 0x00                   |  3 | 超级本              |
|  7 | svp13226scb 触控超极本                | 超级本              | 索尼       |  7999.000 | 0x01             | 0x00                   |  3 | 超级本              |
|  8 | ipad mini 7.9英寸平板电脑             | 平板电脑            | 苹果       |  1998.000 | 0x01             | 0x00                   |  4 | 平板电脑            |
|  9 | ipad air 9.7英寸平板电脑              | 平板电脑            | 苹果       |  3388.000 | 0x01             | 0x00                   |  4 | 平板电脑            |
| 10 | ipad mini 配备 retina 显示屏          | 平板电脑            | 苹果       |  2788.000 | 0x01             | 0x00                   |  4 | 平板电脑            |
| 11 | ideacentre c340 20英寸一体电脑        | 台式机              | 联想       |  3499.000 | 0x01             | 0x00                   |  5 | 台式机              |
| 12 | vostro 3800-r1206 台式电脑            | 台式机              | 戴尔       |  2899.000 | 0x01             | 0x00                   |  5 | 台式机              |
| 13 | imac me086ch/a 21.5英寸一体电脑       | 台式机              | 苹果       |  9188.000 | 0x01             | 0x00                   |  5 | 台式机              |
| 14 | at7-7414lp 台式电脑 linux ）          | 台式机              | 宏碁       |  3699.000 | 0x01             | 0x00                   |  5 | 台式机              |
| 15 | z220sff f4f06pa工作站                 | 服务器/工作站       | 惠普       |  4288.000 | 0x01             | 0x00                   |  6 | 服务器/工作站       |
| 16 | poweredge ii服务器                    | 服务器/工作站       | 戴尔       |  5388.000 | 0x01             | 0x00                   |  6 | 服务器/工作站       |
| 17 | mac pro专业级台式电脑                 | 服务器/工作站       | 苹果       | 28888.000 | 0x01             | 0x00                   |  6 | 服务器/工作站       |
| 18 | hmz-t3w 头戴显示设备                  | 笔记本配件          | 索尼       |  6999.000 | 0x01             | 0x00                   |  7 | 笔记本配件          |
| 19 | 商务双肩背包                          | 笔记本配件          | 索尼       |    99.000 | 0x01             | 0x00                   |  7 | 笔记本配件          |
| 20 | x3250 m4机架式服务器                  | 服务器/工作站       | ibm        |  6888.000 | 0x01             | 0x00                   |  6 | 服务器/工作站       |
| 21 | 商务双肩背包                          | 笔记本配件          | 索尼       |    99.000 | 0x01             | 0x00                   |  7 | 笔记本配件          |
+----+---------------------------------------+---------------------+------------+-----------+------------------+------------------------+----+---------------------+
'''
--2把内连接的商品表中的goods表中的cate_name 全部替换成商品分类goods_cates表中的商品id(update ... set)
update (goods inner join goods_cates on goods.cate_name=goods_cates.name)  set goods.cate_name = goods_cates.id; 
--3查看更新后的结果
'''
+----+---------------------------------------+-----------+------------+-----------+------------------+------------------------+
| id | name                                  | cate_name | brand_name | price     | is_show          | is_saleoff             |
+----+---------------------------------------+-----------+------------+-----------+------------------+------------------------+
|  1 | r510vc 15.6英寸笔记本                 | 1         | 华硕       |  3399.000 | 0x01             | 0x00                   |
|  2 | y400n 14.0英寸笔记本电脑              | 1         | 联想       |  4999.000 | 0x01             | 0x00                   |
|  3 | g150th 15.6英寸游戏本                 | 2         | 雷神       |  8499.000 | 0x01             | 0x00                   |
|  4 | x550cc 15.6英寸笔记本                 | 1         | 华硕       |  2799.000 | 0x01             | 0x00                   |
|  5 | x240 超极本                           | 3         | 联想       |  4880.000 | 0x01             | 0x00                   |
|  6 | u330p 13.3英寸超极本                  | 3         | 联想       |  4299.000 | 0x01             | 0x00                   |
|  7 | svp13226scb 触控超极本                | 3         | 索尼       |  7999.000 | 0x01             | 0x00                   |
|  8 | ipad mini 7.9英寸平板电脑             | 4         | 苹果       |  1998.000 | 0x01             | 0x00                   |
|  9 | ipad air 9.7英寸平板电脑              | 4         | 苹果       |  3388.000 | 0x01             | 0x00                   |
| 10 | ipad mini 配备 retina 显示屏          | 4         | 苹果       |  2788.000 | 0x01             | 0x00                   |
| 11 | ideacentre c340 20英寸一体电脑        | 5         | 联想       |  3499.000 | 0x01             | 0x00                   |
| 12 | vostro 3800-r1206 台式电脑            | 5         | 戴尔       |  2899.000 | 0x01             | 0x00                   |
| 13 | imac me086ch/a 21.5英寸一体电脑       | 5         | 苹果       |  9188.000 | 0x01             | 0x00                   |
| 14 | at7-7414lp 台式电脑 linux ）          | 5         | 宏碁       |  3699.000 | 0x01             | 0x00                   |
| 15 | z220sff f4f06pa工作站                 | 6         | 惠普       |  4288.000 | 0x01             | 0x00                   |
| 16 | poweredge ii服务器                    | 6         | 戴尔       |  5388.000 | 0x01             | 0x00                   |
| 17 | mac pro专业级台式电脑                 | 6         | 苹果       | 28888.000 | 0x01             | 0x00                   |
| 18 | hmz-t3w 头戴显示设备                  | 7         | 索尼       |  6999.000 | 0x01             | 0x00                   |
| 19 | 商务双肩背包                          | 7         | 索尼       |    99.000 | 0x01             | 0x00                   |
| 20 | x3250 m4机架式服务器                  | 6         | ibm        |  6888.000 | 0x01             | 0x00                   |
| 21 | 商务双肩背包                          | 7         | 索尼       |    99.000 | 0x01             | 0x00                   |
+----+---------------------------------------+-----------+------------+-----------+------------------+------------------------+
21 rows in set (0.00 sec)
'''
--可以发现cate_name确实已经成为了goods_cates表中的id值




--第四步 修改表的结构
-- 查看表结构(注意，两个表中的外连接的类型一定要一致)
desc goods
'''
mysql> desc goods;
+------------+---------------+------+-----+---------+----------------+
| Field      | Type          | Null | Key | Default | Extra          |
+------------+---------------+------+-----+---------+----------------+
| id         | int unsigned  | NO   | PRI | NULL    | auto_increment |
| name       | varchar(150)  | NO   |     | NULL    |                |
| cate_name  | varchar(40)   | NO   |     | NULL    |                |
| brand_name | varchar(40)   | NO   |     | NULL    |                |
| price      | decimal(10,3) | NO   |     | 0.000   |                |
| is_show    | bit(1)        | NO   |     | b'1'    |                |
| is_saleoff | bit(1)        | NO   |     | b'0'    |                |
+------------+---------------+------+-----+---------+----------------+
7 rows in set (0.00 sec)
'''
--修改表结构 alter table 表名 change 旧字段名 新字段名 ，把cate_name 改成 cate_id int unsigned not null;
alter table goods change cate_name cate_id int unsigned not null;

--修改后再次查看表结构，发现cate_name已经转换为cate_id
'''
mysql> desc goods;
+------------+---------------+------+-----+---------+----------------+
| Field      | Type          | Null | Key | Default | Extra          |
+------------+---------------+------+-----+---------+----------------+
| id         | int unsigned  | NO   | PRI | NULL    | auto_increment |
| name       | varchar(150)  | NO   |     | NULL    |                |
| cate_id    | int unsigned  | NO   |     | NULL    |                |
| brand_name | varchar(40)   | NO   |     | NULL    |                |
| price      | decimal(10,3) | NO   |     | 0.000   |                |
| is_show    | bit(1)        | NO   |     | b'1'    |                |
| is_saleoff | bit(1)        | NO   |     | b'0'    |                |
+------------+---------------+------+-----+---------+----------------+
7 rows in set (0.00 sec)
'''

'''
知识要点
将查询的数据直接插入字段中，注意是字段中
insert into 字段名 select语句 将select 语句的结果集插入到一个表中

连表跟新
update 表1 join 表2 on 连接条件 set 某表.字段 = 值