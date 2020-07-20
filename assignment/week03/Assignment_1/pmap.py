#-*-coding:utf-8-*-

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

class PortScan(threading.Thread):
    def __init__(self, port_queue, ip, file=None, timeout=3):
        '''
        初始化参数
        '''
        super().__init__()
        self.port_queue = port_queue
        self.ip = ip
        self.timeout = timeout
        self.file = file
        
    def run(self):
        '''
        多线程实际调用的方法，如果端口队列不为空，循环执行
        '''
        while True:
            if self.port_queue.empty():
                break

            OPEN_MSG = '% 6d [OPEN]\n'

            port = self.port_queue.get(timeout=0.5)

            try:
                s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                s.settimeout(self.timeout)
                result_code = s.connect_ex((self.ip, port))
                if result_code == 0:
                    sys.stdout.write(OPEN_MSG % port)
                    if self.file:
                        resp = {'port': port,
                                'state': 'OPEN'}
                        json.dump(resp, fp=self.file, ensure_ascii=False)
            except Exception as e:
                print("error", e)
            finally:
                s.close()

class PingThread(threading.Thread):
    def __init__(self, ip_queue, file=None):
        super().__init__()
        self.ip_queue = ip_queue
        self.file = file

    def run(self):
        UP_MSG = '%-20s [UP]\n'
        
        ip = self.ip_queue.get()
        nm = nmap.PortScanner()
        try:
            ping_scan_raw = nm.scan(hosts=ip, arguments='-sn')
        
            for result in ping_scan_raw['scan'].values():
                if result['status']['state'] == 'up':
                    ip_up = result['addresses']['ipv4']
                    sys.stdout.write(UP_MSG % ip_up)
                    if self.file:
                        resp = {'ipv4': ip_up,
                                'state': 'UP'}
                        json.dump(resp, fp=self.file, ensure_ascii=False)
        except Exception as e:
            print(e)
        

def portScan(ip, file_name=None, thread_num=1):
    port_queue = queue.Queue()

    if file_name:
        output = open(f'./{file_name}.json', 'a', encoding='utf-8')
    else:
        output = None
    
    threads = []

    for i in range(1, 9999):
        port_queue.put(i)

    for _ in range(thread_num):
        thread = PortScan(port_queue, ip, output)
        threads.append(thread)
        thread.start()
    
    for thread in threads:
        thread.join()

    try:
        if output:
            output.close()
    except Exception as e:
        pass

def ping(ip, file_name, thread_num=1):

    ip_queue = queue.Queue()

    if file_name:
        output = open(f'./{file_name}.json', 'a', encoding='utf-8')
    else:
        output = None

    ips = ip.split('-')

    threads = []

    #处理一个ip的情况：
    if len(ips) == 1:
        ip_queue.put(ip)
        thread = PingThread(ip_queue, output)
        threads.append(thread)
        thread.start()

    #处理ip段情况：
    elif len(ips) >1:
        #拆分第一个ip：
        ip_start = ips[0].split('.')
        start = int(ip_start[3])
        end = int(ips[1].split('.')[3])
        ip_list = [f'{ip_start[0]}.{ip_start[1]}.{ip_start[2]}.{n}' for n in range(start, end+1)]
        for ip in ip_list:
            ip_queue.put(ip)
        for _ in range(thread_num):
            thread = PingThread(ip_queue, output)
            threads.append(thread)
            thread.start()

    for thread in threads:
        thread.join()

    try:
        if output:
            output.close()
    except Exception as e:
        pass

def main():
    #设置参数：
    desc = "这是一个基于多进程或多线程模型的主机扫描器。"
    parser = argparse.ArgumentParser(description=desc)
    parser.add_argument('-n', 
                        '--num_concurrent', 
                        type=int, 
                        choices=range(1, 11),
                        help="指定并发数量(1-10)。")
    parser.add_argument('-f', 
                        '--function', 
                        type=str, 
                        choices=['ping', 'tcp'], 
                        help='ping:检测一个IP段是否可以ping通。')
    parser.add_argument('-w',
                        '--write',
                        type=str,
                        help='写入文件，请写文件名。')
    parser.add_argument('-ip',
                        '--ip',
                        type=str,
                        help='ip地址，格式“xxx.xxx.xx.xx”,对于ping命令可用：”xxx.xxx.xx.xx-xxx.xxx.xx.xx“')
    args = parser.parse_args()
    #进入程序运行逻辑：
    #触发tcp功能，检测端口：
    if args.function=='tcp' and args.ip:
        portScan(args.ip, args.write, args.num_concurrent)

    if args.function=='ping' and args.ip:
        ping(args.ip, args.write, args.num_concurrent)

if __name__ =='__main__':
    main()
