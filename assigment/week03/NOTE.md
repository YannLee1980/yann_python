# Python进阶训练营学习笔记
---
## 第三周：scrapy框架深度解析
### **本周内容一览：**
#### 1. Scrapy 并发参数优化原理：
* scrapy 的异步设置：
  ![avatar](./note_images/note_1.png)
* 同步请求和异步请求的概念：
  同步请求：如，requests请求，需要等待请求返回才进行下一次的请求；
  异步请求：如，scrapy，一个请求没返回也可以执行下一个请求。
* twisted是异步编程模型，任务之间互相独立：
  ![avatar](./note_images/note_2.png)
* 课程中的twisted_demo例子：
  
      from twisted.internet import defer
      from twisted.internet import reactor
      from twisted.web.client import getPage
      def response(*args, **kwargs):
        print('返回网页内容：')
        print(args, kwargs)
      def callback(*args):
        print('执行一个回调。')
      @defer.inlineCallbacks
      def start(url):
        d = getPage(url.encode('utf-8'))
        d.addCallback(response)
        d.addCallback(callback)
        yield d
      def stop(*args, **kwargs):
        reactor.stop()
  可以简单理解为，把所需的任务列队，然后丢给reactor：

      urls = ['http://www.baidu.com','http://www.sougou.com']
      li = []
      for url in urls:
        ret = start(url) #实现@defer.inlineCallbacks的start()
        li.append(ret)
      print(li)
      d = defer.DeferredList(li)
      d.addBoth(stop) #实现@defer.inlineCallbacks的stop()
      reactor.run()
* 课程参考资料：   
>1. 获取课程源码操作方法：
切换分支：git checkout 3c
>2. Twisted 学习参考文档：
https://pypi.org/project/Twisted/
>3. asyncio — 异步 I/O 学习文档
https://docs.python.org/zh-cn/3.7/library/asyncio.html

#### 2. 多进程：进程的创建
* 概念：
  单任务、多任务、同步、异步、多进程、父进程、子进程
  函数也是对象，具体说来是可调用对象，函数名+()表示调用函数
* 进程调用的两种形式：  
  1. os.fork():了解底层运作；
  2. multiprocessing.Process : 高级封装。
* os.fork()的返回值：
  fork()运行时，会有2种返回值，返回值为大于0时，此进程为父进程，且返回的数字为子进程的PID；当返回值为0时，此进程为子进程。

        res = os.fork()
        print(f'res == {res}')
        if res == 0:
          print(f'我是子进程,我的pid是:{os.getpid()}我的父进程id是:{os.getppid()}')
        else:
          print(f'我是父进程,我的pid是: {os.getpid()}')
      <运行结果>
      res == 2044
      我是父进程,我的pid是: 1963
      res == 0
      我是子进程,我的pid是:2044我的父进程id是:1963
* 注意Process的args参数：
  
      if __name__ == '__main__':
        p = Process(target=f, args=('Yann',))  #args的格式是元组，kwargs的格式是字典。
        p.start()
        p.join(timeout=3)  #主进程等待子进程结束才自己接着往下运行，注意join()放置的位置！
* join()的作用：主进程等待子进程结束才自己接着往下运行，注意join()放置的位置！
* 课程参考资料：
>1. 获取课程源码操作方法：
切换分支：git checkout 3c
>2. os 模块学习文档：
https://docs.python.org/zh-cn/3.7/tutorial/stdlib.html#operating-system-interface
>3. multiprocessing – 基于进程的并行学习文档： https://docs.python.org/zh-cn/3.7/library/multiprocessing.html 

#### 3. 多进程：多进程程序调试技巧
* python文件的运行方式：
  
      #文件：test.py
      def test():
        print('In test()')
        print(__name__)
      print(__name__)
  1. 单独运行：
     命令：python test.py

          __name__ : __main__
  2. 作为模块运行：
     命令：python -m test.py 或 被引入：import test

          __name__ : test
* 程序创建进程的最佳数量：
  先获得系统的核心数：multiprocessing.cpu_count()   
  因为一个进程占用了一个核心，所进程数量不要超过核心数，最佳为核心数量。    
* 获取当前活动的子进程： multiprocessing.active_children()
* 创建进程的两个方法：
  1. 创建Process（）对象，通过target传递函数方法；
  2. 继承Process类，实现run（）方法。
* 课程参考资料：
>1. 获取课程源码操作方法：
切换分支：git checkout 3c

#### 4. 多进程：使用队列实现进程间的通信
* 队列Queue:
  1. get:  'Queue.get(block=True, timeout=None)'  
   从队列中取出并返回对象。如果可选参数 block 是 True (默认值) 而且 timeout 是 None (默认值), 将会阻塞当前进程，直到队列中出现可用的对象。如果 timeout 是正数，将会在阻塞了最多 timeout 秒之后还是没有可用的对象时抛出 queue.Empty 异常。反之 (block 是 False 时)，仅当有可用对象能够取出时返回，否则抛出 queue.Empty 异常 (在这种情形下 timeout 参数会被忽略)。
  2. put:  'Queue.put(item, block=True, timeout=None)'  
   将 item 放入队列。如果可选参数 block 是 true 并且 timeout 是 None (默认)，则在必要时阻塞至有空闲插槽可用。如果 timeout 是个正数，将最多阻塞 timeout 秒，如果在这段时间没有可用的空闲插槽，将引发 Full 异常。反之 (block 是 false)，如果空闲插槽立即可用，则把 item 放入队列，否则引发 Full 异常 ( 在这种情况下，timeout 将被忽略)。
* 进程中断：terminate()
* 课程参考资料：
>1. 获取课程源码操作方法：
切换分支：git checkout 3c
>2. 进程之间的两种通信通道：
https://docs.python.org/zh-cn/3.7/library/multiprocessing.html#exchanging-objects-between-processes

#### 5. 多进程：管道共享内存
* 管道:
  Queue的底层。返回的两个连接对象 Pipe() 表示管道的两端。每个连接对象都有 send() 和 recv() 方法（相互之间的）。请注意，**如果两个进程（或线程）同时尝试读取或写入管道的 同一 端，则管道中的数据可能会损坏**。当然，同时使用管道的不同端的进程不存在损坏的风险。
* 共享内存：
  在进行并发编程时，**通常最好尽量避免使用共享状态**。共享内存 shared memory 可以使用 Value 或 Array 将数据存储在共享内存映射中这里的Array和numpy中的不同，**它只能是一维的，不能是多维的**。同样和Value 一样，需要**定义数据**形式，否则会报错。
* 课程参考资料：
>1. 获取课程源码操作方法：
切换分支：git checkout 3c
>2. 进程之间的两种通信通道：
https://docs.python.org/zh-cn/3.7/library/multiprocessing.html#exchanging-objects-between-processes
>3. 管道和队列参考文档：
https://docs.python.org/zh-cn/3.7/library/multiprocessing.html#pipes-and-queues

#### 6. 多进程：锁机制解决资源抢占
* 锁机制
  创建锁： `lock = multiprocessing.Lock()`
  锁住：`lock.acquire()`
  解锁：`lock.release()` 
* 在某些特定的场景下要共享string类型，方式如下：
  
      from ctypes import c_char_p
      str_val = mp.Value(c_char_p, b"Hello World")
* 课程参考资料：
>1. 获取课程源码操作方法：
切换分支：git checkout 3c
>2. 进程间的同步学习文档：
https://docs.python.org/zh-cn/3.7/library/multiprocessing.html#synchronization-between-processes

#### 7. 多进程：进程池
* 进程池的使用：
  创建：`p = Pool(processes)`,processes为进程池的进程数
  运行：`p.apply_async(func=run, args=(i,))`
  结束： 

        p.close()   
        p.join()  # 进程池对象调用join，会等待进程池中所有的子进程结束完毕再去结束父进程，放在close或terminate的后面。
        p.terminate()  
* 注意：`close()`：如果我们用的是进程池，在调用`join()`之前必须要先`close()`，并且在`close()`之后不能再继续往进程池添加新的进程`join()`：进程池对象调用`join`，会等待进程池中所有的子进程结束完毕再去结束父进程.`terminate()`：一旦运行到此步，不管任务是否完成，立即终止。
* `p.apply_async`VS.`p.apply`:
  `p.apply_async`:异步运行；
  `p.apply`:同步运行，也就顺序运行。
* `p.close()` VS. `p.terminate()`:
  `p.close()`:等待p完成才关闭；
  `p.terminate()`:不等待p完成，直接中断。
* 避免死锁：
  注意逻辑和join放置的位置。
* Pool的with写法：
  
      with Pool(processes=4) as p:
        result = p.apply_async(func=f, args=(10,))
        print(result.get(timeout=2))
        result = p.apply_async(func=time.sleep, args=(10,))
        print(result.get(timeout=1))
* 进程池的map()、imap():
  
      with Pool(processes=4) as pool:         # 进程池包含4个进程
        print(pool.map(f, range(10)))       # 输出 "[0, 1, 4,..., 81]"
        it = pool.imap(f, range(10))        # map输出列表，imap输出迭代器             
        print(next(it))   
* 课程参考资料：
>1. 获取课程源码操作方法：
切换分支：git checkout 3c
>2. 进程池学习文档：
https://docs.python.org/zh-cn/3.7/library/multiprocessing.html#module-multiprocessing.pool
>3. 迭代器学习文档：
https://docs.python.org/zh-cn/3.7/library/stdtypes.html#iterator-types

#### 8. 多线程：创建线程
* 概念：
  1. 调用方
    阻塞：  得到调用结果之前，线程会被挂起
    非阻塞： 不能立即得到结果，不会阻塞线程
  2. 被调用方 
    同步： 得到结果之前，调用不会返回
    异步： 请求发出后，调用立即返回，没有返回结果，通过回调函数得到实际结果
  3. 并发、并行：
    
  4. 进程、线程的区别
  5. 协程

* 课程参考资料：
>1. 获取课程源码操作方法：
切换分支：git checkout 3c
>2. 基于线程的并行学习文档：
https://docs.python.org/zh-cn/3.7/library/threading.html
>3. 基于进程的并行学习文档：
https://docs.python.org/zh-cn/3.7/library/multiprocessing.html
>4. 底层多线程 API：
https://docs.python.org/zh-cn/3.7/library/_thread.html

### **学习心得：**



<p align="right">学员：李志源</p>
<p align="right">2020年7月4日</p>
