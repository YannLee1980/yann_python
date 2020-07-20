'''
这是一个“爬取拉勾网python工程师职位收入”项目：
'''

import requests
import threading
import pymysql
import matplotlib.pyplot as plt
import time
import json
import random
import os
from multiprocessing.pool import Pool
from fake_useragent import UserAgent
from queue import Queue
from lxml import etree

class CrawlThread(threading.Thread):
    '''
    爬虫线程类
    '''
    def __init__(self, thread_id, url_queue, data_queue):
        super().__init__()
        self.thread_id = thread_id
        self.url_queue = url_queue
        self.data_queue = data_queue

    def run(self):
        print(f'启动爬虫线程:<{os.getpid()}>{self.thread_id}')
        time.sleep(random.randint(1,3))
        self.scheduler()
        print(f'结束爬虫线程：<{os.getpid()}>{self.thread_id}')

    #任务调度：
    def scheduler(self):
        while True:
            if self.url_queue.empty():
                break
            else:
                url = self.url_queue.get()
                ua = UserAgent(verify_ssl=False)
                headers = {'User-Agent': ua.random}
                print(f'爬虫线程:<{os.getpid()}>{self.thread_id}, 正在下载:{url}')
                #下载器：
                try:
                    resp = requests.get(url, headers=headers)
                    self.data_queue.put(resp.text)
                except Exception as e:
                    print('出现异常', e)


class ParserThread(threading.Thread):
    '''
    分析页面线程类
    '''
    def __init__(self, thread_id, data_queue, file):
        super().__init__()
        self.thread_id = thread_id
        self.data_queue = data_queue
        self.file = file
        self.flag_stop = False

     #设置flag_stop，当flag_stop=True时停解析线程
    def set_flag_stop(self, bool):
        self.flag_stop = bool

    def run(self):
        print(f'启动分析线程:<{os.getpid()}>{self.thread_id}')
        time.sleep(random.randint(1,3))
        while not self.flag_stop:
            try:
                item = self.data_queue.get(False)
                if not item:
                    continue
                self.parse_data(item)
                self.data_queue.task_done()
            except Exception as e:
                pass
        print(f'结束分析线程:<{os.getpid()}>{self.thread_id}')
    

    #页面内容分析：
    def parse_data(self, item):
        '''
        解析网页内容的函数
        '''
        try:
            html = etree.HTML(item)
            jobs = html.xpath('//div[@class="position"]')
            try:
                for job in jobs:
                    position = job.xpath('.//h3/text()')
                    money = job.xpath('.//span[@class="money"]/text()')
                    resp = {
                        'position': position,
                        'money': money
                    }
                    json.dump(resp, fp=self.file, ensure_ascii=False)
            except Exception as e:
                print('Position Error', e)
        except Exception as e:
            print('Page Error.', e)
                

class ConnDB(object):
    '''
    读取数据库类
    '''
    pass

class JobPlot():
    pass

class GetData():
    pass



#args:  只接收元组形如：(url, city)
def worker(args):

    # 存放解析数据的queue：
    data_queue = Queue()

    #将结果保存到以城市命名的json文件中
    output = open(f'./{args[1]}.json', 'a', encoding='utf-8')

    # 任务队列，存放网页的队列
    url_queue = Queue(20)
    for i in range(1, 6):
        url_queue.put(args[0]+str(i))

    # 爬虫线程
    crawl_threads = []
    crawl_name_list = ['crawl_1','crawl_2','crawl_3'] 
    for thread_id in crawl_name_list:
        thread = CrawlThread(thread_id, url_queue, data_queue)
        thread.start() 
        crawl_threads.append(thread)

    # 解析线程
    parse_thread = []
    parser_name_list = ['parse_1','parse_2','parse_3']
    for thread_id in parser_name_list: 
        thread = ParserThread(thread_id, data_queue, output)
        thread.start() 
        parse_thread.append(thread)

    # 结束crawl线程
    for t in crawl_threads:
        t.join()
    
    # 结束parse线程

    for t in parse_thread:
        t.set_flag_stop(True)
        t.join()

    output.close()

if __name__ == '__main__':

    cities = ['beijing', 'shanghai', 'guangzhou', 'shenzhen']
    urls = [f'https://www.lagou.com/{city}-zhaopin/Python/' for city in cities]
    args_list = list(zip(urls, cities))

    with Pool(processes=4) as pool:
        pool.map(worker, args_list)

    print('完成任务，退出主进程。')


    '''
    后记：在完成作业时，很想把各功能模块化，但知识缺乏，所以用现在看到的一个文件组织功能的形式。
    同时由于时间关系，未能完成把数据写入数据库和绘图功能，只能以文件的形式保存，下周争取完成，谢谢老师查阅！
    '''