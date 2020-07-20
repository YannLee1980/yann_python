#Python进阶训练营第一周作业1:
#爬取猫眼电影的前 10 个电影名称、电影类型和上映时间，并以 UTF-8 字符集保存到 csv 格式的文件中

import requests
from bs4 import BeautifulSoup
import pandas as pd
import lxml.etree
import time

USER_AGENT = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.24 (KHTML, like Gecko) Chrome/19.0.1055.1 Safari/535.24"

header = {'user-agent': USER_AGENT}

url = 'https://maoyan.com/films?showType=3'


#print(resp.text)

# 在电影详细页爬取电影名等信息
def get_film_info(url):
    time.sleep(2)
    header = {'user-agent': USER_AGENT}

    resp = requests.get(url, headers=header) 
    print(resp.status_code)

    soup = BeautifulSoup(resp.text, 'html.parser')

    # xml化处理
    selector = lxml.etree.HTML(resp.text)

    # 电影名称
    film_name = soup.find('div', attrs={'class': 'movie-brief-container'}).find('h1', attrs={'class': 'name'}).text
    print(film_name)

    # 电影类型
    type_str = selector.xpath('//div[@class="movie-brief-container"]/ul/li[1]/a/text()')
    film_type = ''
    for str in type_str:
        film_type = film_type + ' ' + str
    print(film_type)

    # 上映时间
    plan_time = selector.xpath('//div[@class="movie-brief-container"]/ul/li[3]/text()')[0].strip()
    print(plan_time)

    return [film_name, film_type, plan_time]


#提取页面前十部电影的详细页链接

resp = requests.get(url, headers=header)

print('链接https://maoyan.com/films?showType=3的状态码', resp.status_code)

bs_info = BeautifulSoup(resp.text, 'html.parser')

tags = bs_info.find_all('div', attrs={'class': 'movie-item film-channel'})

movies = pd.DataFrame(columns=['Film_Name', 'Film_Type', 'Plan_Time'])
counter = 0
for a_tag in tags:
    link = 'https://maoyan.com' + a_tag.find('a').get('href')
    print(link)
    info_list = get_film_info(link)
    movies = movies.append({'Film_Name': info_list[0],
                            'Film_Type': info_list[1],
                            'Plan_Time': info_list[2]}, ignore_index=True)
    counter += 1
    if counter == 10 :
        break

movies.to_csv('./Movies_Info.csv', encoding='utf8')