-- 备份:把数据库里面的内容进行备份到硬盘和其他位置。如果数据库出现问题时，可以进行数据的恢复
-- 第一种备份：备份数据表中的数据
-- mysqldump -u用户名 -p(密码，可选，不输入的话一会儿会提示输入) 数据库名称 > 文件路径
mysqldump -uroot -p python_test > d://mysql//backup.sql

-- 恢复数据库
-- 把数据库中的所有内容备份到sql文件中
-- 注意，备份的时候，没有备份创建数据库的语句。当需要恢复某个具体的数据库的时候，需要手动创建数据库

-- 第一种恢复
source 文件名.sql

-- 要求登录到某一个具体的数据库中，才可以使用source 命令
-- 先删掉再演示
mysql -uroot -pxxxx;
drop database python_test;

-- 重新创建
create database python_test;
-- 使用
use python_tets;
-- 恢复数据库
source d://mysql//backup.sql;

--第二种恢复方式(tips:也要求数据库提前存在)
create database python_test;
-- 开始恢复
mysql -uroot -pxxxx python_test < d://mysql//backup.sql;

