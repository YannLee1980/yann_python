# -*- coding: utf-8 -*-
import scrapy
from assigment_2.items import Assigment2Item
from scrapy.selector import Selector
import time

class MaoyanSpider(scrapy.Spider):
    name = 'maoyan'
    allowed_domains = ['maoyan.com']
    start_urls = ['https://maoyan.com/films?showType=3']

    def start_requests(self):
        #提取页面前十部电影的详细页链接
        #print('test')
        url = 'https://maoyan.com/films?showType=3'
        yield scrapy.Request(url=url, callback=self.parse)



    def parse(self, response):
        tags = Selector(response=response).xpath('//div[@class="movie-item film-channel"]')
        for i in range(10):
            time.sleep(1)
            link = 'https://maoyan.com' + tags[i].xpath('./a/@href').extract_first().strip()
            print(link)
            yield scrapy.Request(url=link, callback=self.parse2)

    def parse2(self, response):
        time.sleep(2)

        item = Assigment2Item()

        film = Selector(response=response).xpath('//div[@class="movie-brief-container"]')

        film_name = film.xpath('./h1[@class="name"]/text()').get()
        item['film_name'] = film_name
        print("测试", film_name)

        type_str = film.xpath('./ul/li[1]/a/text()').getall()
        film_type = ''
        for str in type_str:
            film_type = film_type + ' ' + str.strip()
        item['film_type'] = film_type
        print(film_type)

        plan_time = film.xpath('./ul/li[3]/text()').get()
        item['plan_time'] = plan_time
        print(plan_time)

        yield item
        


