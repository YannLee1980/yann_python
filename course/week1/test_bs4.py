# 使用BeautifulSoup解析网页
import requests
from bs4 import BeautifulSoup as bs
# bs4是第三方库需要使用pip命令安装

user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36'

header = {'user-agent': user_agent}

url = 'https://movie.douban.com/top250'

resp = requests.get(url, headers=header)

bs_info = bs(resp.text, 'html.parser')

# Python 中使用 for in 形式的循环,Python使用缩进来做语句块分隔
for tags in bs_info.find_all('div', attrs={'class': 'hd'}):
    for a_tag in tags.find_all('a'):
        #获取链接：
        print(a_tag.get('href'))
        #获取电影名：
        print(a_tag.find('span').text)