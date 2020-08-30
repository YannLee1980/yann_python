# Python进阶训练营学习笔记
---
## 第九周：Django Web 开发进阶
### **本周内容一览：**
#### 1. Django源码分析之URLconf的偏函数：
* Django源码分析的重点部分：
  urlconf、views
* 如何读源码：
  一层层深入
* 偏函数：partical

        def partial(func, *args, **keywords):
            def newfunc(*fargs, **fkeywords):
                newkeywords = keywords.copy()
                newkeywords.update(fkeywords)
                return func(*args, *fargs, **newkeywords)
            newfunc.func = func
            newfunc.args = args
            newfunc.keywords = keywords
            return newfunc
* 课程参考资料：
    > 获取课程源码操作方法：
切换分支：git checkout 7b

#### 2. Django源码分析之URLconf的include

* 课程参考资料：
    > 获取课程源码操作方法：
切换分支：git checkout 7b

#### 3. Django源码分析之view视图的请求过程：
* views：
* requests、HTTPrequests
* 课程参考资料：
    > 获取课程源码操作方法：
切换分支：git checkout 7b
#### 4. Django源码分析之view视图的响应过程
* HTTPresponse
* 课程参考资料：
    > 获取课程源码操作方法：
切换分支：git checkout 7b

#### 5. Django源码分析之view视图的请求响应完整流程：
* 流程图
* 课程参考资料：
    > 获取课程源码操作方法：
切换分支：git checkout 7b

#### 6. Django源码分析之model模型的自增主键创建
* 课程参考资料：
    > 获取课程源码操作方法：
切换分支：git checkout 7b

#### 7. Django源码分析之model模型的查询管理器：
* 模型管理器的创建
* 课程参考资料：
    > 获取课程源码操作方法：
切换分支：git checkout 7b

#### 8. Django源码分析之template模板的加载文件
* render
* 
* 课程参考资料 ：
    > 获取课程源码操作方法：
切换分支：git checkout 7b



#### 9. Django源码分析之template模板的渲染
* 课程参考资料 ：
    > 获取课程源码操作方法：
切换分支：git checkout 7b

#### 10. DjangoWeb相关功能-管理界面
* 创建管理员账号:
    $ python manage.py createsuperuser
* 与数据关联：
  
            from django.contrib import admin
            # Register your models here.
            from .models import Type, Name
            admin.site.register(Type)
            admin.site.register(Name)

* 注意：与数据库的链接：python manage.py migrate
* 课程参考资料 ：
    > 获取课程源码操作方法：
切换分支：git checkout 7b

#### 11. DjangoWeb相关功能-表单
* form.py--views.py--*.html

* 课程参考资料 ：
    > 获取课程源码操作方法：
切换分支：git checkout 8b

#### 12. DjangoWeb相关功能-表单CSRF防护
* {% csrf_token %}

* 课程参考资料 ：
    > 获取课程源码操作方法：
切换分支：git checkout 8b

#### 13. DjangoWeb相关功能-用户管理认证
* 添加用户：
  
        from django.contrib.auth.models import User
        In [1]: from django.contrib.auth.models import 
        In [2]: user = User.objects.create_user('li', 'li@li.com', '12345678')                                                  
        In [4]: user.save()          

* 课程参考资料 ：
    > 获取课程源码操作方法：
切换分支：git checkout 8b

#### 14. DjangoWeb相关功能-信号:
* 两种方式：

        from django.views.decorators.csrf import csrf_exempt, csrf_protect
        @csrf_exempt
        def result(request):
            return render(request, 'result.html')

        # receiver
        def my_callback1(sender, **kwargs):
            print("Request started!")
        
        # connect
        from django.core.signals import request_started
        request_started.connect(my_callback1)

        from django.core.signals import request_finished
        from django.dispatch import receiver

        @receiver(request_finished)
        def my_callback2(sender, **kwargs):
            print("Request finished!")


* 课程参考资料 ：
    > 获取课程源码操作方法：
切换分支：git checkout 8b

#### 15. DjangoWeb相关功能-中间件：
* 把中间件写入middleware.py文件中：

        from django.http import HttpResponse
        from django.utils.deprecation import MiddlewareMixin
        class Middle1(MiddlewareMixin):
            def process_request(self,request):
                print('中间件请求')
        
            def process_view(self, request, callback, callback_args, callback_kwargs):
                print('中间件视图')
        
            def process_exception(self, request, exception):
                print('中间件异常')
        
            def process_response(self, request, response):
                print('中间件响应')
                return response
* 注意：在setting中添加自定义的中间和注意运行顺序。
* 课程参考资料 ：
    > 获取课程源码操作方法：
切换分支：git checkout 8b

#### 16. Django相关功能-生产环境部署：
* 在Django前添加中转：

        # 安装gunicorn
        pip install gunicorn
        # 在项目目录执行
        gunicorn MyDjango.wsgi

* 课程参考资料 ：
    > 获取课程源码操作方法：
切换分支：git checkout 8b

#### 17. Django相关功能-celery介绍：
* 定时任务
* 课程参考资料 ：
    > 获取课程源码操作方法：
切换分支：git checkout 9a

#### 18. Django相关功能-celery定时任务的实现

* 课程参考资料 ：
    > 获取课程源码操作方法：
切换分支：git checkout 9b

#### 19. Flask上下文与信号

* 课程参考资料 ：
    > 获取课程源码操作方法：
切换分支：git checkout 9b

#### 20. Tornado简介与其他常见网络框架对比
* 课程参考资料 ：
    > 获取课程源码操作方法：
切换分支：git checkout 9b


#### 疑问：

#### 千万注意：

#### 加深理解：

### **学习心得：**
&emsp;&emsp; 由于请加两周，学习耽误了，学习过程有点粗糙，还需要后续仔细学习。


<p align="right">学员：李志源</p>
<p align="right">2020年8月27日</p>
 