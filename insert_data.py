# from pymysql import connect
import mysql.connector


def main():
    # 创建Connection连接
    conn = mysql.connector.connect(host='localhost',port=3306,database='python_test_1',user='root',password='HHCzio20.',charset='utf8')
    # 获得Cursor对象
    cursor = conn.cursor()
    # 插入10万次数据
    for i in range(100000):
        cursor.execute("insert into test_index values('ha-%d');" % i)
    # 提交数据
    conn.commit()

if __name__ == "__main__":
    main()