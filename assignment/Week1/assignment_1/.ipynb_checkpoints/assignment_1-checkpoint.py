'''
作业1.安装并使用 requests、bs4 库，爬取猫眼电影（）的前 10 个电影名称、电影类型和上映时间，
并以 UTF-8 字符集保存到 csv 格式的文件中。
'''
import requests
import pandas as pd
import time
from bs4 import BeautifulSoup
from fake_useragent import UserAgent

#随机生成UserAgent：
ua = UserAgent(verify_ssl=False)

headers = {'user-agent': ua.random}

url = 'https://maoyan.com/films?showType=3'

#获取页面：
resp = requests.get(url, headers=headers)

#显示返回状态：
print(f'状态：{resp.status_code}')

#创建BeautifulSoup对象：
soup = BeautifulSoup(resp.text, 'html.parser')

#提取详细信息：
films = []
#计数器：
count = 0
#找到电影栏目
for tag in soup.find_all('div', attrs={'class': 'movie-item film-channel'}):
    #只获取前10部电影：
    count += 1
    if count > 10:
        break
    #在每个栏目里获取详细信息：
    details = tag.find_all('div', attrs={'class': 'movie-hover-title'})
    film_name = details[0].find('span', attrs={'class': "name"}).text
    film_type = details[1].text.split('\n')[2].strip()
    plan_time = details[3].text.split('\n')[2].strip()
    films.append({'film_name': film_name,
                  'film_type': film_type,
                  'plan_time': plan_time})
    
#用获取的数据创建dataframe：
df = pd.DataFrame(films)
df.columns = ['电影名', '类型', '上映时间']

#用.csv文件保存结果：
df.to_csv('./Movies_Info.csv', encoding='utf8', index=False)