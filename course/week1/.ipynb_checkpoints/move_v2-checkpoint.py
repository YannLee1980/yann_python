#爬取T250电影名和信息
import requests
import lxml.etree
import pandas as pd
from bs4 import BeautifulSoup as bs

USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36'

# 在电影详细页爬取电影名等信息
def get_film_info(url):
    header = {}
    header['user-agent'] = USER_AGENT
    resp = requests.get(url, headers=header)

    # xml化处理
    selector = lxml.etree.HTML(resp.text)

    # 电影名称
    film_name = selector.xpath('//*[@id="content"]/h1/span[1]/text()')
    #print(f'电影名：{film_name}')

    # 上映日期
    plan_date = selector.xpath('//*[@id="info"]/span[10]/text()')
    #print(f'上影日期：{plan_date}')

    # 评分
    rating = selector.xpath('//*[@id="interest_sectl"]/div[1]/div[2]/strong/text()')
    #print(f'电影评分：{rating}')

    return [film_name, plan_date, rating]

# Python 使用def定义函数，url是函数的参数
def get_url_name(url):
    movies = pd.DataFrame(columns=['Film Name', 'Plan Time', 'Rating'])

    header = {'user-agent': USER_AGENT}

    resp = requests.get(url, headers=header)

    bs_info = bs(resp.text, 'html.parser')

    # Python 中使用 for in 形式的循环,Python使用缩进来做语句块分隔
    for tags in bs_info.find_all('div', attrs={'class': 'hd'}):
        for a_tag in tags.find_all('a'):
            #获取电影详细页面链接：
            film_url = a_tag.get('href')
            #爬取该页内容：
            info_list = get_film_info(film_url)
            movies = movies.append({'Film Name': info_list[0], 
                                    'Plan Time': info_list[1],
                                    'Rating': info_list[2]}, ignore_index=True)
    
    movies.to_csv('./Movies_Info.csv', encoding='utf8')

urls = (f'https://movie.douban.com/top250?start={ 25 * i}&filter=' for i in range(10))

for url in urls:
    get_url_name(url)
