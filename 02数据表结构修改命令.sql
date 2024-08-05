-- 表结构修改命令
-- 添加字段
alter table 表名 add 列名 类型;
-- 实例代码
alter table student add jixiangwu varchar(30);

-- 重命名字段
alter table 表名 change 原字段名 新字段名 类型及约束;
-- 实例
alter table student change jixiangwu mascot varchar(30);


-- 修改字段类型
alter table 表名 modify 列名 类型及约束;
--实例
alter table student modify mascot varchar(20);


-- 删除字段
alter table 表名 drop 列名;
-- 实例
alter table student drop mascot;

-- 删除表
drop table 表名；
-- 实例
drop table python;


