# 30python连接mysql之增删改查
import  mysql.connector
conn = mysql.connector.connect(
    user='root',
    password='HHCzio20.',
    database='python_test_1',
    port=3306,
    host='localhost',
    charset='utf8'

)
cursor = conn.cursor()
# cursor.execute("select * from students;")
# content = cursor.fetchall()
# # 更优雅的查看所有数据
# for item in content:
#     print(item)
'''
(1, '小明', 18, Decimal('180.00'), '女', 1, 0)
(2, '小月月', 18, Decimal('180.00'), '女', 2, 1)
(3, '彭于晏', 18, Decimal('185.00'), '男', 1, 0)
(4, '刘德华', 18, Decimal('175.00'), '男', 2, 1)
(5, '黄蓉', 18, Decimal('160.00'), '女', 1, 0)
(6, '凤姐', 18, Decimal('150.00'), '保密', 2, 1)
(7, '王祖贤', 18, Decimal('172.00'), '女', 1, 1)
(8, '周杰伦', 18, None, '男', 1, 0)
(9, '程坤', 18, Decimal('181.00'), '男', 2, 0)
(10, '刘亦菲', 18, Decimal('166.00'), '女', 2, 0)
(11, '金星', 18, Decimal('162.00'), '中性', 3, 1)
(12, '静香', 18, Decimal('180.00'), '女', 4, 0)
(13, '郭靖', 18, Decimal('170.00'), '男', 4, 0)
(14, '周杰', 18, Decimal('176.00'), '女', 5, 0)
(15, '凌小小', 18, Decimal('180.00'), '女', 1, 0)
(16, '司马二狗', 18, Decimal('120.00'), '男', 1, 0)'''

# 插入数据
# cursor.execute("insert into students values (17,'邓超',58,179,'男',2,0),(18,'孙俪',58,160,'女',2,0);")
#查看是否插入成功
# cursor.execute("select * from students;")
# allcontent=cursor.fetchall()
# for item in allcontent:
#     print(item)
'''
(1, '小明', 18, Decimal('180.00'), '女', 1, 0)
(2, '小月月', 18, Decimal('180.00'), '女', 2, 1)
(3, '彭于晏', 18, Decimal('185.00'), '男', 1, 0)
(4, '刘德华', 18, Decimal('175.00'), '男', 2, 1)
(5, '黄蓉', 18, Decimal('160.00'), '女', 1, 0)
(6, '凤姐', 18, Decimal('150.00'), '保密', 2, 1)
(7, '王祖贤', 18, Decimal('172.00'), '女', 1, 1)
(8, '周杰伦', 18, None, '男', 1, 0)
(9, '程坤', 18, Decimal('181.00'), '男', 2, 0)
(10, '刘亦菲', 18, Decimal('166.00'), '女', 2, 0)
(11, '金星', 18, Decimal('162.00'), '中性', 3, 1)
(12, '静香', 18, Decimal('180.00'), '女', 4, 0)
(13, '郭靖', 18, Decimal('170.00'), '男', 4, 0)
(14, '周杰', 18, Decimal('176.00'), '女', 5, 0)
(15, '凌小小', 18, Decimal('180.00'), '女', 1, 0)
(16, '司马二狗', 18, Decimal('120.00'), '男', 1, 0)
(17, '邓超', 58, Decimal('179.00'), '男', 2, 0)
(18, '孙俪', 58, Decimal('160.00'), '女', 2, 0)
可以发现两条数据都增加成功了，但是，打开mysql终端查看，发现原来的表没有任何变化，为什么呢？
因为pycharm链接数据库会默认开启事务，这时候事务未提交，我们需要调用数据库连接对象对事务进行提交
'''
# 用连接对象提交事务
# conn.commit()
# 再次在mysql终端查询数据，发现已经写入了，事务提交成功



# 删除数据
# cursor.execute("delete from students where name='孙俪';")
# # 提交事务
# conn.commit()
# # 查询是否删除
# cursor.execute("select * from students;")
# allcontent=cursor.fetchall()
# for item in allcontent:
#     print(item)
'''
(1, '小明', 18, Decimal('180.00'), '女', 1, 0)
(2, '小月月', 18, Decimal('180.00'), '女', 2, 1)
(3, '彭于晏', 18, Decimal('185.00'), '男', 1, 0)
(4, '刘德华', 18, Decimal('175.00'), '男', 2, 1)
(5, '黄蓉', 18, Decimal('160.00'), '女', 1, 0)
(6, '凤姐', 18, Decimal('150.00'), '保密', 2, 1)
(7, '王祖贤', 18, Decimal('172.00'), '女', 1, 1)
(8, '周杰伦', 18, None, '男', 1, 0)
(9, '程坤', 18, Decimal('181.00'), '男', 2, 0)
(10, '刘亦菲', 18, Decimal('166.00'), '女', 2, 0)
(11, '金星', 18, Decimal('162.00'), '中性', 3, 1)
(12, '静香', 18, Decimal('180.00'), '女', 4, 0)
(13, '郭靖', 18, Decimal('170.00'), '男', 4, 0)
(14, '周杰', 18, Decimal('176.00'), '女', 5, 0)
(15, '凌小小', 18, Decimal('180.00'), '女', 1, 0)
(16, '司马二狗', 18, Decimal('120.00'), '男', 1, 0)
(17, '邓超', 58, Decimal('179.00'), '男', 2, 0)
孙俪这条数据已经被删除成功
'''

# 修改数据
cursor.execute("update students set age=59 where name='邓超';")
# 提交事务
conn.commit()
# 查看结果
cursor.execute("select * from students where name='邓超';")
res = cursor.fetchone()
print(res)
# (17, '邓超', 59, Decimal('179.00'), '男', 2, 0) <--可以看到邓超这条数据的age已经被修改

