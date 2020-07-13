import threading

def condition():
    ret = False
    r = input('>>>')
    if r == 'yes':
        ret = True
    return ret

def func(con, i):
    con.acquire()
    con.wait_for(condition)
    print(100 + i)
    con.release()

c = threading.Condition()
for i in range(10):
    t = threading.Thread(target=func, args=(c, i, ))
    t.start()