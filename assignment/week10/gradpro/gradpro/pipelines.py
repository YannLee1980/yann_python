# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html

import csv

class GradproPipeline:
    def process_item(self, item, spider):

        name = item['name']
        short = item['short']
        time = item['time']

        #把数据写入文档：
        with open('./shampoo.csv', 'a', encoding='utf-8') as f:
            writer = csv.writer(f)
            writer.writerow([name, short, time])

        return item
