# 装饰器在模块导入的时候自动运行

def decorate(func):
    print('running in testmodule.')
    def inner():
        return func()
    return inner

@decorate
def func2():
    print('in func2()')