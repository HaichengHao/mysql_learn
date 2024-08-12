-- 表数据操作之添加数据
-- student 表的各字段
-- create table 表名{
-- 	id int unsigned primary key auto_increament not null,
-- 	name varchar(20) not null,
-- 	age int unsigned default 0,
-- 	high decimal(5,2),
-- 	gender enum("男","女"),
-- 	cls_id int unsigned

-- 	};


-- DML
-- insert into 表名 values(....);
-- 作用 全列插入:值的顺序与表结构字段的顺序完全对应
-- 主键字段可以用 0 null default 来占位,会自增
insert into student values(0,"小花",18,166.66,"男",110);
-- 提前说一条 select * from 表名; 即可查看表

-- insert into 表名(列1,...) values(值1,...);
-- 作用 部分列插入: 值的顺序与给出的列顺序对应,注意，指定非空not null 类型的字段不能为空，但是由于主键设置了自动增长，所以可以为空
insert into student(name,age) values("德华",50);


-- insert into 表名 values(...),(...)...; 
-- 作用 一次性插入多行数据
insert into student values(0,"小花1",18,166.66,"男",110),(0,"小花2",18,166.66,"男",110);
-- insert into 表名(列1,...) values(值1,...),(值1,...)...;
-- 作用 部分列多行插入

--注意，当我们把查询的结果一次性插入字段中时是不需要加values 的
这里注意查看第20节表的优化的总结