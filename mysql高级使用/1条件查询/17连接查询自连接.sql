--17连接查询自连接
'''
为什么需要自连接
使用自连接查询，只需要使用一个表，可以加快查询速度，减少数据表占用空间

给一张表起两个别名，再用inner join 的方式进行字段查询
自连接的本质就还是连接查询

'''
-- 自连接使用场景:所有的表都在一张表中，数据与数据之间有层级关系
--数据准备
-- 连接查询-自连接

-- 创建areas地区表
 create table tb_area(
    -> aid int not null primary key auto_increment,
    -> atitle varchar(20),
    -> pid int --这里的pid代表的是parentid,即父级id,对于表tb_area来说其父级就是其省会
    -> );

 -- 插入数据
mysql> insert into tb_area values(null,'广东省',null),(null,'山西省',null),(null,'深圳市',1),(null,'广州市',1);
-- 从sql文件中导入文件(头脑发热写的，不必理会，卡住进度半天)
source areas.sql


-- 查询省的名称为“广东省”的所有城市
-- 别名操作中的as可以省略
select city.* from  --city.*代表选择city表中的所有信息
areas as city
inner join
areas as province
on city.pid=province.aid
where province.atitle="广东省";