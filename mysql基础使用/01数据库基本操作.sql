'''DDL（数据定义语言主要是进行定义、改变表的结构、数据类型、表之间的链接等操作。
常用的语句关键字有 CREATE、DROP、ALTER 等）、
DML（数据操纵语言主要是对数据进行增加、删除、修改操作。常用的语句关键字有
 INSERT、UPDATE、DELETE 等）、
DQL（数据查询语言主要是对数据进行查询操作。常用关键字有 SELECT、FROM、WHERE 等。）
和DCL（数据控制语言主要是用来设置/更改数据库用户权限。常用关键字有 GRANT、REVOKE 等。）。
DDL用于创建、删除和修改数据库对象，如表和数据库；DML涉及数据的增删改操作；DQL专注于数据查询；DCL则用于设置和撤销用户权限。了解这些概念对于数据库管理和开发至关重要。
这个sql笔记中我将会标注好语句的类型'''
-- 登录操作
mysql -uroot -p

--DDL
-- 创建数据库
create database  库名;
-- 删除数据库
drop database [if exists] 库名;
-- 查看
show databases;
-- 使用数据库
use 库名;


--DDL
-- 创建表
create table 表名{
	id int unsigned primary key auto_increament not null,
	name varchar(20) not null,
	age int unsigned default 0,
	high decimal(5,2),
	gender enum("男","女"),
	cls_id int unsigned

	};

-- DQL
-- 查看表的创建语句
-- show create table 表名字;
show create table students;

-- 查看表结构
desc 表名;

-- 删除表
drop table 表名；

-- 查看当前正在使用的数据库
select database()


# 单行注释可以用井号也可以使用--
/*
多行注释的语法和css中的多行注释一致
*/