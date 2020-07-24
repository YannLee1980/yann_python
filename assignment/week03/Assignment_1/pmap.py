# -*-coding:utf-8-*-

import threading
import getopt
import time
import socket
import sys
import queue
import argparse
import os
import nmap
import json
import time
from multiprocessing import Process, Queue



class PortScanThread(threading.Thread):
    '''
    端口检测线程类
    '''
    def __init__(self, port_queue, ip, output_queue, timeout=3):
        '''
        初始化参数
        '''
        super().__init__()
        self.port_queue = port_queue
        self.ip = ip
        self.timeout = timeout
        self.output_queue = output_queue

    def run(self):
        '''
        多线程实际调用的方法，如果端口队列不为空，循环执行
        '''
        while True:
            if self.port_queue.empty():
                break

            port = self.port_queue.get(timeout=0.5)

            try:
                s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                s.settimeout(self.timeout)
                result_code = s.connect_ex((self.ip, port))
                if result_code == 0:
                    resp = {'port': port,
                            'state': 'OPEN'}
                    self.output_queue.put(resp)
            except Exception as e:
                print("error", e)
            finally:
                s.close()

class PortScanProc(Process):
    '''
    端口检测进程类
    '''
    def __init__(self, port_queue, ip, output_queue, timeout=3):
        '''
        初始化参数
        '''
        super().__init__()
        self.port_queue = port_queue
        self.ip = ip
        self.output_queue = output_queue
        self.timeout = timeout

    def run(self):
        '''
        多进程实际调用的方法，如果端口队列不为空，循环执行
        '''
        while True:
            if self.port_queue.empty():
                break

            try:
                port = self.port_queue.get(timeout=0.3)
            except Exception as e:
                pass

            try:
                s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                s.settimeout(self.timeout)
                result_code = s.connect_ex((self.ip, port))
                if result_code == 0:
                    resp = {'port': port,
                            'state': 'OPEN'}
                    self.output_queue.put(resp)
            except Exception as e:
                print("error", e)
            finally:
                s.close()


class PingThread(threading.Thread):
    '''
    ping线程类
    '''
    def __init__(self, ip_queue, output_queue):
        super().__init__()
        self.ip_queue = ip_queue
        self.output_queue = output_queue

    def run(self):

        #从队列中获取需要分析的ip
        ip = self.ip_queue.get()

        nm = nmap.PortScanner()
        try:
            ping_scan_raw = nm.scan(hosts=ip, arguments='-sn')

            for result in ping_scan_raw['scan'].values():
                if result['status']['state'] == 'up':
                    ip_up = result['addresses']['ipv4']
                    resp = {'ipv4': ip_up,
                            'state': 'UP'}
                    self.output_queue.put(resp)
                        
        except Exception as e:
            print(e)

class PingProc(Process):
    '''
    ping进程类
    '''
    def __init__(self, ip_queue, output_queue):
        super().__init__()
        self.ip_queue = ip_queue
        self.output_queue = output_queue

    def run(self):

        #从队列中获取需要分析的ip
        ip = self.ip_queue.get()

        nm = nmap.PortScanner()
        try:
            ping_scan_raw = nm.scan(hosts=ip, arguments='-sn')

            for result in ping_scan_raw['scan'].values():
                if result['status']['state'] == 'up':
                    ip_up = result['addresses']['ipv4']
                    resp = {'ipv4': ip_up,
                            'state': 'UP'}
                    self.output_queue.put(resp)
                        
        except Exception as e:
            print(e)



def port_scan_thread(ip, file_name=None, thread_num=1):
    '''
    实现端口检测功能
    '''
    #存放需要检测的端口：
    port_queue = queue.Queue()

    #存放输出结果的queue：
    output_queue = queue.Queue()

    if file_name:
        output = open(f'./{file_name}.json', 'a', encoding='utf-8')
    else:
        output = None

    threads = []

    for i in range(8000, 9000):
        port_queue.put(i)

    for _ in range(thread_num):
        thread = PortScanThread(port_queue, ip, output_queue)
        threads.append(thread)
        thread.start()

    for thread in threads:
        thread.join()

    #从队列中读取分析内容，写入文档,同时在屏幕显示出来：

    if file_name:
        f = open(f'./{file_name}.json', 'a', encoding='utf-8')
    else:
        f = None

    resp_list = []

    while True:
        if not output_queue.empty():
            resp = output_queue.get()
            port = resp['port']
            sys.stdout.write('% 6d [OPEN]\n' % port)
            resp_list.append(resp)
        else:
            break
    output_queue.task_done()

    try:
        if f:
            json.dump(resp_list, fp=f, ensure_ascii=False,  indent=4)
            f.close()
    except Exception as e:
        pass    

def port_scan_proc(ip, file_name=None, proc_num=1):
    '''
    实现端口检测功能（进程版）
    '''
    #存放需要检测的端口：
    port_queue = Queue()

    #存放输出结果的queue：
    output_queue = Queue()

    if file_name:
        output = open(f'./{file_name}.json', 'a', encoding='utf-8')
    else:
        output = None

    process = []

    for i in range(8000, 9000):
        port_queue.put(i)

    for _ in range(proc_num):
        p = PortScanProc(port_queue, ip, output_queue)
        process.append(p)
        p.start()

    for p in process:
        p.join()

    #从队列中读取分析内容，写入文档,同时在屏幕显示出来：

    if file_name:
        f = open(f'./{file_name}.json', 'a', encoding='utf-8')
    else:
        f = None

    resp_list = []

    while True:
        if not output_queue.empty():
            resp = output_queue.get()
            port = resp['port']
            sys.stdout.write('% 6d [OPEN]\n' % port)
            resp_list.append(resp)
        else:
            break

    try:
        if f:
            json.dump(resp_list, fp=f, ensure_ascii=False,  indent=4)
            f.close()
    except Exception as e:
        pass    


def ping_thread(ip, file_name=None, thread_num=1):
    '''
    实现ping功能
    '''

    ip_queue = queue.Queue()

    output_queue = queue.Queue()

    ips = ip.split('-')

    threads = []

    # 处理一个ip的情况：
    if len(ips) == 1:
        ip_queue.put(ip)
        thread = PingThread(ip_queue, output_queue)
        threads.append(thread)
        thread.start()

    # 处理ip段情况：
    elif len(ips) > 1:
        # 拆分第一个ip：
        ip_start = ips[0].split('.')
        start = int(ip_start[3])
        end = int(ips[1].split('.')[3])
        ip_list = [
            f'{ip_start[0]}.{ip_start[1]}.{ip_start[2]}.{n}' for n in range(start, end+1)]
        for ip in ip_list:
            ip_queue.put(ip)
        for _ in range(thread_num):
            thread = PingThread(ip_queue, output_queue)
            threads.append(thread)
            thread.start()

    for thread in threads:
        thread.join()

    #从队列中读取分析内容，写入文档,同时在屏幕显示出来：

    if file_name:
        f = open(f'./{file_name}.json', 'a', encoding='utf-8')
    else:
        f = None

    resp_list = []

    while True:
        if not output_queue.empty():
            resp = output_queue.get()
            ip_up = resp['ipv4']
            sys.stdout.write('%-20s [UP]\n' % ip_up)
            resp_list.append(resp)
        else:
            break
    output_queue.task_done()

    try:
        if f:
            json.dump(resp_list, fp=f, ensure_ascii=False,  indent=4)
            f.close()
    except Exception as e:
        pass

def ping_proc(ip, file_name=None, proc_num=1):
    '''
    实现ping功能(进程版)
    '''

    ip_queue = Queue()

    output_queue = Queue()

    ips = ip.split('-')

    process = []

    # 处理一个ip的情况：
    if len(ips) == 1:
        ip_queue.put(ip)
        p = PingProc(ip_queue, output_queue)
        process.append(p)
        p.start()

    # 处理ip段情况：
    elif len(ips) > 1:
        # 拆分第一个ip：
        ip_start = ips[0].split('.')
        start = int(ip_start[3])
        end = int(ips[1].split('.')[3])
        ip_list = [
            f'{ip_start[0]}.{ip_start[1]}.{ip_start[2]}.{n}' for n in range(start, end+1)]
        for ip in ip_list:
            ip_queue.put(ip)
        for _ in range(proc_num):
            p = PingProc(ip_queue, output_queue)
            process.append(p)
            p.start()

    for p in process:
        p.join()

    #从队列中读取分析内容，写入文档,同时在屏幕显示出来：

    if file_name:
        f = open(f'./{file_name}.json', 'a', encoding='utf-8')
    else:
        f = None

    resp_list = []

    while True:
        if not output_queue.empty():
            resp = output_queue.get()
            ip_up = resp['ipv4']
            sys.stdout.write('%-20s [UP]\n' % ip_up)
            resp_list.append(resp)
        else:
            break

    try:
        if f:
            json.dump(resp_list, fp=f, ensure_ascii=False,  indent=4)
            f.close()
    except Exception as e:
        pass

def time_consuming(start_time):
    stop_time = time.perf_counter()
    print('耗时：%.3f 秒' % (stop_time - start_time))

def main():
    #记录开始时间：
    start_time = time.perf_counter()
    # 设置参数：
    desc = "这是一个基于多进程或多线程模型的主机扫描器。"
    parser = argparse.ArgumentParser(description=desc)
    parser.add_argument('-v',
                        '--viewtime',
                        action='store_true', #设置True值
                        help='显示耗时。')
    parser.add_argument('-n',
                        '--num_concurrent',
                        type=int,
                        choices=range(1, 9),
                        help="指定并发数量(1-8)。")
    parser.add_argument('-f',
                        '--function',
                        type=str,
                        choices=['ping', 'tcp'],
                        required=True,  #必要的参数
                        help='ping:检测一个IP段是否可以ping通。')
    parser.add_argument('-w',
                        '--write',
                        type=str,
                        help='写入文件，请写文件名。')
    parser.add_argument('-ip',
                        '--ip',
                        type=str,
                        required=True, #必要的参数
                        help='ip地址，格式“xxx.xxx.xx.xx”,对于ping命令可用：”xxx.xxx.xx.xx-xxx.xxx.xx.xx“')
    parser.add_argument('-m',
                        '--mode',
                        type=str,
                        choices=['proc', 'thread'],
                        help='指定扫描器使用多进程(proc)或多线程(thread)模型'
                        )
    args = parser.parse_args()
    # 进入程序运行逻辑：

    # 触发tcp功能，检测端口：
    if args.function == 'tcp' and args.ip:
        if args.mode == None or args.mode == 'thread':
            port_scan_thread(args.ip, args.write, args.num_concurrent)
            #判断是否显示耗时：
            if args.viewtime == True:
                time_consuming(start_time)

        elif args.mode == 'proc':
            port_scan_proc(args.ip, args.write, args.num_concurrent)
            #判断是否显示耗时：
            if args.viewtime == True:           
                time_consuming(start_time)


    if args.function == 'ping' and args.ip:
        if args.mode == None or args.mode == 'thread':
            ping_thread(args.ip, args.write, args.num_concurrent)
            #判断是否显示耗时：
            if args.viewtime == True:
                time_consuming(start_time)

        elif args.mode == 'proc':
            ping_proc(args.ip, args.write, args.num_concurrent)
            #判断是否显示耗时：
            if args.viewtime == True:
                time_consuming(start_time)


if __name__ == '__main__':
    main()
