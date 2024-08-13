--25索引
/*
	如果数据库本身是一个字典，那么索引就是这个字典的目录
	索引的本质就是一种特殊的文件(InnoDB数据表上的索引是表空间的一个组成部分，它们包含着对数据表里所有记录的位置信息)


*/

-- 数据准备
创建测试表
create table test_index(title varchar(10));

-- 向表中插入10万条数据
python3 insert_data.py


--索引的使用
查看表中已经有的索引
show index from 表名;



创建索引,注意，是给字段创建索引的
alter table 表名 add index 索引名[可选](字段名,.....);
如 alter table test_index add index(字段名);给test_index表的title字段加上索引，不用索引名


删除索引
drop index 索引名 on 表名;



--没有索引的情况
--开启时间检测:
set profiling=1;
--查找第1万条数据ha-99999
select * from test_index where title='ha-99999';
--查看执行时间
show profiles;
/*
mysql> select * from test_index where title='ha-99999';
+----------+
| title    |
+----------+
| ha-99999 |
+----------+
1 row in set (0.54 sec)

mysql> show profiles;
+----------+------------+-------------------------------------------------+
| Query_ID | Duration   | Query                                           |
+----------+------------+-------------------------------------------------+
|        1 | 0.54550200 | select * from test_index where title='ha-99999' |
+----------+------------+-------------------------------------------------+
1 row in set, 1 warning (0.01 sec)
*/
-- 可以看到没有索引的查询延迟为0.545秒



--有索引的情况
--给title字段创建索引
alter table test_index add index(title);
/*
mysql> alter table test_index add index(title);
Query OK, 0 rows affected (0.46 sec)
Records: 0  Duplicates: 0  Warnings: 0
*/

--开启时间查询
set profiling = 1;

--查询第十万条数据ha-99999
select * from test_index where title='ha-99999'；

--查看执行时间
show profiles;
/*
mysql> show profiles;
+----------+------------+-------------------------------------------------+
| Query_ID | Duration   | Query                                           |
+----------+------------+-------------------------------------------------+
|        1 | 0.54550200 | select * from test_index where title='ha-99999' |
|        2 | 0.46272825 | alter table test_index add index(title)         |
|        3 | 0.00033875 | set profiling=1                                 |
|        4 | 0.00039575 | select * from test_index where title='ha-99999' |
+----------+------------+-------------------------------------------------+
可以看到添加索引之后查询时间到了0.000395秒
*/

--查看索引
show index from test_index;
/*
mysql> show index from test_index;
+------------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table      | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+------------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| test_index |          1 | title    |            1 | title       | A         |       98851 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+------------+------------+-----*/               可以看到是title字段添加了索引，因为我们没有起索引名，所以默认起了个title，这就是索引名


--删除索引
drop index title on test_index;
/*
mysql> drop index title on test_index;
Query OK, 0 rows affected (0.05 sec)
Records: 0  Duplicates: 0  Warnings: 0
*/
--再次查看索引
show index from test_index;
/*
mysql> show index from test_index;
Empty set (0.01 sec)
*/


/*

总结:
索引的优点
加快查询速度
缺点
创建索引会浪费时间和占用磁盘空间，并且随着数据量的增加所耗费的时间会越来越多

使用原则
1经常发生数据更新的表避免使用过多的索引
2数据量小的表没有必要使用索引
3数据量较大同时不会频繁发生数据更改的表可以使用索引
*/