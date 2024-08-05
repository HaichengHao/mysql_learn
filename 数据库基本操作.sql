-- 登录操作
mysql -uroot -p

-- 创建数据库
create database 库名;

-- 创建表
create table 表名{
	id int unsigned primary key auto_increament not null,
	name varchar(20) not null,
	age int unsigned default 0,
	high decimal(5,2),
	gender enum("男","女"),
	cls_id int unsigned

	};
-- 查看表的创建语句
-- show create table 表名字;
show create table students;

-- 查看表结构
desc 表名;

