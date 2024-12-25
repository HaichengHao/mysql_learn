--where 之空值判断
'''
判断为空 is null
select * from students where height is null;
'''
--查询高度为空的数据对象
select * from students where height is null;
'''
mysql> select * from students where height is null;
+----+-----------+------+--------+--------+--------+----------------------+
| id | name      | age  | height | gender | cls_id | is_delete            |
+----+-----------+------+--------+--------+--------+----------------------+
|  8 | 周杰伦    |   36 |   NULL | 男     |      1 | 0x00                 |
+----+-----------+------+--------+--------+--------+----------------------+
1 row in set (0.00 sec)
'''
-- 查询非空,取反操作加上not即可
select * from students where height is not null;