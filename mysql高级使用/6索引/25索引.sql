--25索引
/*
	如果数据库本身是一个字典，那么索引就是这个字典的目录
	索引的本质就是一种特殊的文件(InnoDB数据表上的索引是表空间的一个组成部分，它们包含着对数据表里所有记录的位置信息)


*/

-- 数据准备
创建测试表
create table test_index(title varchar(10));

-- 向表中插入10万条数据
python3 insert 


--索引的使用
查看表中已经有的索引
show index from 表名;



创建索引,注意，是给字段创建索引的
alter table 表名 add index 索引名[可选] (字段名,.....);


删除索引
drop index 索引名 on 表名;