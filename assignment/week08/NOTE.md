# Python进阶训练营学习笔记
---
## 第八周：Python高级语法
### **本周内容一览：**
#### 1.变量的赋值：
* 可变数据类型（从使用内存的角度）———传递的是对象的引用（动态类型）
    • 列表 list
    • 字典 dict
* 不可变数据类型（从使用内存的角度）———传递的是对象本身（非动态类型）
    • 整型int
    • 浮点型 float
    • 字符串型 string
    • 元组 tuple
    如下例，a与b分配的内存地址是一致的：

        a = 123
        b = 123
        c = a
        id(a), id(b), id(c)
        (4370617280, 4370617280, 4370617280)
    但如下例，系统将重新分配新的345的内存地址给a：

        a = 123
        a = 345
    **若大量类似的操作会大量消耗系统资源。**
* 例子：

        问题4: a、b的值分别是多少
        a = [1,2,3,4]
        b = a
        a = [1,2,3]
        a, b
        ([1, 2, 3], [1, 2, 3, 4])
        问题5: a、b的值分别是多少
        a = [1,2,3]
        b = a
        a[0], a[1], a[2] = 9, 8, 7
        a, b
        ([9, 8, 7], [9, 8, 7])
* 理解：
  引用：相当于内存箱子的一个标签；
  对象本身：相对于内存箱子实体。
* 课程参考资料：
    > 获取课程源码操作方法：
切换分支：git checkout 6a

#### 2. 容器序列的深浅拷贝：
* 序列分类
    1. 容器序列:list、tuple、collections.deque 等，能存放不同类型的数据 容器序列可以存 放不同类型的数据。
    2. 扁平序列:str、bytes、bytearray、memoryview (内存视图)、array.array 等，存放的 是相同类型的数据 扁平序列只能容纳一种类型。
* 容器序列存在深拷贝、浅拷贝问题
    • 注意:非容器(数字、字符串、元组)类型没有拷贝问题
        
        import copy 
        copy.copy(object) 
        copy.deepcopy(object)
    * 浅拷贝 VS. 深拷贝:
      浅拷贝:对于容器的第一层内容进行重新分配内存，而对于嵌套的内容只复制引用。
      深拷贝:对所有的内容进行重新分配内存，包括嵌套的内容。

* 容器序列的拷贝问题:
  `new_list2 = list(old_list)`:重新构建list对象，old_list的id不同。
  `new_list3 = old_list[:]`:重新构建list对象，old_list的id不同。

* Python assert（断言）用于判断一个表达式，在表达式条件为 false 的时候触发异常。
* 课程参考资料：
    > 获取课程源码操作方法：
切换分支：git checkout 6a

#### 3. 字典与扩展内置数据类型：
* 魔术方法：
  
        class Vector(Point):
            def __init__(self, x, y, z):
                super().__init__()
            
            def __sub__(self, other):  #当p1-p2自动被调用，p1为self，p2为other。
                tmp = (self.x - other.x)**2 +(self.y - other.y)**2 + (self.z - other.z)**2
                return sqrt(tmp)
* collections:
  
            # 命名元组
            from collections import namedtuple
            Point = namedtuple('Ponit', ['x','y'])
            p = Point(10, y=20)
            p.x + p.y
            p[0] + p[1]
            x, y = p


            from collections import Counter
            mystring = ['a','b','c','d','d','d','d','c','c','e']
            # 取得频率最高的前三个值
            cnt = Counter(mystring)
            cnt.most_common(3)
            cnt['b']


            # 双向队列
            from collections import deque
            d = deque('uvw')
            d.append('xyz')
            d.appendleft('rst')
* 课程参考资料：
    > 获取课程源码操作方法：
切换分支：git checkout 6b
collections 官方文档：
https://docs.python.org/zh-cn/3.7/library/collections.html
#### 4. 函数的调用:
* 函数--本质：可调用对象
  1. 用def定义函数:
  2. 用类实现函数功能(实现`__call__()`),系统将自动把该类的对象定义为可调用对象即函数功能：

            #定义类，实现`__call__()`:
            class Func():
                def __call__(self):
                    return 234
            #调用：
            func = Func()
            func()
  3. **函数是对象，调用时用();类名也是对象，实例化时用().**
* 课程参考资料：
    > 获取课程源码操作方法：
切换分支：git checkout 6b

#### 5. 变量作用域:
* 变量作用域(也叫命名空间)
* Python 作用域遵循 LEGB 规则。
    LEGB 含义解释:
    1. L-Local(function);函数内的名字空间
    2. E-Enclosing function locals;外部嵌套函数的名字空间(例如closure) 
    3. G-Global(module);函数定义所在模块(文件)的名字空间
    4. B-Builtin(Python);Python 内置模块的名字空间, 用`dir(__builtins__)`显示。
* 注意问题：
  1. 同名不同作用域；
  2. 顺序问题（运行顺序、查找顺序）。
* 查找顺序:
  L -> E -> G -> B
* 课程参考资料：
    > 获取课程源码操作方法：
切换分支：git checkout 6c

#### 6. 函数工具与高阶函数：
* 一般可变长参数定义如下:
  
        def func(*args, **kargs): 
            pass
    kargs 获取关键字参数 
    args 获取其他参数
    注意：**位置参数要写在关键字参数的前面，固定写法**
*  高阶函数：
    1. 高阶:参数是函数、返回值是函数 
    2. 常见的高阶函数:map、reduce、filter、apply
    3. apply 在 Python2.3 被移除，reduce 被放在 functools 包中
    4. 推导式和生成器表达式可以替代 map 和 filter 函数
* 偏函数（固定部分参数）

        def add(x, y):
            return x + y

        import functools
        add_1 = functools.partial(add, 1)
        add_1(10)

        import itertools
        g = itertools.count()
        next(g)
        next(g)
        auto_add_1 = functools.partial(next, g)
        auto_add_1()
* filter：
  
        def is_odd(x):
            return x%2 == 1
        f = filter(is_odd, range(1, 11))
* map（生成可迭代对象）：

        def square(x):
            return x**2
        m = map(square, range(1, 11))
* 课程参考资料：
    > 获取课程源码操作方法：
切换分支：git checkout 6c

#### 7. 闭包(closure)：
* 闭包的关键：
  函数是一个对象，所以可以作为某个函数的返回结果.
* 闭包中获取自由变量的机制（通过`__closure__`）：
  
        # 编译后函数体保存的局部变量
        print(my_line.__code__.co_varnames)
        # 编译后函数体保存的自由变量
        print(my_line.__code__.co_freevars)
        # 自由变量真正的值
        print(my_line.__closure__[0].cell_contents)
        #####################
        # 函数和对象比较有哪些不同的属性
        # 函数还有哪些属性
        def func(): 
            pass
        func_magic = dir(func)
        # 常规对象有哪些属性
        class ClassA():
            pass
        obj = ClassA()
        obj_magic = dir(obj)
        # 比较函数和对象的默认属性
        set(func_magic) - set(obj_magic)
* 闭包的作用：
  1. 解开外部函数和内部函数的耦合，让内部函数和外部函数不相关，让关注点可以只关注外部函数或内部函数

        def line_conf(a, b):
            def line(x):
                return a * x + b
            return line
        l1 = line_conf(1,2)
        l2 = line_conf(10, 20)
        l1(1), l2(1)
    2. 有利于建立定义态，而非在运行的是再重新定义，区分定义态和运行态。
* 闭包的定义和组成部分：
  内部函数对外部函数作用域里变量的引用（非全局变量）则称内部函数为闭包；
  内部函数和外部函数的数据组合起来才叫闭包。
* 例子：

        def counter(start=0):
            
            def incr():
                #列表换成直接调用start,显示分配前就调用的错误，因为在incr()的内部start被看作local变量，
                #除非start的作用域向上升一级,成为Enclosing
                nonlocal start
                start += 1
                return start
            return incr
        c1 = counter(10)
        c1()
* 课程参考资料：
    > 获取课程源码操作方法：
切换分支：git checkout 6c

#### 8. 装饰器介绍
*  装饰器
    1. 增强而不改变原有函数
    2. 装饰器强调函数的定义态而不是运行态

            @decorate 
            def target():
                print('do something')
            def target():
                print('do something')
            target = decorate(target)
    3. 装饰器在模块导入的时候自动运行

            # 装饰器在模块导入的时候自动运行
            # testmodule.py
            def decorate(func):
                print('running in modlue')
                def inner():
                    return func()
                return inner
            @decorate
            def func2():
                pass
            # test.py
            from  testmodule import *
            # from testmodule import func2
    4. 作用：
        书写优雅；
        装饰器起到装饰被装饰函数的作用。
* 多层装饰器：

        def html(func):
            def decorator():
                return f'<html>{func()}</html>'
            return decorator
        def body(func):
            def decorator():
                return f'<body>{func()}</body>'
            return decorator
        @html
        @body
        def content():
            return 'Hello World.'
        content()
        ##'<html><body>Hello World.</body></html>'
* 课程参考资料：
    > 获取课程源码操作方法：
切换分支：git checkout 6c

#### 9. 被装饰函数带参数和返回值的处理
* 被装饰函数带参数(装饰器的内部函数的参数要与被装饰函数的参数一致):

        def outer(func):
            def inner(a, b):   #与被装饰函数foo()的参数一致
                print(f'inner: {func.__name__}')
                print(a, b)
                func(a, b)
            return inner
        @outer
        def foo(a, b):
            print(a+b)
            print(f'foo: {foo.__name__}')

        foo(1, 2)
        #inner: foo
        #1 2
        #3
        #foo: inner
    **本质：看似在运行foo(), 其实在运行闭包inner().**
* 被修饰函数带不定长参数

        def outer(func):
            def inner(*args, **kwargs):
                func(*args, **kwargs)
            return inner
        @outer
        def foo(a, b, c):
            print(a+b+c)

        foo(1,2,3)
        #6
* 被修饰函数带返回值(通用写法)

        def outer(func):
            def inner(*args, **kwargs):
                ###
                ret = func(*args, *kwargs)
                ###
                return ret
            return inner
        @outer
        def foo(a, b, c):
            return a+b+c
        foo(2,3,4)
        #9
* 装饰器带参数(装饰器函数加多一层闭包)：

        def outer_arg(bar):
            def outer(func):
                def inner(*args, **kwargs):
                    ret = func(*args, **kwargs)
                    print(bar)
                    return ret
                return inner
            return outer
        #相对于：outer_arg('foo_arg')(foo)(a,b,c)
        @outer_arg('foo_arg')
        def foo(a, b, c):
            return (a + b + c)
        #相对于：outer_arg('foo_arg')(foo)(1,2,3)
        foo(1,2,3)
* 装饰器堆叠

        @classmethod
        @synchronized(lock)
        def foo(cls):
            pass
        #相对于：classmethod(synchronized(lock)(foo))()
* 课程参考资料：
    > 获取课程源码操作方法：
切换分支：git checkout 6c

#### 10. Python内置装饰器@@@@@

* @wraps:
* # functools.wraps
    * @wraps接受一个函数来进行装饰
    * 并加入了复制函数名称、注释文档、参数列表等等的功能
    * 在装饰器里面可以访问在装饰之前的函数的属性
    * @functools.wraps(wrapped, assigned=WRAPPER_ASSIGNMENTS, updated=WRAPPER_UPDATES)
    * 用于在定义包装器函数时发起调用 update_wrapper() 作为函数装饰器。 
    * 它等价于 partial(update_wrapper, wrapped=wrapped, assigned=assigned, updated=updated)。

* 课程参考资料：
    > 获取课程源码操作方法：
切换分支：git checkout 6c

#### 11. 类装饰器
* 类装饰器:
* 装饰类的装饰器

* 课程参考资料：
    > 获取课程源码操作方法：
切换分支：git checkout 6c

#### 12. 官方文档中的装饰器代码阅读指南
* @dataclass:
  Python3.7 引入 Data Class  PEP557

* 课程参考资料：
    > 获取课程源码操作方法：
切换分支：git checkout 6c

#### 13. 对象协议与鸭子类型
* 鸭子类型:
  即作为动态语言python的对象识别的方式，它采取的是对象协议，你有这样的协议就认为你是这样的对象，但如何实现呢？用的是魔术方法，某对象实现类某魔术方法，就具有某中特殊对象的功能。
* 自己编写类的时候也尽量仿照python标准对象利用魔术方法的形式编写。

* 课程参考资料：
    > 获取课程源码操作方法：
切换分支：git checkout 6c

#### 14. yield语句
Iterables: 包含 __getitem__() 或 __iter__() 方法的容器对象 
Iterator: 包含 next() 和 __iter__() 方法
Generator: 包含 yield 语句的函数

* 课程参考资料：
    > 获取课程源码操作方法：
切换分支：git checkout 6c

#### 15. 迭代器使用的注意事项
* 迭代器的创建：
  1. 推导式：`(i for i in range(10))`
  2. iter关键字
  3. itertools的三个常见无限迭代器:
    * count:
    * cycle:
    * repeat:
  4. 有限迭代器：chain
  5. yield
  6. 实现：__next__() 和 __iter__() 方法
* yield from :

            # Python3.3 引入了 yield from 
            # PEP-380
            def chain(*iterables):
                for it in iterables:
                    for i in it:
                        yield i

            s = 'ABC'
            t = [1, 2, 3]
            list(chain(s, t))

            def chain2(*iterables):
                for i in iterables:
                    yield from i   # 替代内层循环

            list(chain2(s, t))
*  RuntimeError: 字典进行插入操作后，字典迭代器会立即失效
    尾插入操作不会损坏指向当前元素的List迭代器,列表会自动变长
*  迭代器一旦耗尽，永久损坏
* 课程参考资料：
    > 获取课程源码操作方法：
切换分支：git checkout 6c

#### 16. yield表达式:
* next--（yeild的上半部分）yeild 的值，并在yeild处暂停,send（值）--（yeild的下半部分）从yeild处开始并把值传给yield表达式的值接着往下运行:

        def jumping_range(up_to):
            index = 0
            while index < up_to:
                jump = yield index  #yield表达式,接收send的值。
                print(f'jump is {jump}')
                if jump is None:
                    jump = 1   # next() 或者 send(None)
                index += jump 
                print(f'index is {index}')
        if __name__ == '__main__':
            iterator = jumping_range(5)
            print(next(iterator)) # 0
            print(iterator.send(2)) # 2
            print(next(iterator)) # 3
            print(iterator.send(-1)) # 2
            for x in iterator:
                print(x) # 3, 
* next()也相对于传空值
* yield:返回值并暂停，next：继续并取得值
* yield语句：yield index；
  yield表达式：jump = yield index

* 课程参考资料：
    > 获取课程源码操作方法：
切换分支：git checkout 7a

#### 17. 协程简介：
* async await 成对使用：

  
        # 注意： await 接收的对象必须是awaitable对象
        # awaitable 对象定义了__await__()方法
        # awaitable 对象有三类
        # 1 协程 coroutine
        # 2 任务 Task
        # 3 未来对象 Future
        #####################
        import asyncio
        async def main():
            print('hello')
            await asyncio.sleep(3)
            print('world')

        # asyncio.run()运行最高层级的conroutine
        asyncio.run(main())
        # hello
        # sleep 3 second
        # world

        #################
        # 协程调用过程： 
        # 调用协程时，会被注册到ioloop，返回coroutine对象
        # 用ensure_future 封装为Future对象
        # 提交给ioloop


* 课程参考资料：
    > 获取课程源码操作方法：
切换分支：git checkout 7a

#### 18. aiohttp简介：
* 协程和多进程的结合

#### 疑问：
1. 3中的super().__init__()为什么不写参数x、y、z？

        class Vector(Point):
            def __init__(self, x, y, z):
                super().__init__()
2. 关于元类还要重点理解！
3. dir()的作用是什么？----查看当前的对象
4. dir(对象)作用是什么？————查看该对象的属性（包含方法）有哪些
5. 如何用生成器代替filter？
#### 千万注意：

#### 加深理解：
1. 包functools、itertools里的功能要熟练。
2. 生成器表达式；
3. collections要加深理解。
4. 可变参数：`*args`,`**kwargs`的加深理解：

        def test(a,b,c):
            return a+b+c
        l = [1,2,3]
        test(*l)
        # 输出：6



### **学习心得：**
&emsp;&emsp; 本周的内容很实在，能对python有更深的认识，可见python为了体现简单美而内部的实现并不简单；同时本周的内容也是基本功，为了能走得更远，基本功可不能马虎啊！


<p align="right">学员：李志源</p>
<p align="right">2020年8月28日</p>
 