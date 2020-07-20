'''
第四周作业
* 作业背景：在数据处理的步骤中，可以使用 SQL 语句或者 pandas 加 Python 库、函数等方式进行数据的清洗和处理工作。因此需要你能够掌握基本的 SQL 语句和 pandas 等价的语句，利用 Python 的函数高效地做聚合等操作。
* 作业要求：请将以下的 SQL 语句翻译成 pandas 语句：
'''

import pandas as pd
import numpy as np
from sqlalchemy import create_engine
import pymysql

#生成数据表data的数据
data = pd.DataFrame({
    'id': range(1500),
    'age': np.random.randint(20, 55, size=1500)
})

# 生成数据表table1的数据：
table1 = pd.DataFrame({
    'id': np.random.randint(1, 101, size=1000),
    'order_id': np.random.randint(10001, 10101 ,size=1000),
    'name': [np.random.choice(list('ABCDEFGHIJKLMNOPQRSTUVWXYZ')) for _ in range(1000)]
})

# 生成数据表table2的数据：
table2 = pd.DataFrame({
    'id': np.random.randint(1, 101, size=1000),
    'type': [np.random.choice(list('abcdefghijklmnopqrxtuvwxyz')) for _ in range(1000)]
})

# 生成数据表table3的数据：
table3 = pd.DataFrame({
    'id': np.random.randint(1, 101, size=900),
    'order_id': np.random.randint(10001, 10101 ,size=900),
    'name': [np.random.choice(list('ABCDEFGHIJKLMNOPQRSTUVWXYZ')) for _ in range(900)]
})

#1. SELECT * FROM data;
print(data)

#2. SELECT * FROM data LIMIT 10;
print(data.head(10))

#3. SELECT id FROM data;  //id 是 data 表的特定一列
print(data['id'])

#4. SELECT COUNT(id) FROM data;
print(data['id'].count())

#5. SELECT * FROM data WHERE id<1000 AND age>30;
print(data[(data['id'] < 1000) & (data['age'] > 30)])

#6. SELECT id,COUNT(DISTINCT order_id) FROM table1 GROUP BY id;
print(table1.groupby('id')['order_id'].nunique())

#7. SELECT * FROM table1 t1 INNER JOIN table2 t2 ON t1.id = t2.id;
print(pd.merge(table1, table2, on='id', how='inner'))

#8. SELECT * FROM table1 UNION SELECT * FROM table3;(为了保证两表的结构一致，建了table3)
print(pd.concat([table1, table3]).drop_duplicates())

#9. DELETE FROM table1 WHERE id=10;
print(table1.drop(table1[table1['id'] == 10].index))

#10. ALTER TABLE table1 DROP COLUMN column_name;
table1.drop(columns='order_id', inplace=True)
print(table1)