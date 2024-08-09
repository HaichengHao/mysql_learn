--04修改查询命令

-- select * from 表名; 查询所有列数据
select * from student;

-- select 列1,列2，... from 表名;  查询指定列数据
select name from student;
select gender from student;
select gender,name from student;
-- update 表名 set 列1=值1,列2=值2....where 条件; 修改数据
update student set gender="女" where name="小花";
update student set name="小华" where name="小花1";
update student set gender="男" where name="德华";
update student set cls_id=120, heigh=178.67 where name="德华";