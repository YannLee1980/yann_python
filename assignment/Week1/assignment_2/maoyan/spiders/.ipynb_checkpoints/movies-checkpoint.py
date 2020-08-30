# -*- coding: utf-8 -*-
import scrapy
import csv
from maoyan.items import MaoyanItem
from scrapy.selector import Selector

class MoviesSpider(scrapy.Spider):
    name = 'movies'
    allowed_domains = ['maoyan.com']
    start_urls = ['https://maoyan.com/films?showType=3']

    #新建输出文件：
    with open('./movies.csv', 'w+', encoding='utf-8') as f:
        writer = csv.writer(f)
        #先写入columns_name
        writer.writerow(['电影名', '类型', '上映时间'])

    


    def parse(self, response):
        
        item = MaoyanItem()

        #提取详细信息：
        #计数器：
        count = 0
        #找到电影栏目
        tags = Selector(response=response).xpath('//div[@class="movie-hover-info"]')
        for tag in tags:
            #只获取前10部电影：
            count += 1
            if count > 10:
                break
            #在每个栏目里获取详细信息：
            details = tag.xpath('./div[@class="movie-hover-title"]')
            #获取电影名：
            film_name = details[0].xpath('./span[contains(@class,"name")]/text()').get()
            #获取电影类型：
            film_type = details[1].xpath('./text()')[1].get()
            film_type = film_type.split('\n')[1].strip()
            #获取上映时间：
            plan_time = tags[0].xpath('./div[@class="movie-hover-title movie-hover-brief"]/text()')[1].get()
            plan_time = plan_time.split('\n')[1].strip()
            print(film_name, film_type, plan_time)
            #数据存到item中：
            item['film_name'] = film_name
            item['film_type'] = film_type
            item['plan_time'] = plan_time
            
            yield item
        

