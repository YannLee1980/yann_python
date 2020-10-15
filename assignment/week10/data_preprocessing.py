'''
毕业项目数据预处理
'''

import pandas as pd
import pymysql
from snownlp import SnowNLP
from sqlalchemy import create_engine

# 建立链接：
engine = create_engine('mysql+pymysql://root:chenqiong@localhost:3306/gradpro')
# 原始数据存储在表‘shampoo_raw’，从中取出数据：
sql = 'select name,short,time,sentiment from shampoo_raw'
# 建dataframe:
df = pd.read_sql_query(sql, engine)
# 字段'sentiment'数据保留小数后两位：
df['sentiment'] = round(df['sentiment'], 2)
# 添加id
df['id'] = range(1, len(df)+1)
# 去重：
df = df.drop_duplicates(['short'])
# 重新写入新的数据表‘shampoo’：
df.to_sql('shampoo', engine, if_exists='replace', index=False)
