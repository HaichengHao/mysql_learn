# 29连接mysql查询数据
# 导入pymsql包或者mysql.connector包
import mysql.connector
# 创建连接对象
conn = mysql.connector.connect(
    host='localhost',
    port=3306,
    user='root',
    password='HHCzio20.',
    database='python_test_1',
    charset='utf8'
)
#创建游标对象
cursor = conn.cursor()
# 游标对象执行语句
content = cursor.execute("select * from students;")

# 真正的数据应该这样获取,我们这里先获取一条试试
relcontent = cursor.fetchone()
# 获取所有数据
allcon = cursor.fetchall()

#打印返回的内容,返回的是受影响的行数，并不是我们想象中的数据

print(content)
print(relcontent)
print(allcon)
'''
None
(1, '小明', 18, Decimal('180.00'), '女', 1, 0)
[(2, '小月月', 18, Decimal('180.00'), '女', 2, 1), (3, '彭于晏', 18, Decimal('185.00'), '男', 1, 0), (4, '刘德华', 18, Decimal('175.00'), '男', 2, 1), (5, '黄蓉', 18, Decimal('160.00'), '女', 1, 0), (6, '凤姐', 18, Decimal('150.00'), '保密', 2, 1), (7, '王祖贤', 18, Decimal('172.00'), '女', 1, 1), (8, '周杰伦', 18, None, '男', 1, 0), (9, '程坤', 18, Decimal('181.00'), '男', 2, 0), (10, '刘亦菲', 18, Decimal('166.00'), '女', 2, 0), (11, '金星', 18, Decimal('162.00'), '中性', 3, 1), (12, '静香', 18, Decimal('180.00'), '女', 4, 0), (13, '郭靖', 18, Decimal('170.00'), '男', 4, 0), (14, '周杰', 18, Decimal('176.00'), '女', 5, 0), (15, '凌小小', 18, Decimal('180.00'), '女', 1, 0), (16, '司马二狗', 18, Decimal('120.00'), '男', 1, 0)]
'''

# 关闭游标和连接
cursor.close()
conn.close()