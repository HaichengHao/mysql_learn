05表数据操作命令之删除数据
--DML
-- delete from 表名 where 条件;删除数据，物理删除，即永久意义上的删除，无法恢复

delete from student where name="小花2";

-- 逻辑删除
-- 利用bit 的01标识，两种状态，未删除和已删除，默认为0表示未删除，1表示已删除
-- 为数据表增加一个字段，设置该字段值表示是否删除，如果删除就为1 这样我们查询时只需要查看除该字段外的所有字段即可
alter table student add is_delete bit default 0;

-- 逻辑删除数据
-- 将id为1的数据对象的is_delete 字段位更新为1表示已经删除(DML)
update student set is_delete=1 where id=1;
-- 此时查询is_delete=0即未删除的数据(DQL)
select * from student where is_delete=0;

--新补充
truncate table 表名; --删除表的所有记录,不能回滚
--truncate删除数据，过程先整个表删除再创建
--delete 删除数据 逐行删除记录

-- truncate属于DDL,delete 属于DML 事务管理只对DML有效，被事务管理sql语句可以回滚到sql执行前的状态
