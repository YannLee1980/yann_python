## 毕业项目说明：
* 选择洗发水作为调研的产品对象；
* Scrapy： gradpro文件夹;
* 数据库：gradpro.sql文件，其中包含两个主要的数据表：
    1. shampoo_raw: Scrapy获得的数据 > 在pipelines模块中计算舆情数值 > 存到表shampoo_raw；
    2. shampoo: 把shampoo_raw数据进一步预处理，并存到表shampoo中，与Django链接。
* 数据预处理：data_preprocessing.py；
* Django： DjangoGradPro文件夹。