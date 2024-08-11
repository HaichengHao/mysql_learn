--17连接查询自连接
'''
为什么需要自连接
使用自连接查询，只需要使用一个表，可以加快查询速度，减少数据表占用空间

给一张表起两个别名，再用inner join 的方式进行字段查询
自连接的本质就还是连接查询

'''

--数据准备
-- 连接查询-自连接

-- 创建areas地区表
create table areas(
		aid int primary key,
		atitle varchar(20),
		pid int
);

-- 从sql文件中导入文件
source areas.sql


-- 查询省的名称为“广东省”的所有城市
select city.* from 
areas as city
inner join
areas as province
on city.pid=province.aid
where province.atitle="广东省";