# 爬取页面详细信息
import requests
import lxml.etree

# 电影详细页面
url = 'https://movie.douban.com/subject/1292052/'

user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36'

# 声明为字典使用字典的语法赋值
header = {}
header['user-agent'] = user_agent
resp = requests.get(url, headers=header)

# xml化处理
selector = lxml.etree.HTML(resp.text)

# 电影名称
film_name = selector.xpath('//*[@id="content"]/h1/span[1]/text()')
print(f'电影名：{film_name}')

# 上映日期
plan_date = selector.xpath('//*[@id="info"]/span[10]/text()')
print(f'上影日期：{plan_date}')

# 评分
rating = selector.xpath('//*[@id="interest_sectl"]/div[1]/div[2]/strong/text()')
print(f'电影评分：{rating}')

#保存到文档
import pandas as pd

mylist = [film_name, plan_date, rating]

move1 = pd.DataFrame(mylist)

# windows需要使用gbk字符集
move1.to_csv('./Move1.csv', encoding='utf8', index=False, header=False)
