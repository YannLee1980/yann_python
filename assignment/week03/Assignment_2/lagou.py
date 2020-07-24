'''
这是一个“爬取拉勾网python工程师职位收入”项目：
选取北京、上海、广州、深圳四个城市的python工程市收入情况进行比对。
'''

import requests
import threading
import pymysql
import matplotlib.pyplot as plt
import time
import json
import random
import os
import pandas as pd
import multiprocessing as mlp
from sqlalchemy import create_engine
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
                    resp = requests.get(url, headers=headers, timeout=1)
                    self.data_queue.put(resp.text)
                except Exception as e:
                    print('出现异常', e)
                    pass


class ParserThread(threading.Thread):
    '''
    分析页面线程类
    '''
    def __init__(self, thread_id, data_queue, output_queue):
        super().__init__()
        self.thread_id = thread_id
        self.data_queue = data_queue
        self.output_queue = output_queue
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
                    position = job.xpath('.//h3/text()')[0].strip('"')
                    money = job.xpath('.//span[@class="money"]/text()')[0].strip('"')
                    resp = {
                        'position': position,
                        'money': money
                    }
                    self.output_queue.put(resp)
            except Exception as e:
                print('Position Error', e)
        except Exception as e:
            print('Page Error.', e)
                

def data_handle(list):
    '''
    把原始数据进行整理，以便后续的绘图和存入数据库，输出dataframe对像
    '''
    data = pd.DataFrame(list)
    
    #拆分money字段，分成money_min,money_max:
    money_mins = []
    money_maxs = []
    for one_record in data['money']:
        if '薪' in one_record:
            months = int(one_record.split('·')[1].strip('薪'))
            money_list = one_record.split('-')
            money_min = int(money_list[0].strip('k')) * (months / 12)
            money_max = int(money_list[1].split('·')[0].strip('k')) * (months / 12)
            money_mins.append(round(money_min, 1))
            money_maxs.append(round(money_max, 1))
        else:
            money_list = one_record.split('-')
            money_min = int(money_list[0].strip('k'))
            money_max = int(money_list[1].strip('k'))
            money_mins.append(money_min)
            money_maxs.append(money_max)
    data['money_min_k'] = money_mins
    data['money_max_k'] = money_maxs

    return data


def data_plot(results):
    '''
    绘制图表，results是字典的列表,形如：
    [{'beijing': {'money_min_mean': *, 'money_max_mean': *}},...]
    '''

    index = []
    data = []
    for d in results:
        for key , value in d.items():
            index.append(key)
            data.append(value)
    df = pd.DataFrame(data, index=index)

    #绘直方图：
    fig = plt.figure(figsize=(8,6))
    rects_min = plt.bar(df.index, 
                        df['money_min_mean'], 
                        width=0.65, 
                        color='red',
                        alpha=0.3)
    rects_max = plt.bar(df.index, 
                        df['money_max_mean']-df['money_min_mean'], 
                        bottom=df['money_min_mean'],
                        width=0.65,
                        color='purple',
                        alpha=0.75)

    #文本标注：
    for rect in rects_min:
        height = rect.get_height()
        plt.text(rect.get_x()+rect.get_width()/2, 
                height-1.5, 
                f'Min:{round(height, 1)}k',
                ha='center',
                va='bottom',
                color='black',
                alpha=0.65,
                size=12)

    count = 0
    for rect in rects_max:
        height = round(df['money_max_mean'][count], 1)
        count += 1
        plt.text(rect.get_x()+rect.get_width()/2,
                height-1.5,
                f'Max:{height}k',
                ha='center',
                color='yellow',
                size=12)
    #设置标题：
    plt.title('Averge monthly income of Python engineers in four cities')
    #隐藏边框：
    ax = plt.axes()
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)
    
    plt.show()


def data_to_db(data, city):
    '''
    把分析数据存到以城市名建的表名的数据库中
    '''

    #建立与数据库的链接：
    engine = create_engine('mysql+pymysql://root:chenqiong@localhost:3306/week3_assignment')
    
    #导入到数据库以城市名起的表名中：
    data.to_sql(city, engine, if_exists='replace', index=False)


def worker(args):
    '''
    多线程进行爬取分析的逻辑模块，参数只接收元组形如：(url, city)
    '''

    # 存放解析数据的queue：
    data_queue = Queue()

    # 存放输出数据的queue：
    output_queue = Queue()

    # 任务队列，存放网页的队列
    url_queue = Queue()
    for i in range(1, 22):
        url_queue.put(args[0]+str(i))

    # 爬虫线程
    crawl_threads = []
    crawl_name_list = ['crawl_1','crawl_2','crawl_3'] 
    for thread_id in crawl_name_list:
        thread = CrawlThread(thread_id, url_queue, data_queue)
        thread.start() 
        crawl_threads.append(thread)

    # 解析线程
    parse_threads = []
    parser_name_list = ['parse_1','parse_2','parse_3']
    for thread_id in parser_name_list: 
        thread = ParserThread(thread_id, data_queue, output_queue)
        thread.start() 
        parse_threads.append(thread)

    # 结束crawl线程
    for t in crawl_threads:
        t.join()
    
    # 结束parse线程

    for t in parse_threads:
        t.set_flag_stop(True)
        t.join()

    # 从output_queue中取出数据：
    resp_list = []
    while True:
        if not output_queue.empty():
            resp = output_queue.get(False)
            resp_list.append(resp)
        else:
            break

    #处理数据：
    data = data_handle(resp_list)

    #把数据存到result_queue中：
    global result_queue

    money_min_mean = data['money_min_k'].mean()
    money_max_mean = data['money_max_k'].mean()
    result = {args[1]: {'money_min_mean': money_min_mean,
                       'money_max_mean': money_max_mean}}

    result_queue.put(result)

    #把数据存到数据库：
    data_to_db(data, args[1])


def main():
    '''
    选取北京、上海、广州、深圳四个城市进行分析。
    '''

    cities = ['beijing', 'shanghai', 'guangzhou', 'shenzhen']
    urls = [f'https://www.lagou.com/{city}-zhaopin/Python/' for city in cities]

    args_list = list(zip(urls, cities))

    #一个进程对应一个城市进行网站信息爬取：
    with Pool(processes=4) as pool:
        pool.map(worker, args_list)

    print('完成任务，退出主进程。')

    #从mlp.Queue对象中取出数据：
    global result_queue

    results = []

    while True:
        if not result_queue.empty():
            results.append(result_queue.get(False))
        else:
            break
    
    #绘制图表：
    data_plot(results)


if __name__ == '__main__':
    
    #不能用线程的queue.Queue()，由于work是运行在进程里的，所以只能用进程的Queue()
    result_queue = mlp.Queue() 
    
    main()


'''
后记：第二版加入了写入数据库功能，绘制图标，并且数据量的收集做到了最大化，
每个城市的数据不止100条，把所以查到的数据都收录其中。
'''