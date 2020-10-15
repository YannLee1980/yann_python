# -*- coding: utf-8 -*-
import scrapy
import csv
from gradpro.items import GradproItem
from scrapy.selector import Selector
import time


class ShampooSpider(scrapy.Spider):
    name = 'shampoo'
    allowed_domains = ['smzdm.com']
    start_urls = [
        'https://www.smzdm.com/fenlei/xifahufa/h5c4s0f0t0p1/#feed-main/']

    def parse(self, response):
        selector = Selector(response=response)
        tags = selector.xpath('//h5[@class="feed-block-title"]/a/@href')
        for i in range(10):
            url = tags[i].get()
            yield scrapy.Request(url, callback=self.parse2)

    def parse2(self, response):
        time.sleep(1)
        item = GradproItem()
        selector = Selector(response=response)
        item['name'] = selector.xpath(
            '//h1[@class="title J_title"]/text()').get().strip().replace(' ', '')
        tags = selector.xpath('//div[@class="comment_conBox"]')
        for tag in tags:
            item['time'] = tag.xpath(
                './div/div[@class="time"]/meta/@content').get()
            item['short'] = tag.xpath('./div/div/p/span/text()').get()
            yield item
