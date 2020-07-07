def chain(num):
    for i in range(num):
        yield i
num = 5
y = chain(num)
next(y)
list(y)
next(y)