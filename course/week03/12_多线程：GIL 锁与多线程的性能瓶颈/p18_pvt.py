import multiprocessing as mp

def job(q):
    res = 0
    for i in range(1000000):
        res += i + i**2 + i**3
    q.put(res)

#多核运算：
def multicore():
    q = mp.Queue()
    p1 = mp.Process(target=job, args=(q,))
    p2 = mp.Process(target=job, args=(q,))
    p1.start()
    p2.start()
    p1.join()
    p2.join()
    res1 = q.get()
    res2 = q.get()
    print('multicore:', res1 + res2)

import threading as td

def multithread():
    q = mp.Queue()
    t1 = td.Thread(target=job, args=(q,))
    t2 = td.Thread(target=job, args=(q,))
    t1.start()
    t2.start()
    t1.join()
    t2.join()
    res1 = q.get()
    res2 = q.get()
    print('multithread:', res1 + res2)

def normal():
    res = 0
    for _ in range(2):
        for i in range(1000000):
            res += i + i**2 + i **3
    print('normal:', res)

import time

if __name__ == '__main__':
    st0 = time.time()
    normal()
    st1 = time.time()
    print('normal time:', st1 - st0)
    multicore()
    st2 = time.time()
    print('multicore time:', st2 - st1)
    multithread()
    st3 = time.time()
    print('multithread time:', st3 - st2)
    