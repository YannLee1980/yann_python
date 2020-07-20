# Python进阶训练营学习笔记
---
## 第四周：数据的清洗与预处理
### **本周内容一览：**
#### 1. pandas 简介
* 获得*.py文件的具体位置：
  `os.path.realpath(__file__)`
  `pwd = os.path.dirname(os.path.realpath(__file__))`
  `book = os.path.join(pwd,'book_utf8.csv')`
* 读csv文件，并生成dataFrame对象：
  `df = pd.read_csv(book, header=None)`
* 显示特定的行、列（注意列名需要用[]包围）
  `df.loc[13:31, ['shorts']]`**表示第14到第31行，名字为shorts的列的数据。后面列名要用列表表示。注意：索引是默认的数字索引才能这样使用，否则报错**
  `df.iloc[13:31, :2]`:**表示第14到第31行，第1到第2列的数据。**
* 过滤数据
  `df[df['star'] == '力荐']`
* 数据聚合
  `df.groupby('star').sum()`
* 把相应的类别转化成数字类型（使用map方法）：
   
      star_to_number = {
          '力荐' : 5,
          '推荐' : 4,
          '还行' : 3,
          '较差' : 2,
          '很差' : 1
      }
      df['new_star'] = df['star'].map(star_to_number)
* 课程参考资料：
>1. 获取课程源码操作方法：
切换分支：git checkout 4a
>2. pandas 中文文档：
https://www.pypandas.cn/
sklearn-pandas
>3. 安装参考文档：
https://pypi.org/project/sklearn-pandas/1.5.0/
>4. Numpy 学习文档：
https://numpy.org/doc/
>5. matplotlib 学习文档：
https://matplotlib.org/contents.html

#### 2. pandas 基本数据类型

* pd.series的map方法：
  
      emails = pd.Series(['abc at amazom.com', 'admin1@163.com', 'mat@m.at', 'ab@abc.com'])
      pattern = '[A-Za-z0-9._]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,5}' #正则表达式
      mask = emails.map(lambda x: bool(re.match(pattern, x))) #map方法把每个emeils中的元素与正则表示匹配，返回bool组成的series。
      emails[mask]  #选取True的元素，注意[]的写法。
* 课程参考资料：
  >获取课程源码操作方法：
切换分支：git checkout 4a

#### 3. pandas 数据导入
* 导入excel文件：
  
      # pip install xlrd
      # 导入excel文件
      excel1 = pd.read_excel('1.xlsx', sheet_name=0)
* 导入csv文件：
  
      book = pd.read_csv(r'book_utf8.csv', sep=',', nrows=10, encoding='utf-8', header=None)
* 导入txt文件：
  
      test_txt = pd.read_table('test.txt', sep=' ', header=None)
* 导入mysql数据：

      sql = 'SELECT * FROM tb1'
      conn = pymysql.connect(host='localhost',
                            port=3306,
                            user='root',
                            password='1234',
                            db='test')
      df_mysql = pd.read_sql(sql, conn)
* 课程参考资料：
 >获取课程源码操作方法：
切换分支：git checkout 4a

#### 4. pandas 数据预处理
* 填充和删除操作：
  
        import pandas as pd
        import numpy as np
        x = pd.Series([ 1, 2, np.nan, 3, 4, 5, 6, np.nan, 8])
        #检验序列中是否存在缺失值
        # 将缺失值填充为平均值
        x.fillna(value = x.mean())
        # 前向填充缺失
        df3=pd.DataFrame({"A":[5,3,None,4], 
                        "B":[None,2,4,3], 
                        "C":[4,3,8,5], 
                        "D":[5,4,2,None]}) 
        df3.isnull().sum() # 查看缺失值汇总
        df3.ffill() # 用上一行填充
        df3.ffill(axis=1)  # 用前一列填充
        # 缺失值删除
        df3.info()
        df3.dropna()
        # 填充缺失值
        df3.fillna('无')
        # 重复值处理
        df3.drop_duplicates()

* 课程参考资料：
>1. 获取课程源码操作方法：
切换分支：git checkout 4b
>2. Series 学习文档：
https://pandas.pydata.org/pandas-docs/stable/reference/series.html

#### 5. pandas 数据调整
* 列的选择，注意用[]包围列名：
  
      df = pd.DataFrame({"A":[5,3,None,4], 
                    "B":[None,2,4,3], 
                    "C":[4,3,8,5], 
                    "D":[5,4,2,None]}) 
      df['A'] #返回Series对象
      df[['A']] #返回只有'A'列的DataFrame对象。
      df.iloc[:5, 1:3] #数字定位
      df.loc[[0, 2], ['A', 'B']] #名字定位
* 索引重塑
 
      df4 = pd.DataFrame([
                          ['a', 'b', 'c'], 
                          ['d', 'e', 'f']
                          ],
                          columns= ['one', 'two', 'three'],
                          index = ['first', 'second']
                        )       
      df4.stack() #**以行堆叠**
      运行结果：
            first   one      a
                  two      b
                  three    c
            second  one      d
                  two      e
                  three    f
            dtype: object
      df4.unstack()  #**以列堆叠**
      df4.stack().reset_index()   #**堆叠后重置索引**
      运行结果：
            level_0	level_1	0
            0	first	one	a
            1	first	two	b
            2	first	three	c
            3	second	one	d
            4	second	two	e
            5	second	three	f
* 替换：
  
      # 多对一替换
      df.replace([4,5,8], 1000)
      # 多对多替换
      df.replace({4:400,5:500,8:800})
* 排序
  
      # 按照指定列降序排列
      df.sort_values ( by = ['A'] ,ascending = False)
      # 多列排序
      df.sort_values ( by = ['A','C'] ,ascending = [True,False])
* 删除
  
      # 删除列
      df.drop( 'A' ,axis = 1)
      # 删除行
      df.drop( 3 ,axis = 0)
      # 删除特定行
      df [  df['A'] < 4 ]
* `iloc` VS. `loc`:
  如：
  
        df.iloc[:5, 1:3] #数字定位
        df.loc[[0, 2], ['A', 'B']] #columns名或index名定位
* 课程参考资料：
>1. 获取课程源码操作方法：
切换分支：git checkout 4b
>2. DataFrame 学习文档：
https://pandas.pydata.org/pandas-docs/stable/reference/frame.html

#### 6. pandas 基本操作
* 基本操作：
  
        import pandas as pd
        df = pd.DataFrame({"A":[5,3,None,4], 
                        "B":[None,2,4,3], 
                        "C":[4,3,8,5], 
                        "D":[5,4,2,None]}) 
        # 算数运算
        # 两列之间的加减乘除
        df['A'] + df['C'] 
        # 任意一列加/减一个常数值，这一列中的所有值都加/减这个常数值
        df['A'] + 5
        # 比较运算
        df['A'] > df ['C']  
        # count非空值计数
        df.count()
        # 非空值每列求和
        df.sum()
        df['A'].sum()
        # mean求均值
        # max求最大值
        # min求最小值
        # median求中位数  
        # mode求众数
        # var求方差
        # std求标准差
* 课程参考资料：
>1. 获取课程源码操作方法：
切换分支：git checkout 4b
>2. Pandas 计算功能操作文档：
https://pandas.pydata.org/docs/user_guide/computation.html#method-summary

#### 7. pandas 分组聚合
* groupby可以理解为把dataframe分成多个子表格
  `df.groupby('type')`VS.`df.groupby('type').groups`
  
* 聚合(aggregate，或agg，意思一样)
  `data.groupby('group').aggregate('mean')` = `data.groupby('group').agg('mean')` = `data.groupby('group').mean()`
  agg的区分各列用法：`df.groupby('type').aggregate({'type': 'count', 'Feb': 'sum', 'Mar': 'mean'}) `

* agg VS. transform:
  `data.groupby('group').agg('mean')`:以各组为索引显示结果
  `data.groupby('group').transform('mean')`：以原表索引把平均值填充到各项数据中
  
* 透视表pivot_table：
  
      pd.pivot_table(  data,
                    values='salary', 
                    index='age',
                    columns='group',
                    aggfunc='count',
                    margins=True).reset_index()
      显示结果：
      group	age	x	y	z	All
      0	18	1.0	NaN	NaN	1
      1	19	2.0	NaN	NaN	2
      2	20	1.0	NaN	NaN	1
      3	22	NaN	1.0	NaN	1
      4	27	NaN	1.0	NaN	1
      5	29	NaN	1.0	NaN	1
      6	42	NaN	1.0	NaN	1
      7	45	NaN	1.0	NaN	1
      8	47	NaN	NaN	1.0	1
      9	All	4.0	5.0	1.0	10
* 课程参考资料：
>获取课程源码操作方法：
切换分支：git checkout 4b

#### 8. pandas 多表拼接
* 注意：merge中的参数理解：on,how,left_on,right_on
  
      import pandas as pd
      import numpy as np
      group = ['x','y','z']
      data1 = pd.DataFrame({
      "group":[group[x] for x in np.random.randint(0,len(group),10)] ,
      "age":np.random.randint(15,50,10)
      })
      data2 = pd.DataFrame({
      "group":[group[x] for x in np.random.randint(0,len(group),10)] ,
      "salary":np.random.randint(5,50,10),
      })
      data3 = pd.DataFrame({
      "group":[group[x] for x in np.random.randint(0,len(group),10)] ,
      "age":np.random.randint(15,50,10),
      "salary":np.random.randint(5,50,10),
      })
      # 一对一
      pd.merge(data1, data2)
      # 多对一
      pd.merge(data3, data2, on='group')
      # 多对多
      pd.merge(data3, data2)
      # 连接键类型，解决没有公共列问题
      pd.merge(data3, data2, left_on= 'age', right_on='salary')
      # 连接方式
      # 内连接，不指明连接方式，默认都是内连接
      pd.merge(data3, data2, on= 'group', how='inner')
      # 左连接 left
      # 右连接 right
      # 外连接 outer
      # 纵向拼接
      pd.concat([data1, data2])
* 课程参考资料：
>1. 获取课程源码操作方法：
切换分支：git checkout 4b
>2. MySQL 数据库多表连接学习文档：
https://dev.mysql.com/doc/refman/8.0/en/join.html

9. pandas 输出和绘图
* 编码：
  Linux or mac ：utf-8;
  windows : GBK
* 输出格式：
  pickle('*.pkl')处理速度是exl的10倍
* agg最好用内置的函数，它比lambda的速度快很多。 
* 课程参考资料：
>1. 获取课程源码操作方法：
切换分支：git checkout 4b
>2. plot 学习文档：
https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.plot.html
>3. seaborn 学习文档：
http://seaborn.pydata.org/tutorial.html

#### 10. jieba分词与提取关键词
* 分词：
  
      result = jieba.cut(string, cut_all=False) # 精确模式
      result = jieba.cut(string, cut_all=True) # 全模式
      result = jieba.cut_for_search(string） # 搜索引擎模式
* 提取关键词：
  
      import jieba.analyse
      text = ***
      # 基于TF-IDF算法进行关键词抽取
      tfidf = jieba.analyse.extract_tags(text,
      topK=5,                   # 权重最大的topK个关键词
      withWeight=True)         # 返回每个关键字的权重值
      # 基于TextRank算法进行关键词抽取
      textrank = jieba.analyse.textrank(text,
      topK=5,                   # 权重最大的topK个关键词
      withWeight=False)         # 返回每个关键字的权重值
* 设置停用词：
  `jieba.analyse.set_stop_words(stop_words_path)`:停用词放进txt文件中
  `jieba.add_word('极客大学')`: 动态自定义词典
  `jieba.del_word('自定义词')`：# 动态删除词典

* 调整分词（合并，分开）：
  
      # 关闭自动计算词频
      result = jieba.cut(string2, cut_all=False, HMM=False)
      # 调整分词，合并
      jieba.suggest_freq('中出', True)
      jieba.suggest_freq(('中', '将'), True)
* 课程参考资料：
>1. 获取课程源码操作方法：
切换分支：git checkout 4c
>2. jieba 学习文档：
https://github.com/fxsjy/jieba/blob/master/README.md

#### 11. SnowNLP情感倾向分析
* pandas的apply()方法：
  
      # 封装一个情感分析的函数
      def _sentiment(text):
      s = SnowNLP(text)
      return s.sentiments
      df["sentiment"] = df.shorts.apply(_sentiment)
* SnowNLP的基本用法：
  
      from snownlp import SnowNLP
      text = '其实故事本来真的只值三星当初的中篇就足够了但是啊看到最后我又一次被东野叔的反战思想打动了所以就加多一星吧'
      s = SnowNLP(text)
      # 1 中文分词
      s.words
      # 2 词性标注 (隐马尔可夫模型)
      list(s.tags)
      # 3 情感分析（朴素贝叶斯分类器）
      s.sentiments
      text2 = '这本书烂透了'
      s2 = SnowNLP(text2)
      s2.sentiments
      # 4 拼音（Trie树）
      s.pinyin
      # 5 繁体转简体
      text3 = '後面這些是繁體字'
      s3 = SnowNLP(text3)
      s3.han
      # 6 提取关键字
      s.keywords(limit=5)
      # 7 信息衡量
      s.tf # 词频越大越重要
      s.idf # 包含此条的文档越少，n越小，idf越大，说明词条t越重要
      # 8 训练
      from snownlp import seg
      seg.train('data.txt')
      seg.save('seg.marshal')
      # 修改snownlp/seg/__init__.py的 data_path 指向新的模型即可
* 课程参考资料：
>1. 获取课程源码操作方法：
切换分支：git checkout 4c
>2. snowNLP 参考学习地址：
https://github.com/isnowfy/snownlp/blob/master/README.md

#### 作业：
* `SELECT id,COUNT(DISTINCT order_id) FROM table1 GROUP BY id;`:
  `table1.groupby('id')['order_id'].nunique()` #nunique()唯一值的个数。
  

### 疑问：
1. map的使用比较模糊！
2. agg能用哪些函数？
3. pivot_table需要进一步了解。
4. SnowNLP的训练模型如何准备数据格式。
5. merge中的inner和outer需要加深理解：
   * inner：两数据表on字段的交集的数据进行合并；
   * outer：两数据表on字段的并集的数据进行合并。
   * 相当于SQL语句：INNER JOIN
6. SQL中的union VS. union all:
   * UNION: 堆叠两数据表，并去重；
   * UNION ALL: 堆叠两数据表，不去重。
   * 相当于pandas的concat、append。

### **学习心得：**
&emsp;&emsp; 本周的作业不算多，但真正需要掌握的知识不少，pandas中的操作需要本质上理解才不会混乱。数据处理应该对于机器学习的效果影响比较大，怎样处理好原始数据以用于机器学习，一定是工作中很重要的一环。课程中介绍到的SnowNLP和jieba两个中文语言处理工具很实用，可能如果要用到实际中，还需要利用实际应用场景的数据进一步训练才能真正发挥很好的实用价值。

<p align="right">学员：李志源</p>
<p align="right">2020年7月17日</p>
