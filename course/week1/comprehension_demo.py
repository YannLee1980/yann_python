# 推导式生成 生成器
mygenerator = (i for i in range(10))
print(list(mygenerator))

# 推导式生成 元组
mytuple = tuple(i for i in range(5))
print(mytuple)

# 推导式生成集合
myset = {i for i in 'HarryPotter' if i not in 'er'}
print(myset)