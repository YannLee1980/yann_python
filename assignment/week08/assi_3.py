# 作业三：
# 实现一个 @timer 装饰器，记录函数的运行时间，注意需要考虑函数可能会接收不定长参数。

import time
from functools import wraps

def timer(func):
    @wraps(func)
    def decorate(*args, **kwargs):
        time_start = time.time()
        ret = func(*args, **kwargs)
        time_end = time.time()
        print(f'运行时间:{time_end - time_start}')
        return ret
    return decorate

#测试：

@timer
def test(num, sleep=2):
    if int(num) > 0:
        result = 0
        for i in range(int(num)):
            result += i**i
#       print(f'Result:{result}')
    time.sleep(sleep)

test(999)
test(999, sleep=3)