# Python进阶训练营学习笔记
---
## 第二周：掌握scrapy爬虫框架
### **本周内容一览：**
#### 1. 异常捕获与处理：   
* 异常处理注意：
        def f1():
            1/0
        def f2():
            list1 = []
            list1[1]    
            f1()
        def f3():
            f2()
        try:
            f3()
        except (ZeroDivisionError,Exception) as e:
            print(e)

  只捕获list1[1]产生的错误，捕获不了f1()产生的错误。
* 魔术方法：   
  类可以当字符串用直接print（），实现的方法是__str__().    
  类中的__call__()作用是把类伪装成函数使用，如：
* 美化错误输出库： pretty_errors
* 课程参考资源：

>1. 获取课程源码操作方法：
git checkout 2d
2. pretty_errors 官方文档链接：
https://pypi.org/project/pretty-errors/
3. try 语句官方文档：
https://docs.python.org/zh-cn/3.7/reference/compound_stmts.html#the-try-statement
4. with 语句官方文档：
https://docs.python.org/zh-cn/3.7/reference/compound_stmts.html#the-with-statement
5. with 语句上下文管理器官方文档：
https://docs.python.org/zh-cn/3.7/reference/datamodel.html#with-statement-context-managers

#### 2. 使用PyMySQL进行数据库操作
* Python 与mysql链接最好用pymysql库

* 链接MYSQL命令：   
  启动mysql：/usr/local/mysql/support-      files/mysql.server start
  停掉mysql： /usr/local/mysql/bin/mysqladmin -u root -p shutdown
  查看mysql有没有运行：ps -ef | grep mysql
  链接mysql：/usr/local/mysql/bin/mysql -u root -p
* type hint, 类型提示：   
   如：host: str=…
* mysql的基本操作：   
  mysql> CREATE DATABASE test_db;
* 课程参考资源：

>1. 获取课程源码操作方法：
git checkout 2d
2. MySQL 官方文档手册：
https://dev.mysql.com/doc/
3. MySQL 官方下载连接：
https://www.mysql.com/downloads/
4. PyMySQL 官方文档:
https://pypi.org/project/PyMySQL/

#### 3.反爬虫：模拟浏览器的头部信息
* 库fake-useragent:UserAgent()中的verify_ssl = False：不下载常用的UserAgent。
* 反爬虫一般会检测这三个参数：referer、user_agent、host
* 浏览器上直接写地址请求的方式是get的方式
* status code:302—表示客户端进行跳转
* fake-useragent库：自动生成user-agent
* 课程参考资源：

>1. 获取课程源码操作方法：
切换分支：git checkout 2e
2. User-Agent 参考文档：
https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Headers/User-Agent

#### 4. 反爬虫：cookies验证

* requests.Session的作用是保持cookies的一致
* daouban.com改版，post请求需要加入cookies：
  通过get得到cookies：session.get(login_url, headers=headers),从刚才的s中获得cookies，放入参数中：response = s.post(login_url, data=form_data, headers=headers, cookies=s.cookies)
* 课程参考资源：

>1. 获取课程源码操作方法：
切换分支：git checkout 2e
2. httpbin 网址：
https://httpbin.org/

#### 5. 反爬虫：使用WebDriver模拟浏览器行为
* WebDriver:与浏览器进行联动，模拟浏览器的行为
  from selenium import webdriver
* 课程参考资源：

>1. 获取课程源码操作方法： 切换分支：git checkout 2e
2. WebDriver 文档：
  https://www.w3.org/TR/webdriver/
  https://www.selenium.dev/selenium/docs/api/py/
3. ChromeDriver 下载地址：      https://chromedriver.storage.googleapis.com/index.html

#### 6. 反爬虫：验证码识别
* 安装依赖库libpng, jpeg, libtiff, leptonica(支持的图形格式)
  brew install leptonica  
  安装tesseract（c图形-文字识别工具）  
  brew install  tesseract  
  与python对接需要安装的包  
  pip3 install Pillow  
  pip3 install pytesseract  
* 课程参考资源：

>1. 获取课程源码操作方法：
切换分支：git checkout 2e
2. 各种语言识别库：
https://github.com/tesseract-ocr/tessdata

#### 7. 爬虫中间件&系统代理IP
* HttpProxyMiddleware内部的实行顺序：
  from_crawler()   —> __init__() —> 其它方法
* 课程参考资源：
>切换分支：git checkout 3a

#### 8. 自定义中间件&随机代理IP
* 课程参考资源：
>切换分支：git checkout 3a

#### 9. 分布式爬虫

* redis集群:
  安装redis、scrapy-redis
* redis.conf:
  Demonize yes: 表示虽然关闭也不会停掉服务。
  运行服务端：Redis-server redis.conf，运行客户端：redis-cli
  control+D:退出
*  redis 存储了item
        #  bash$  redis-cli
        #  redis> keys *
        #  redis> type cluster:items
        #  redis> lpop cluster:items
        #  redis> keys *
*  scrapy的settings：
        # redis信息
        REDIS_HOST = '127.0.0.1'
        REDIS_PORT = 6379
        # Scheduler的QUEUE
        SCHEDULER = 'scrapy_redis.scheduler.Scheduler'
        # 去重
        DUPEFILTER_CLASS = "scrapy_redis.dupefilter.RFPDupeFilter"
        # Requests的默认优先级队列
        SCHEDULER_QUEUE_CLASS = 'scrapy_redis.queue.PriorityQueue'
        # 将Requests队列持久化到Redis，可支持暂停或重启爬虫
        SCHEDULER_PERSIST = True
        # 将爬取到的items保存到Redis
        ITEM_PIPELINES = {
            'scrapy_redis.pipelines.RedisPipeline': 300
        }
*  课程参考资源：

>1. 获取课程源码操作方法：
切换分支：git checkout 3b
2. redis 官方网址：
https://redis.io/
### **学习心得：**

本周，老师介绍了python异常处理机制、通过pymsql库与数据库链接、反爬虫的初步知识（模拟浏览器的头部信息、cookies验证、用webdriver模拟浏览器的行为、验证码识别）、scrapy的中间件定义和使用代理、分布式爬虫的初步认识。其中涉及到的库有:pretty_errors、pymysql、fake-useragent、selenuim WebDriver、tesseract、pytesseract、Pillow、redis、scrapy-redis。
这些内容为建立一个实战的爬虫应用打下基本，也是下周内容需要使用的，可见真正的实践开发所需要掌握的技能的全面性。这为我学习提供了方向感，也需要我多一分的耐心。

<p align="right">学员：李志源</p>
<p align="right">2020年7月4日</p>
