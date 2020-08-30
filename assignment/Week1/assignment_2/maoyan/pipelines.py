# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html

import csv

class MaoyanPipeline:
    def process_item(self, item, spider):
        
        film_name = item['film_name']
        film_type = item['film_type']
        plan_time = item['plan_time']

        #把数据写入文档：
        with open('./movies.csv', 'a', encoding='utf-8') as f:
            writer = csv.writer(f)
            writer.writerow([film_name, film_type, plan_time])

        return item
