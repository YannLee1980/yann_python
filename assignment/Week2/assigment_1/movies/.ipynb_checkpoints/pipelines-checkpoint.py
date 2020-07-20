# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html

import pymysql

DB_INFO = {
    'host' : 'localhost',
    'port' : 3306,
    'user' : 'root',
    'password' : 'test',
    'db' : 'maoyan'
}

class ConnDB(object):
    def __init__(self, dbInfo):
        self.host = dbInfo['host']
        self.port = dbInfo['port']
        self.user = dbInfo['user']
        self.password = dbInfo['password']
        self.db = dbInfo['db']
        
    def run(self, sql, *args):
        conn = pymysql.connect(
            host = self.host,
            port = self.port,
            user = self.user,
            password = self.password,
            db = self.db
        )
        cur = conn.cursor()
        try:
            cur.execute(sql, args)
            cur.close()
            conn.commit()
        except:
            conn.rollback()
        finally:
            conn.close()

class MoviesPipeline:
    def process_item(self, item, spider):
        film_name = item['film_name']
        film_type = item['film_type']
        plan_time = item['plan_time']
        
        db = ConnDB(DB_INFO)
        
        sql = 'INSERT INTO ' + 'Movies(film_name, film_type, plan_time)' + ' values(%s, %s, %s)'
        
        db.run(sql, film_name, film_type, plan_time)
        
        return item