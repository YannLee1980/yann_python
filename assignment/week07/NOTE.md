# Python进阶训练营学习笔记
---
## 第七周：面向对象编程
### **本周内容一览：**
#### 1. 类属性与对象属性：
* 类也是对象:
  
      class MyFirstClass:
        pass
      # 类也是对象
      c = MyFirstClass
      d = c()
      d.__class__()
* 新式类、古典类：
  古典类：python2.2版本前，区分基本类型和类；
  新式类：python2.2版本后，基本类和类都继承自object。写法：`class Human:` <-等价-> `class Human(object):`
* 对象初始化函数：`__init__(self, ...):` 其中`self`为对象本身都引用，可以改其它名字，习惯用‘self’。
* 类属性和对象属性（__dict__）：
  
      # 有静态字段,live属性
      Human.__dict__
      # 有普通字段,name属性
      man.__dict__
* 常用内置函数：
  `setattr('对象名或类名', 'attr', 'value')`:为类或对象增加属性;
  `dir('对象名或类名')`：列出某类或某对象的所用属性和方法;
  __dict__, __class__, __bases__, __name__, __subclasses__()
  
* 课程参考资料：
> 获取课程源码操作方法：
切换分支：git checkout 6a

#### 2. 类的属性作用域
* 静态字段：
  
      class Human(object):
          # 静态字段
          live = True
* 私有属性：
      
      class Human2:
        # 人为约定不可修改
        _age = 0
        # 私有属性  （自动改名）
        __fly = False  
        # 魔术方法，不会自动改名
        # 如 __init__
* 通过对象改变静态字段的值，观察静态字段的变化:
  1. 静态字段是标量时——对象与类静态字段同名的字段赋值时将新建一个与类静态字段各自独立的字段。

          class Test:
            a = 1
            b = 2
          t = Test()
          t.a = 999
          t.a, id(t.a)  #(999, 4486290704)
          Test.a, id(Test.a) #(1, 4444812416)
  2. 静态字段是对象时————对象与类静态字段同名的字段赋值时将与类静态字段处理同一个字段。
   
          class Desc:
              """
              通过打印来展示描述器的访问流程
              """
              def __init__(self, name):
                  self.name = name
              
              def __get__(self, instance, owner):
                  print(f'__get__({instance}, {owner})')
                  return self.name
              
              def __set__(self, instance, value):
                  print(f'__set({instance}, {value})')
                  self.name = value
              
              def __delete__(self, instance):
                  print(f'__delete({instance})')
                  del self.name
          class MyObj:
                a = Desc('aaa')
                b = Desc('bbb')
          m = MyObj()
          m.a = 123
          m.a, id(m.a)  #(123, 4444816320)
          MyObj.a, id(MyObj.a) ##(123, 4444816320)
* **注意：静态字段的域：类、对象各自拥有独立的静态字段。但上面的例子，静态字段是对象时例外。**
* 魔术方法（如：__name__, 随着环境的改变而改变）:
  • 双下划线开头和结尾的方法，实现了类的特殊成员，这类称作魔术方法 
  • 不是所有的双下划线开头和结尾的方法都是魔术方法
  • 魔术方法类似其他语言的接口
* `dir('对象')` <-等价-> `'对象'.__dir__()`
* 课程参考资料：
> 获取课程源码操作方法：
切换分支：git checkout 6a

#### 3. 类方法描述器
* 三种方法:
• 普通方法 至少一个 self 参数，表示该方法的对象
• 类方法 @classmethod 至少一个 cls 参数，表示该方法的类 ,**cls代表该类的类名,该方法的目的是为了调用类属性（也叫静态属性）和类方法,也为继承该类的所以类通过cls提供了与之绑定。**
• 静态方法 @staticmethod 由类调用，无参数，**表示该方法不调用类、对象的属性、方法。只是作为一个独立的方法**
  三种方法在内存中都归属于类

      class Foo:
        #普通方法：
        def instance_method(self):
          ...
        #类方法：
        @classmethod
        def class_method(cls):
          ...
        #静态方法：
        @staticmethod
        def static_method():
          ...
* 初始化函数：`__init__()`, 构造函数：`__new__()`
* 实例也可以调用类方法(**查找顺序是先找实例的__dict__是否有该方法,如果没有，查这个实例的类**)
  
      class Story(object):
          snake = 'Python'
          def __init__(self, name):
              self.name = name
          # 类的方法
          @classmethod
          def get_apple_to_eve(cls):
              return cls.snake
      s = Story('anyone')
      # get_apple_to_eve 是bound方法，查找顺序是先找s的__dict__是否有get_apple_to_eve,如果没有，查类Story
      print(s.get_apple_to_eve)
      # 类和实例都可以使用
      print(s.get_apple_to_eve())
      print(Story.get_apple_to_eve())
      # print(type(s).__dict__['get_apple_to_eve'].__get__(s,type(s)))
      # print(type(s).__dict__['get_apple_to_eve'].__get__(s,type(s)) == s.get_apple_to_eve)
* @classmethod的使用场景：
  1. 父类定义@classmethod，子类就可以和这个classmethod绑定了:
   
          class Fruit:
              total = 0
              @classmethod
              def print_total(cls):
                  print(cls.total)
                  print(id(Fruit.total))
                  print(id(cls.total))
              @classmethod
              def set(cls, value):
                  print(f'Calling {cls}, {value}.')
                  cls.total = value
          class Apple(Fruit):
              pass
          class Orange(Fruit):
              pass
          
          class Orange(Fruit):
              pass

          Apple.set(100)
          # calling <class '__main__.Apple'> ,100
          Orange.set(200) ##此时Orange的total只有一份，值为200。
          # calling <class '__main__.Orange'> ,200
          org=Orange()
          org.set(300)
          # calling <class '__main__.Orange'> ,300
          Apple.print_total()
          # 100 
          # 140735711069824
          # 140735711073024
          Orange.print_total() 
          # 300 ##此时Orange的total只有一份，值为300。
          # 140735711069824
          # 1998089714064
          # >>>
  **注意静态字段和对象字段的区别：**
  上例中，如果o.total = 999 ##此时为对象o添加自己的total字段，有别与Orange类的total.
  2. 起到类构造函数的作用:

          #类方法用在模拟java定义多个构造函数的情况。
          #由于python类中只能有一个初始化方法，不能按照不同的情况初始化类。
          class Kls3:
            def __init__(self, fname, lname):
                self.fname = fname
                self.lname = lname
            def print_name(self):
                print(f'First Name is {self.fname}.')
                print(f'Last Name is {self.lname}.')
                
            @classmethod
            def pre_name(cls, name):
                fname = ''
                lname = ''
                if '-' in name:
                    fname, lname = name.split('-')
                elif ',' in name:
                    fname, lname = name.split(',')
                elif ' ' in name:
                    fname, lname = name.split(' ')
                else:
                    fname = name
                return cls(fname, lname)

          me4 = Kls3.pre_name('Yann,Li')
          me4.print_name()
* 课程参考资料：
> 获取课程源码操作方法：
切换分支：git checkout 6a

#### 4. 静态方法描述器
* @staticmethod:
  不带self、cls参数， 所以不能引用类的属性和实例的属性，一般用于一些额外的与类和实例没有多大关系的处理如类型转换和一些判断等,然而它还是可以带一些普通的参数的。

      import datetime
      class Story(object):
          snake = 'Python'
          def __init__(self, name):
              self.name = name
          # 静态的方法
          @staticmethod
          def god_come_go():
              if datetime.datetime.now().month % 2 :
                  print('god is coming')
          
      Story.god_come_go()
* 课程参考资料：
> 获取课程源码操作方法：
切换分支：git checkout 6a

#### 5. 描述器高级应用`__getattribute__`
* 类实例的属性描述符：
  这类中，需要对**实例**获取属性这一行为进行操作，可以用：
  `__getattribute__()` : 对所有未定义或已定义的属性进行操作；
  `__getattr__()` ：对未定义的属性进行操作。
* `__getattribute__()`在获取属性的时候作出处理：
  
        #将不存在的属性设置为100并返回,模拟getattr行为
        class Human4:
            def __init__(self):
                self.age = 18
            def __getattribute__(self, item):
                print(f'__getattribute__ called item {item}')
                try:
                    return super().__getattribute__(item)
                except Exception as e:
                    self.__dict__[item] = 100
                    return 100
  **注意写法**：`self.__dict__[item] = 100` #取`__dict__`,并添加属性item。

        >>>h4.noattr
        __getattribute__ called item noattr
        __getattribute__ called item __dict__
        100
        >>>h4.noattr
        __getattribute__ called item noattr
        100
  **也就是说：在取属性的时候，自动调用`__getattribute__()`进行取值**
* `__getattribute__()`的固定写法：`def __getattribute__(self, item):` #item为要获取的属性
* 课程参考资料：
> 获取课程源码操作方法：
切换分支：git checkout 6a

#### 6. 描述器高级应用__getattr__
* `__getattr__()`只在获取不存在的属性时运行
* 如果`__getattribute__()`、`__getattr__()`同时存在，执行顺序是 __getattribute__ > __getattr__ > __dict__ > 报找不到属性的错误

      class Human2(object):    
          """
          同时存在的调用顺序
          """
          def __init__(self):
              self.age = 18
          def __getattr__(self, item): 
              print('Human2:__getattr__')
              return 'Err 404 ,你请求的参数不存在'
          def __getattribute__(self, item):
              print('Human2:__getattribute__')
              return super().__getattribute__(item)
      h1 = Human2()
      # 如果同时存在，执行顺序是 __getattribute__ > __getattr__ > __dict__
      print(h1.age)
      print(h1.noattr)
      # 注意输出，noattr的调用顺序

* 课程参考资料：
> 获取课程源码操作方法：
切换分支：git checkout 6a

#### 7. 描述器原理&属性描述符
* 描述器：实现特定协议（描述符）的类。
* 属性描述器：实现属性描述符（property）的类，即实现方法：`__get__()`, `__set__()`,`__delete__()`，对实例进程上述操作时将自动调用----比较底层的写法：
  
      class Desc: # 创建属性描述器
          """
          通过打印来展示描述器的访问流程
          """
          def __init__(self, name):
              self.name = name
          
          def __get__(self, instance, owner):  #取值时调用，固定写法，注意参数。
              print(f'__get__({instance}, {owner})')
              return self.name
          
          def __set__(self, instance, value):  #赋值时调用，固定写法，注意参数。
              print(f'__set({instance}, {value})')
              self.name = value
          
          def __delete__(self, instance):  #删除时调用，固定写法，注意参数。
              print(f'__delete({instance})')
              del self.name
      class MyObj:
          a = Desc('aaa')
          b = Desc('bbb')
      m = MyObj()
      m.a  ##自动调用`__get__()`
      ##输出： __get__(<__main__.MyObj object at 0x108650f10>, <class '__main__.MyObj'>)
      'aaa'
      m.a = 999  ##自动调用`__set__()`
      ##输出： __set(<__main__.MyObj object at 0x108650f10>, 999)
      del m.a  ##自动调用`__delete__()`
      ##输出：__delete(<__main__.MyObj object at 0x108650f10>)
* 用property（）生成属性描述器：
  
        ##Django中的property
        site-packages/django/db/models/base.py
        class Model(metaclass=ModelBase): 
          def _get_pk_val(self, meta=None):
            meta = meta or self._meta
            return getattr(self, meta.pk.attname) 
          def _set_pk_val(self, value):
            return setattr(self, self._meta.pk.attname, value) 
          pk = property(_get_pk_val, _set_pk_val)
* 用@property生成属性描述器，即把方法封装成属性(可进行读、写、删操作)：
  
        class Human:
          def __init__(self):
              self._gender = 'yu'
          # 将方法封装成属性
          @property    #定义一个名为gender的属性描述器
          def gender(self):
              print('in gender property')
              return self._gender
          # 支持修改
          @gender.setter  #为gender这个描述器添加setter功能
          def gender(self, value):
              print('in gender.setter')
              self._gender = value
          # 支持删除
          @gender.deleter #为gender这个描述器添加deleter功能
          def gender(self):
              print('in gender.deleter')
              del self._gender
        #使用：
        h = Human()
        h.gender = 'F'
        print(h.gender)
        del h.gender
  **被装饰函数建议使用相同的名称`gender()`**
* 另一种写法：用property（）生成属性描述器，作用和上面一样，把方法作为属性使用：
  
        class Human3:
            def __init__(self):
                self._gender = 'Yuan'
            def _get_(self):
                print('in _get_()')
                return self._gender
            def _set_(self, value):
                print('in _set_()')
                self._gender = value
            def _del_(self):
                print('in _del_()')
                del self._gender
            #定义一个名为gender的属性描述器
            gender = property(_get_, _set_, _del_)
* 注意：
  1. 使用setter 并不能真正意义上实现无法写入，gender被改名为 _Article__gender
  2. property本质并不是函数，而是特殊类（实现了数据描述符的类）
  3. 如果一个对象同时定义了__get__()和__set__()方法，则称为**数据描述符**，
  4. 如果仅定义了__get__()方法，则称为**非数据描述符**,如：`__getattribute__`和`__getattr__`
* property的优点：
 1. 代码更简洁，可读性、可维护性更强。
 2. 更好的管理属性的访问。
 3. 控制属性访问权限，提高数据安全性。
* property 应用例子：
  geekbangtrain/NewClass/p8_1demo.py
* 课程参考资料：
> 获取课程源码操作方法：
切换分支：git checkout 6a

#### 8. 面向对象编程-继承
* object 和 type 的关系:
  • object 和 type 都属于 type 类 (class 'type'): 类名object、type都是type类的实例；
  • type 类由 type 元类自身创建的。object 类是由元类 type 创建
  • object 的父类为空，没有继承任何类
  • type 的父类为 object 类 (class 'object')
* # object 与 type
  
        print('object', object.__class__, object.__bases__)
        print('type', type.__class__, type.__bases__)
* 钻石继承:
 1. 深度优先：经典类（python2.0）
 2. 广度优先：新型类（python3.0）
* 有向无环图:DAG(Directed Acyclic Graph)
  • DAG 原本是一种数据结构，因为 DAG 的拓扑结构带来的优异特性，理动态规划、寻求最短路径的场景。经常被用于处，原则：
  1. 入度为0开始；
  2. 从左侧开始。
* python 没有重载：
  
        class  Klass(object):
            def A(self):
                pass
            def A(self,a, b):
                print(f'{a},{b}')
        inst = Klass()
        # 没有实现重载
        inst.A()  # 报错，只能调用A(self,a, b)

* 课程参考资料：
> 获取课程源码操作方法：
切换分支：git checkout 6a

#### 9. solid设计原则与设计模式&单例模式
*  SOLID 设计原则
  • 单一责任原则 The Single Responsibility Principle
  • 开放封闭原则 The Open Closed Principle
  • 里氏替换原则 The Liskov Substitution Principle
  • 依赖倒置原则 The Dependency Inversion Principle
  • 接口分离原则 The Interface Segregation Principle
* 设计模式：
  • 设计模式用于解决普遍性问题 
  • 设计模式保证结构的完整性
*  单例模式
   1. 对象只存在一个实例
   2. __init__ 和 __new__ 的区别:
    • __new__ 是实例创建之前被调用，返回该实例对象，是静态方法
    • __init__ 是实例对象创建完成后被调用，是实例方法
    • __new__ 先被调用，__init__ 后被调用
    • __new__ 的返回值(实例)将传递给 __init__ 方法的第一个参数，__init__ 给这个
* 装饰器实现单实例模式：

        def singleton(cls):
            instance = {}
            def getinstance():
                if cls not in instance:
                    instance[cls] = cls()
                print(instance)
                return instance[cls]
            return getinstance
        @singleton
        class MyClass1(object):
            pass
        @singleton
        class MyClass2(object):
            pass

        m1 = MyClass1()
        #{<class '__main__.MyClass1'>: <__main__.MyClass1 object at 0x1031a1750>}
        m2 = MyClass2()
        #{<class '__main__.MyClass2'>: <__main__.MyClass2 object at 0x103161f10>}
        m3 = MyClass1()
        #{<class '__main__.MyClass1'>: <__main__.MyClass1 object at 0x1031a1750>}
    上例：
      1. 验证def singleton() 中的instance的可见范围
      2. MyClass1 、MyClass2 有各自的instance；
      3. m3创建时，回到MyClass1的可见范围里。

* `__new__` 与 `__init__` 的关系：

        class Foo(object):
            def __new__(cls, name):  #与__init__()一样的参数name
                print(f'Trace __new__({cls})')
                return super().__new__(cls) #必须有cls参数
            
            def __init__(self, name):
                print(f'Trace __init__({self})')
                super().__init__()  #不能有self参数
                self.name = name
        bar = Foo('test')
        #：Trace __new__(<class '__main__.Foo'>)
        #：Trace __init__(<__main__.Foo object at 0x1031b2110>)
  注意：
  1. **super().__new__(cls) #必须有cls参数**
  2. **super().__init__()  #不能有self参数**
* `__new__()` VS. `__init__()`
  `__new__()`：构造函数，返回类的对象,一般与`__init__()接收的初始化参数一致。
  `__init__()`：初始化函数，是在`__new__()`之后运行。
* `__new__` 方式实现单例模式
  
        class Singleton2(object):
            __isinstance = False  # 默认没有被实例化
        def __new__(cls, *args, **kwargs):
            if cls.__isinstance:  
              return cls.__isinstance  # 返回实例化对象
            cls.__isinstance = object.__new__(cls)  # 实例化
            return cls.__isinstance
* 解决并发，引入带锁版
  
        import threading
        class Singleton(object):
            objs = {}
            objs_locker = threading.Lock()
            def __new__(cls, *args, **kargs):
                if cls in cls.objs:
                    return cls.objs[cls]
                cls.objs_locker.acquire()
                try:
                    if cls in cls.objs: ## double check locking
                        return cls.objs[cls]
                    cls.objs[cls] = object.__new__(cls)
                finally:
                    cls.objs_locker.release()
* 所有的变量都会绑定到模块。模块只初始化一次。import机制是线程安全的（保证了在并发状态下模块也只有一个实例）。当我们想要实现一个游戏世界时，只需简单地创建World.py就可以了:

        # World.py
        import Sun
        def run():
            while True:
                Sun.rise()
                Sun.set()

        # main.py
        import World
        World.run()

* 课程参考资料：
> 获取课程源码操作方法：
切换分支：git checkout 6a

#### 10. 工厂模式
* 静态工厂模式
* 动态工厂模式：

        def factory2(func):
            class klass: pass
            #setattr需要三个参数:对象、key、value
            setattr(klass, func.__name__, func)
            return klass

        def say_foo(self): 
            print('bar')

        Foo = factory2(say_foo)
        foo = Foo()
        foo.say_foo()
* 疑问：

        def factory2(func):
            class Klass: pass
            #setattr需要三个参数:对象、key、value
            setattr(Klass, func.__name__, classmethod(func))
            return Klass
        ​
        def say_foo(cls):  #注意有self，满足对象调用时传入self。
            return 'bar'
        Foo = factory2(say_foo)
        foo = Foo()
        foo
        <__main__.factory2.<locals>.Klass at 0x104f843d0>
        foo
        Foo.say_foo
        <bound method say_foo of <class '__main__.factory2.<locals>.Klass'>>
        say_foo
        foo.say_foo
        <bound method say_foo of <class '__main__.factory2.<locals>.Klass'>>

* 课程参考资料：
> 获取课程源码操作方法：
切换分支：git checkout 6a

#### 11. 元类：
* type创建类的类，也就是类这种对象的类，反过来说，所有类都是type这个类的实例。

        # 使用type元类创建类
        def hi():
            print('Hi metaclass')

        # type的三个参数:类名、父类的元组、类的成员
        Foo = type('Foo',(),{'say_hi':hi})
        foo = Foo
        foo.say_hi()
*  构建新的字典类

        def pop_value(self,dict_value):
            for key in self.keys():
                if self.__getitem__(key) == dict_value:
                    self.pop(key)
                    break

        # 元类要求,必须继承自type    
        class DelValue(type):
            # 元类要求，必须实现new方法
            def __new__(cls,name,bases,attrs):
                attrs['pop_value'] = pop_value
                return type.__new__(cls,name,bases,attrs)
        
        class DelDictValue(dict,metaclass=DelValue):
            # python2的用法，在python3不支持
            # __metaclass__ = DelValue
            pass

        d = DelDictValue()
        d['a']='A'
        d['b']='B'
        d['c']='C'
        d.pop_value('C')
        for k,v in d.items():
            print(k,v)

* 课程参考资料：
> 获取课程源码操作方法：
切换分支：git checkout 6a
#### 12. mixin模式:
*  抽象基类:
  • 抽象基类(abstract base class，ABC)用来确保派生类实现了基类中的特定方法。 • 使用抽象基类的好处:
  • 避免继承错误，使类层次易于理解和维护。
  • 无法实例化基类。
  • 如果忘记在其中一个子类中实现接口方法，要尽早报错。


* 课程参考资料：
> 获取课程源码操作方法：
切换分支：git checkout 6a

#### 疑问：
1. Human.__class__ -> type??
2. print(type(s).__dict__['get_apple_to_eve'].__get__(s,type(s))),其中__get__的作用是什么？
3. 加深对type的理解
4. 下面代码，为什么s2.age = 23，没有触发描述器，反而age对象被整数23覆盖了？
  
        class Age(object):
            def __init__(self, default_age = 18):
                self.default_age = default_age
                self.age_ange = range(18,66)
                self.data = {}
            
            def __get__(self, instance, owener):
                return self.data.get(instance, self.default_age)
            
            def __set__(self, instance, value):
                if value not in self.age_ange:
                    raise ValueError('must bo be in 18-65')
                self.data[instance] = value   
        class Student2:
            def __init__(self):
                self.age = Age()
        s2 = Student2()
        s2.__dict__
        #输出：{'age': <__main__.Age at 0x10f16c6d0>}
        s2.age = 23
        s2.__dict__
        #输出：{'age': 23}
  ----**解答：描述器一定是类属性，它充当的角色是类静态字段的角色。**


#### 千万注意：
1. property描述符是对实例进行操作时才生效，对于类对操作无效，看下例：

        class Age(object):
            def __init__(self, default_age = 18):
                self.default_age = default_age
                self.age_ange = range(18,66)
                self.data = {}
            
            def __get__(self, instance, owener):
                print(f'data:{self.data}')
                return self.data.get(instance, self.default_age)
            
            def __set__(self, instance, value):
                if value not in self.age_ange:
                    raise ValueError('must bo be in 18-65')
                self.data[instance] = value  
        class Student:
            age = Age()
            s = Student()
        #  情况1.   
        s.age = 19
        s.age  #输出：data:{<__main__.Student object at 0x10f14f4d0>: 19}
        #  情况2.
        Student.age = 20
        Student.age #输出20，此时对age是整数，已经覆盖了原有对age对象。
        Student.__dict__
        #输出：mappingproxy({'__module__': '__main__',
                      'age': 20,
                      '__dict__': <attribute '__dict__' of 'Student' objects>,
                      '__weakref__': <attribute '__weakref__' of 'Student' objects>,
                      '__doc__': None,
                      'ab': 999})
2. **注意：静态字段的域：类、对象各自拥有独立的静态字段。但第2课程的例子，静态字段是对象时例外。**
3. 描述器只能位于类的属性位置，不能位于对象属性，调用时只能是该类的对象进行调用，不能该类直接调用。
#### 加深理解：
1. 类的@property定义的方法是带self参数的，是在对象的层面上使用的。
### **学习心得：**
&emsp;&emsp; 面向对象编程是编程的基础，在学习中花了较长时间理解的内容是描述器、类和对象属性的作用范围、type等；对于cls和self的区别用处，什么时候函数的参数传入cls，什么时候传入self，自己通过试验加深理解；还有`__new__()`和`__init__()`区别，通过作业更好的理解。而设计模式、元类、mixin模式等还需要阅读优秀代码和自己多实践才能更好的学习透彻。

<p align="right">学员：李志源</p>
<p align="right">2020年8月9日</p>
 