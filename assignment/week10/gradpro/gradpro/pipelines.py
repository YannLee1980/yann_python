# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html

import pymysql
from snownlp import SnowNLP

# 数据库信息：
DB_INFO = {
    'host': 'localhost',
    'port': 3306,
    'user': 'root',
    'password': 'chenqiong',
    'db': 'gradpro',
}

# 数据库链接类：
class ConnDB(object):
    def __init__(self, dbinfo):
        self.conn = pymysql.connect(
            host=dbinfo['host'],
            port=dbinfo['port'],
            user=dbinfo['user'],
            password=dbinfo['password'],
            db=dbinfo['db'],
        )

    def run(self, sql, *args):
        cur = self.conn.cursor()
        cur.execute(sql, args)
        self.conn.commit()


class GradproPipeline:

    def __init__(self):
        super().__init__()
        self.db = ConnDB(DB_INFO)

    def process_item(self, item, spider):

        name = item['name']
        short = item['short']
        time = item['time']

        # 对评论进行舆情分析，计算舆情值
        sentiment = SnowNLP(short).sentiments

        sql = 'INSERT INTO ' + \
            'shampoo_raw(name, short, time, sentiment)' + \
            ' values(%s, %s, %s, %s)'

        self.db.run(sql, name, short, time, sentiment)

        return item
