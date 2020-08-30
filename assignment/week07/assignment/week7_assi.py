## week7 Assignment.

class Animal(object):
    '''
    动物类，不可实例化。
    '''
    def __new__(cls, *args, **kwargs):
        # 防止该类实例化，被实例化时报错：
        if cls is Animal:
            raise TypeError("Animal类不能被实例化。")
        return object.__new__(cls)
    
    def __init__(self, animaltype, bodytype, character):
        #动物的类型（食肉、食素）：
        self.animaltype = animaltype
        
        #动物的体形（'小型'，'中等'，'大型'）：    
        self.bodytype = bodytype
        
        #动物的性格：
        self.character = character
        
        #判断动物是否属于凶猛动物：
        
        #动物体形字典，用于比较：
        dict_bodytype = {'小': 1,
                         '中': 2,
                         '大': 3}
        #“体型 >= 中”并且是“食肉类型”则认为“凶猛”：
        if dict_bodytype[self.bodytype] >= 2 and self.animaltype == '食肉':
            self.is_fierce = True
        else: 
            self.is_fierce = False
        

class Cat(Animal):
    '''
    猫类
    '''
    def __init__(self, name, animaltype, bodytype, character):
        #初始化父类Animal：
        super().__init__(animaltype, bodytype, character)
        
        #猫的名字：
        self.name = name

        #判断是否适合作为宠物(非凶猛动物并性格温顺，则认为适合作为宠物)：
        if self.is_fierce == False and self.character == '温顺':
            self.is_pet = True
        else:
            self.is_pet = False

    #猫叫声：
    mew = '喵···喵···喵···'

class Zoo(object):
    '''
    动物园类
    '''
    def __init__(self, name):
        #动物园的名字：
        self.name = name
        
        #动物园里的动物：
        self._animals = []

    #添加动物方法：
    def add_animal(self, animal):
        if self._animals:
            for a in self._animals:
                if animal is a:
                    raise Exception('该动物已经在动物园里。')
            self._animals.append(animal)
        else:
            self._animals.append(animal)
    
    #查看动物园里有什么动物：
    @property
    def animals(self):
        for a in self._animals:
            print(f'{a.__class__.__name__}: {a.name}, id: {id(a)}')


#判断动物园是否有某这种动物：
def getattr(zoo, animal):
    if isinstance(zoo, Zoo):
        for a in zoo._animals:
            if animal == a.__class__.__name__:
                return True
        else:
            return False
    else:
        print(f'{zoo}不是Zoo对象，请输入Zoo对象。')

if __name__ == '__main__':
    # 实例化动物园
    z = Zoo('时间动物园')
    # 实例化一只猫，属性包括名字、类型、体型、性格
    cat1 = Cat('大花猫 1', '食肉', '小', '温顺')
    # 增加一只猫到动物园
    z.add_animal(cat1)
    # 动物园是否有猫这种动物
    have_cat = getattr(z, 'Cat')

    #实例化第二只猫
    cat2 = Cat('花猫 2', '食肉', '小', '温顺')
    # 增加第二只猫
    z.add_animal(cat2)
    # 查看公园里的动物
    z.animals

