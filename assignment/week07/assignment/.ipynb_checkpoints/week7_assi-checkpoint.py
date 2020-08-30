## week7 Assignment.
from abc import ABCMeta

class Animal(metaclass=ABCMeta):
    '''
    动物类，为抽象基类，不可实例化。
    '''
    #动物的类型：
    type = None

    #动物的体形：
    bodytype = None

    #动物的性格：
    character = None

    #动物是否属于凶猛动物：
    is_fierce = None



class Zoo(object):
    '''
    动物园类
    '''
    #动物园的名字：
    name = None

    #添加动物方法：
    def add_animal(self):
        pass

class Cat(Animal):
    '''
    猫类
    '''
    pass


if __name__ == '__main__':
    # 实例化动物园
    z = Zoo('时间动物园')
    # 实例化一只猫，属性包括名字、类型、体型、性格
    cat1 = Cat('大花猫 1', '食肉', '小', '温顺')
    # 增加一只猫到动物园
    z.add_animal(cat1)
    # 动物园是否有猫这种动物
    have_cat = getattr(z, 'Cat')