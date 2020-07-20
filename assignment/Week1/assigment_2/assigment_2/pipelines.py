# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html

class Assigment2Pipeline:
    def process_item(self, item, spider):
        film_name = item['film_name']
        film_type = item['film_type']
        plan_time = item['plan_time']
        output = f"|{film_name}|\t|{film_type}|\t|{plan_time}|\n\n"
        with open('./maoyan_movies.txt', 'a+', encoding='utf-8') as f:
            f.write(output)

        return item
