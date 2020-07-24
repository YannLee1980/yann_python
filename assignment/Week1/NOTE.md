# Python进阶训练营学习笔记
---
## 第一周：使用python库获取豆瓣影评
### **本周内容一览：**
我带着能成为深度学习工程师的目标来到了Python进阶训练营，本周是训练营的第一周，课程的开始就是围绕着Python库进行实践的，同时也穿插了Python一些特有的语言特性：
>requests库：相比于Python内建的HTTP服务库urllib，requests的使用gen更简洁明了。

    import requests
    user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36'
    header = {'user-agent': user_agent}
    myurl = 'https://movie.douban.com/top250'
    response = requests.get(myurl, headers=header)

>BeautifulSoup的bs4库：从html文件或xml提取数据的Python库。

    for tags in bs_info.find_all('div', attrs={'class': 'hd'}):
        for a_tag in tags.find_all('a'):
            #获取链接：
            print(a_tag.get('href'))
            #获取电影名：
            print(a_tag.find('span').text)

>Xpath: 一门在 XML 文档中查找信息的语言。

    import lxml.etree
    # xml化处理
    selector = lxml.etree.HTML(resp.text)
    # 电影名称
    film_name = selector.xpath('//*[@id="content"]/h1/span[1]/text()')

>scrapy框架：提供一套爬虫的专业框架方案，它由各个不同的组件构成。

![avatar](https://docs.scrapy.org/en/latest/_images/scrapy_architecture_02.png)

>>scrapy几条常用命令：

        scrapy startproject <项目名称>
        scrapy genspider <爬虫名称> #一个项目中可以有多个spider
        scrapy crawl <爬虫名称> #运行一个爬虫
        scrapy view "<url>" #在浏览器中显示爬虫程序获取的url

>>scrapy自带的xpath解析器：

        from scrapy.selector import Selector
        def parse(self, response):
            tags = Selector(response=response).xpath('//div[@class="movie-item film-channel"]')

>>scrapy框架构建的注意项：
>>>scrapy.Spider对象：

        #定义start_requests()时，用yield生成scrapy.Request:
        def start_requests(self):
            url = 'https://maoyan.com/films?showType=3'
            yield scrapy.Request(url=url, callback=self.parse)
            #若需要携带item对象：
            item = SpidersItem()
            yield scrapy.Request(url=link, callback=self.parse，meta={'item':item})
        #用parse()实现分析细节：
        def parse(self, response):
            ...
            #提取item：
            item = response.meta['item']
            #注意yield item：
            yield item
>>>scrapy.Item对象：

        #定义item名目：
        class Assigment2Item(scrapy.Item):
            film_name = scrapy.Field()
            film_type = scrapy.Field()
            plan_time = scrapy.Field()
>>>settings.py设置：

        #设置下载延时：
        DOWNLOAD_DELAY = 2

        #变换USER-AGENT：
        USER_AGENT_LIST=[...]
        import random
        USER_AGENT = random.choice(USER_AGENT_LIST)
>>>pipelines.py实现输出：

        #实现process_item(),必须返回item
        def process_item(self, item, spider):
            ...
            return item
        
        #在settings.py中设置：
        ITEM_PIPELINES = {
            'assigment_2.pipelines.Assigment2Pipeline': 300,
        }


### **学习心得：**
>本周的学习让我体会到利用框架完成应用的基本过程，其中涉及到自己陌生的内容、不理解的流程、不熟悉库调用等等，最深刻的是在完成作业遇到各种问题时，从焦虑、不解、求助到解决的整个跌宕过程，当一个人在不断尝试仍然失败时难免会有失落情绪，但能得到同学、老师的帮助时，喜悦油然而生。这让我思考我应该如何对待之后的学习和工作：  
>**首先**，真的要耐心的阅读各种库的说明文档，基本理解各框架的工作原理，当然这是我之前最害怕去做的事情；  
>**然后**，在遇到问题时，要利用专业的测试、排疑方法，一步一步有逻辑的找到问题所在，勇于像别人寻求帮助，从而解决问题；  
>**最后**，也是最重要的一条，就是主动帮助别人解决问题，这不但不会浪费自己的时间，这更是一个让自己学到更多的机会，而且很有可能正好帮助一个在学习中遇到问题而失落的人，那何乐而不为呢！

<p align="right">学员：李志源</p>
<p align="right">2020年6月28日</p>
