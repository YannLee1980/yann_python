## 第四周作业
* 作业背景：在数据处理的步骤中，可以使用 SQL 语句或者 pandas 加 Python 库、函数等方式进行数据的清洗和处理工作。因此需要你能够掌握基本的 SQL 语句和 pandas 等价的语句，利用 Python 的函数高效地做聚合等操作。
* 作业要求：请将以下的 SQL 语句翻译成 pandas 语句：


```python
import pandas as pd
import numpy as np
from sqlalchemy import create_engine
import pymysql
```


```python
#建立与数据库的链接
engine = create_engine('mysql+pymysql://root:1234@localhost:3306/week4_assignment')
```


```python
#生成数据表data的数据
data = pd.DataFrame({
    'id': range(1500),
    'age': np.random.randint(20, 55, size=1500)
})
data.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>age</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0</td>
      <td>30</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1</td>
      <td>47</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2</td>
      <td>29</td>
    </tr>
    <tr>
      <th>3</th>
      <td>3</td>
      <td>48</td>
    </tr>
    <tr>
      <th>4</th>
      <td>4</td>
      <td>32</td>
    </tr>
  </tbody>
</table>
</div>




```python
#导入到数据库data表中
data.to_sql('data', engine, if_exists='replace', index=False)
```

### 1. SELECT * FROM data;


```python
data  #print(data)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>age</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0</td>
      <td>30</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1</td>
      <td>47</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2</td>
      <td>29</td>
    </tr>
    <tr>
      <th>3</th>
      <td>3</td>
      <td>48</td>
    </tr>
    <tr>
      <th>4</th>
      <td>4</td>
      <td>32</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1495</th>
      <td>1495</td>
      <td>42</td>
    </tr>
    <tr>
      <th>1496</th>
      <td>1496</td>
      <td>22</td>
    </tr>
    <tr>
      <th>1497</th>
      <td>1497</td>
      <td>29</td>
    </tr>
    <tr>
      <th>1498</th>
      <td>1498</td>
      <td>33</td>
    </tr>
    <tr>
      <th>1499</th>
      <td>1499</td>
      <td>42</td>
    </tr>
  </tbody>
</table>
<p>1500 rows × 2 columns</p>
</div>



### 2. SELECT * FROM data LIMIT 10;


```python
data.head(10) #print(data.head(10))
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>age</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0</td>
      <td>30</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1</td>
      <td>47</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2</td>
      <td>29</td>
    </tr>
    <tr>
      <th>3</th>
      <td>3</td>
      <td>48</td>
    </tr>
    <tr>
      <th>4</th>
      <td>4</td>
      <td>32</td>
    </tr>
    <tr>
      <th>5</th>
      <td>5</td>
      <td>50</td>
    </tr>
    <tr>
      <th>6</th>
      <td>6</td>
      <td>20</td>
    </tr>
    <tr>
      <th>7</th>
      <td>7</td>
      <td>36</td>
    </tr>
    <tr>
      <th>8</th>
      <td>8</td>
      <td>42</td>
    </tr>
    <tr>
      <th>9</th>
      <td>9</td>
      <td>22</td>
    </tr>
  </tbody>
</table>
</div>



### 3. SELECT id FROM data;  //id 是 data 表的特定一列


```python
data['id'] #print(data['id'])
```




    0          0
    1          1
    2          2
    3          3
    4          4
            ... 
    1495    1495
    1496    1496
    1497    1497
    1498    1498
    1499    1499
    Name: id, Length: 1500, dtype: int64



#### 4. SELECT COUNT(id) FROM data;


```python
data['id'].count()
```




    1500



### 5. SELECT * FROM data WHERE id<1000 AND age>30;


```python
data[(data['id'] < 1000) & (data['age'] > 30)]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>age</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1</th>
      <td>1</td>
      <td>47</td>
    </tr>
    <tr>
      <th>3</th>
      <td>3</td>
      <td>48</td>
    </tr>
    <tr>
      <th>4</th>
      <td>4</td>
      <td>32</td>
    </tr>
    <tr>
      <th>5</th>
      <td>5</td>
      <td>50</td>
    </tr>
    <tr>
      <th>7</th>
      <td>7</td>
      <td>36</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>994</th>
      <td>994</td>
      <td>50</td>
    </tr>
    <tr>
      <th>995</th>
      <td>995</td>
      <td>36</td>
    </tr>
    <tr>
      <th>996</th>
      <td>996</td>
      <td>43</td>
    </tr>
    <tr>
      <th>997</th>
      <td>997</td>
      <td>31</td>
    </tr>
    <tr>
      <th>999</th>
      <td>999</td>
      <td>31</td>
    </tr>
  </tbody>
</table>
<p>693 rows × 2 columns</p>
</div>



### 生成数据表table1的数据


```python
# 生成数据表table1的数据：
table1 = pd.DataFrame({
    'id': np.random.randint(1, 101, size=1000),
    'order_id': np.random.randint(10001, 10101 ,size=1000),
    'name': [np.random.choice(list('ABCDEFGHIJKLMNOPQRSTUVWXYZ')) for _ in range(1000)]
})
# 导入到数据库table1表中：
table1.to_sql('table1', engine, if_exists='replace', index=False)
table1.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>order_id</th>
      <th>name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>25</td>
      <td>10014</td>
      <td>Y</td>
    </tr>
    <tr>
      <th>1</th>
      <td>24</td>
      <td>10065</td>
      <td>N</td>
    </tr>
    <tr>
      <th>2</th>
      <td>51</td>
      <td>10065</td>
      <td>J</td>
    </tr>
    <tr>
      <th>3</th>
      <td>17</td>
      <td>10087</td>
      <td>V</td>
    </tr>
    <tr>
      <th>4</th>
      <td>19</td>
      <td>10065</td>
      <td>M</td>
    </tr>
  </tbody>
</table>
</div>



### 6. SELECT id,COUNT(DISTINCT order_id) FROM table1 GROUP BY id;


```python
table1.groupby('id')['order_id'].nunique() #返回‘order_id‘中各唯一值的个数
```




    id
    1       4
    2       7
    3       7
    4       9
    5       7
           ..
    96     10
    97      9
    98      5
    99     14
    100    11
    Name: order_id, Length: 100, dtype: int64



### 生成数据表table2的数据：


```python
# 生成数据表table2的数据：
table2 = pd.DataFrame({
    'id': np.random.randint(1, 101, size=1000),
    'type': [np.random.choice(list('abcdefghijklmnopqrxtuvwxyz')) for _ in range(1000)]
})
# 导入到数据库table1表中：
table2.to_sql('table2', engine, if_exists='replace', index=False)
table2.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>type</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>10</td>
      <td>o</td>
    </tr>
    <tr>
      <th>1</th>
      <td>25</td>
      <td>t</td>
    </tr>
    <tr>
      <th>2</th>
      <td>24</td>
      <td>o</td>
    </tr>
    <tr>
      <th>3</th>
      <td>83</td>
      <td>c</td>
    </tr>
    <tr>
      <th>4</th>
      <td>92</td>
      <td>z</td>
    </tr>
  </tbody>
</table>
</div>



### 7. SELECT * FROM table1 t1 INNER JOIN table2 t2 ON t1.id = t2.id;


```python
pd.merge(table1, table2, on='id', how='inner')
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>order_id</th>
      <th>name</th>
      <th>type</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>25</td>
      <td>10014</td>
      <td>Y</td>
      <td>t</td>
    </tr>
    <tr>
      <th>1</th>
      <td>25</td>
      <td>10014</td>
      <td>Y</td>
      <td>e</td>
    </tr>
    <tr>
      <th>2</th>
      <td>25</td>
      <td>10014</td>
      <td>Y</td>
      <td>d</td>
    </tr>
    <tr>
      <th>3</th>
      <td>25</td>
      <td>10014</td>
      <td>Y</td>
      <td>c</td>
    </tr>
    <tr>
      <th>4</th>
      <td>25</td>
      <td>10014</td>
      <td>Y</td>
      <td>p</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>10152</th>
      <td>36</td>
      <td>10003</td>
      <td>D</td>
      <td>v</td>
    </tr>
    <tr>
      <th>10153</th>
      <td>36</td>
      <td>10003</td>
      <td>D</td>
      <td>z</td>
    </tr>
    <tr>
      <th>10154</th>
      <td>36</td>
      <td>10003</td>
      <td>D</td>
      <td>e</td>
    </tr>
    <tr>
      <th>10155</th>
      <td>36</td>
      <td>10003</td>
      <td>D</td>
      <td>h</td>
    </tr>
    <tr>
      <th>10156</th>
      <td>36</td>
      <td>10003</td>
      <td>D</td>
      <td>u</td>
    </tr>
  </tbody>
</table>
<p>10157 rows × 4 columns</p>
</div>



### 生成数据表table3的数据完成第8条语句


```python
# 生成数据表table3的数据：
table3 = pd.DataFrame({
    'id': np.random.randint(1, 101, size=900),
    'order_id': np.random.randint(10001, 10101 ,size=900),
    'name': [np.random.choice(list('ABCDEFGHIJKLMNOPQRSTUVWXYZ')) for _ in range(900)]
})
# 导入到数据库table1表中：
table3.to_sql('table3', engine, if_exists='replace', index=False)
table3.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>order_id</th>
      <th>name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>12</td>
      <td>10046</td>
      <td>S</td>
    </tr>
    <tr>
      <th>1</th>
      <td>50</td>
      <td>10062</td>
      <td>S</td>
    </tr>
    <tr>
      <th>2</th>
      <td>7</td>
      <td>10002</td>
      <td>M</td>
    </tr>
    <tr>
      <th>3</th>
      <td>57</td>
      <td>10056</td>
      <td>Q</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2</td>
      <td>10039</td>
      <td>V</td>
    </tr>
  </tbody>
</table>
</div>



### 8. SELECT * FROM table1 UNION SELECT * FROM table2;


```python
pd.concat([table1, table3]).drop_duplicates()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>order_id</th>
      <th>name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>25</td>
      <td>10014</td>
      <td>Y</td>
    </tr>
    <tr>
      <th>1</th>
      <td>24</td>
      <td>10065</td>
      <td>N</td>
    </tr>
    <tr>
      <th>2</th>
      <td>51</td>
      <td>10065</td>
      <td>J</td>
    </tr>
    <tr>
      <th>3</th>
      <td>17</td>
      <td>10087</td>
      <td>V</td>
    </tr>
    <tr>
      <th>4</th>
      <td>19</td>
      <td>10065</td>
      <td>M</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>895</th>
      <td>95</td>
      <td>10078</td>
      <td>P</td>
    </tr>
    <tr>
      <th>896</th>
      <td>16</td>
      <td>10009</td>
      <td>U</td>
    </tr>
    <tr>
      <th>897</th>
      <td>40</td>
      <td>10051</td>
      <td>E</td>
    </tr>
    <tr>
      <th>898</th>
      <td>62</td>
      <td>10014</td>
      <td>P</td>
    </tr>
    <tr>
      <th>899</th>
      <td>87</td>
      <td>10003</td>
      <td>J</td>
    </tr>
  </tbody>
</table>
<p>1891 rows × 3 columns</p>
</div>



### 9. DELETE FROM table1 WHERE id=10;


```python
table1.drop(table1[table1['id'] == 10].index)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>order_id</th>
      <th>name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>25</td>
      <td>10014</td>
      <td>Y</td>
    </tr>
    <tr>
      <th>1</th>
      <td>24</td>
      <td>10065</td>
      <td>N</td>
    </tr>
    <tr>
      <th>2</th>
      <td>51</td>
      <td>10065</td>
      <td>J</td>
    </tr>
    <tr>
      <th>3</th>
      <td>17</td>
      <td>10087</td>
      <td>V</td>
    </tr>
    <tr>
      <th>4</th>
      <td>19</td>
      <td>10065</td>
      <td>M</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>995</th>
      <td>14</td>
      <td>10090</td>
      <td>F</td>
    </tr>
    <tr>
      <th>996</th>
      <td>9</td>
      <td>10001</td>
      <td>Z</td>
    </tr>
    <tr>
      <th>997</th>
      <td>64</td>
      <td>10021</td>
      <td>J</td>
    </tr>
    <tr>
      <th>998</th>
      <td>83</td>
      <td>10033</td>
      <td>E</td>
    </tr>
    <tr>
      <th>999</th>
      <td>57</td>
      <td>10087</td>
      <td>Q</td>
    </tr>
  </tbody>
</table>
<p>993 rows × 3 columns</p>
</div>



### 10. ALTER TABLE table1 DROP COLUMN column_name;


```python
table1.drop(columns='order_id', inplace=True)
table1.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>25</td>
      <td>Y</td>
    </tr>
    <tr>
      <th>1</th>
      <td>24</td>
      <td>N</td>
    </tr>
    <tr>
      <th>2</th>
      <td>51</td>
      <td>J</td>
    </tr>
    <tr>
      <th>3</th>
      <td>17</td>
      <td>V</td>
    </tr>
    <tr>
      <th>4</th>
      <td>19</td>
      <td>M</td>
    </tr>
  </tbody>
</table>
</div>




```python

```
