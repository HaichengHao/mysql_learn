--21外键的使用
'''
什么是外键？
一个表的主键a在另一个表b中出现，我们就说a是表b的一个外键
增加外键起始就是给表结构新增了一个字段

外键的作用 防止无效信息的插入

注意 关键字 foreign key 只有 InnoDB 数据库引擎
外键本身也是一种约束，和not null 等约束一样


删除外键首先需要知道外键约束的名字
show create table 表名;
然后可以看到外键的名字
只需要像修改表结构的删除字段那样删除就可以了
alter table 表名 drop foreign key 外键名称;

注意，使用外键会极大降低表更新的效率，所以在追求读写效率优先的场景下一般很少使用外键约束
'''
-- 向goods表里插入任意一条数据
insert into goods (name,cate_id,brand_id,price) values ('老王牌拖拉机',10,10,'6666');

--查看插入是否成功，插入成功，我们其实插入的是一条错位的信息，根本就没有cate_id为10的种类，brand_id也没有10这个种类
--为了避免出现错误的数据插入数据表的情况，我们这里就需要引入一个东西，叫做外键
select * from goods where name like '老王%';
'''
mysql> select * from goods where name like '老王%';
+----+--------------------+---------+----------+----------+------------------+------------------------+
| id | name               | cate_id | brand_id | price    | is_show          | is_saleoff             |
+----+--------------------+---------+----------+----------+------------------+------------------------+
| 22 | 老王牌拖拉机       |      10 |       10 | 6666.000 | 0x01             | 0x00                   |
+----+--------------------+---------+----------+----------+------------------+------------------------+
1 row in set (0.00 sec)
'''

--注意由于本节中用到的good_brands自己并没有这一节的课程，上一节中根据推断我创建了brands表，其实就是good_brands这个表，首先需要修改一下表名，把我的brands表修改为good_brands'''
rename table brands to goods_brands;
--约束数据的插入使用外键 foreign key,这样可以达到一种效果，让goods_cates的id与goods中的cate_id进行一一对应
--涉及到修改表的结构 references意思是参考与,指代为的含义
alter table goods add foreign key(cate_id) references goods_cates(id); --这样，goods_cates表中的主键id字段就成了goods表的外键
alter table goods add foreign key(brand_id) references goods_brands(id); -- 这样，goods_brands表中的主键id字段就成了goods表的外键

'''
注意，上面两行添加外键约束是会报错的，因为我们最开始的时候插入了一条错误的数据老王牌拖拉机，所以mysql就检测到了不能添加外键，所以我们需要先将错误的数据删除
delete from goods where name="老王牌拖拉机";
	删除完之后再次进行添加外键的操作
'''




--如何取消外键约束
--1需要先获取外键约束的名称
show create table goods;
'''
---------+
| goods | CREATE TABLE `goods` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `cate_id` int unsigned NOT NULL,
  `brand_id` int unsigned NOT NULL,
  `price` decimal(10,3) NOT NULL DEFAULT '0.000',
  `is_show` bit(1) NOT NULL DEFAULT b'1',
  `is_saleoff` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  KEY `cate_id` (`cate_id`),   
  KEY `brand_id` (`brand_id`),
  CONSTRAINT `goods_ibfk_1` FOREIGN KEY (`cate_id`) REFERENCES `goods_cates` (`id`), <--这里就可以看到我们添加了外键约束
  CONSTRAINT `goods_ibfk_2` FOREIGN KEY (`brand_id`) REFERENCES `goods_brands` (`id`) <--这张goods表有俩外键约束
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3 |
'''

-- 2 删除外键约束起始就是就是删除外键约束的字段,注意 后面的字段名是上面查到的外键约束的名称
alter table goods drop foreign key goods_ibfk_1;
alter table goods drop foreign key goods_ibfk_2;

--取消外键执行完之后再次查看数据表
show create table goods;
'''
| goods | CREATE TABLE `goods` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `cate_id` int unsigned NOT NULL,
  `brand_id` int unsigned NOT NULL,
  `price` decimal(10,3) NOT NULL DEFAULT '0.000',
  `is_show` bit(1) NOT NULL DEFAULT b'1',
  `is_saleoff` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  KEY `cate_id` (`cate_id`),
  KEY `brand_id` (`brand_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3 |
'''


-- 拓展 创建数据表的时候也可以增加外键约束
create table goods(
id int primary key auto_increment not null,
name varchar(40) default '',
price decimal(5,2),cate_id --超过5位保留两位
cate_id int unsigned,
brand_id int unsigned,
is_show bit default 1,
is_saleoff bit default 0,
foreign key(cate_id) references goods_cates(id),
foreign key(brand_id) references goods_brands(id)
)