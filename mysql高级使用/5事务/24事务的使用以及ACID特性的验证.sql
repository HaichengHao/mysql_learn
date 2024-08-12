--24事务的使用以及ACID特性的验证
-- 本节用表students 数据库python_test_1
--1事务的使用
'''开启事务，开启事务后执行修改命令，变更会维护到本地缓存中，而不维护到物理表中
这样就使得我们只要不提交事务，那么对数据表的操作就不会写入到数据库当中
语法 begin; 或者 start transaction;
'''



'''提交事务，将缓存中的数据变更维护到物理表中
commit;
'''


'''回滚事务，放弃缓存中变更的数据，表示事务执行失败，应该回滚到开始事务前的状态rollback;
注意，回滚操作应当在commit之前，因为一旦事务成功提交，那么数据表就会发生变化
'''

--事务以及ACID验证
-- 原子性 一致性
第一步 打开终端1和终端2
第二步 终端1 打开事务begin; 或 strat transaction;
	终端1 update 表名 set 字段名='值';
	'''终端1
mysql> begin;
Query OK, 0 rows affected (0.01 sec)

mysql> update students set age=100 where id=1;
Query OK, 1 row affected (0.02 sec)
Rows matched: 1  Changed: 1  Warnings: 0
'''
	终端1 select * from 表名; 发现数据变换了，但是事务开启时进行的操作只是维护到缓存当中
	但是并没有真正写入到数据库中
	'''终端1
	mysql> select * from students where id=1;
+----+--------+------+--------+--------+--------+----------------------+
| id | name   | age  | height | gender | cls_id | is_delete            |
+----+--------+------+--------+--------+--------+----------------------+
|  1 | 小明   |  100 | 180.00 | 女     |      1 | 0x00                 |
+----+--------+------+--------+--------+--------+----------------------+
1 row in set (0.00 sec)
'''

第三步 终端2 select * from 表名;
	'''终端2
	mysql> select * from students where id=1;
+----+--------+------+--------+--------+--------+----------------------+
| id | name   | age  | height | gender | cls_id | is_delete            |
+----+--------+------+--------+--------+--------+----------------------+
|  1 | 小明   |   18 | 180.00 | 女     |      1 | 0x00                 |
+----+--------+------+--------+--------+--------+----------------------+
1 row in set (0.00 sec)
'''
	发现终端起始并没有任何改变，这也证明了终端一种的事务操作在未提交前不会对表真正产生影响
	如果这时候终端1对事务进行commit之后，这些操作才会真正写入到数据表当中
	'''
	终端1
	进行commit;
	mysql> commit;
Query OK, 0 rows affected (0.00 sec)

	'''

	'''终端2
	再次查询数据
	mysql> select * from students where id=1;
+----+--------+------+--------+--------+--------+----------------------+
| id | name   | age  | height | gender | cls_id | is_delete            |
+----+--------+------+--------+--------+--------+----------------------+
|  1 | 小明   |  100 | 180.00 | 女     |      1 | 0x00                 |
+----+--------+------+--------+--------+--------+----------------------+
1 row in set (0.00 sec)
''' 这时候才真正发生了改变

	
--隔离性
第一步 打开终端1和终端2
第二步 终端1 打开事务begin；
	终端1 update 表名 set 字段名="xxx" 
	'''终端1
	mysql> update students set age=20 where id=1;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

'''

第三步 终端2 update 表名 set 字段名='xxx'
	'''终端2
	mysql> update students set age=18;

	一直没有运行
'''
	发现处于阻塞状态
第四步 终端1 commit;
'''终端1
mysql> commit;
Query OK, 0 rows affected (0.00 sec)
'''

-- 终端2的阻塞状态解除 数据修改成功
-- 终端2
-- mysql> update students set age=18;
-- Query OK, 14 rows affected (14.39 sec)
-- Rows matched: 16  Changed: 14  Warnings: 0



这时候也可以对终端2进行commit操作，最终修改为终端2设置的字段


--回滚
第一步 打开终端begiin
第二步 终端1 update 表名 set 字段名='xxx'
/*
终端1
mysql> update student set age=10 where id=1;
ERROR 1146 (42S02): Table 'python_test_1.student' doesn't exist
mysql> update students set age=10 where id=1;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from students where id=1;
+----+--------+------+--------+--------+--------+----------------------+
| id | name   | age  | height | gender | cls_id | is_delete            |
+----+--------+------+--------+--------+--------+----------------------+
|  1 | 小明   |   10 | 180.00 | 女     |      1 | 0x00                 |
+----+--------+------+--------+--------+--------+----------------------+
1 row in set (0.00 sec)
*/ --之前的注释都是胡乱写的，最终修正
-- 第三步 rollback 数据返回最开始的原始值
rollback; 回滚到数据最开始的原始值，也就是最最最开始的原始值
/*
mysql> select * from students where id=1;
+----+--------+------+--------+--------+--------+----------------------+
| id | name   | age  | height | gender | cls_id | is_delete            |
+----+--------+------+--------+--------+--------+----------------------+
|  1 | 小明   |   10 | 180.00 | 女     |      1 | 0x00                 |
+----+--------+------+--------+--------+--------+----------------------+
1 row in set (0.00 sec)

mysql> rollback;
Query OK, 0 rows affected (0.00 sec)

mysql> select * from students where id=1;
+----+--------+------+--------+--------+--------+----------------------+
| id | name   | age  | height | gender | cls_id | is_delete            |
+----+--------+------+--------+--------+--------+----------------------+
|  1 | 小明   |   18 | 180.00 | 女     |      1 | 0x00                 |
+----+--------+------+--------+--------+--------+----------------------+
1 row in set (0.00 sec)
*/

--能使用事务操作归功于innoDB引擎