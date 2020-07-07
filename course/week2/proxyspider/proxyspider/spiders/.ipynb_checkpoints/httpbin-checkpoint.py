# -*- coding: utf-8 -*-
import scrapy


class HttpbinSpider(scrapy.Spider):
    name = 'httpbin'
    allowed_domains = ['httpbin.org']
    # 通过ip查看请求的ip地址
    start_urls = ['http://httpbin.org/ip']
    # 通过header 查看user-agent
    # start_urls = ['http://httpbin.org/headers']

    def parse(self, response):
        print(response.text)
