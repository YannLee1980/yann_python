# -*- coding: utf-8 -*-
import scrapy
from assigment_2.items import Assigment2Item
from scrapy

class MaoyanSpider(scrapy.Spider):
    name = 'maoyan'
    allowed_domains = ['maoyan.com']
    start_urls = ['http://maoyan.com/']

    def parse(self, response):
        pass
