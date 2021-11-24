import time
import random

ticket = ''
for i in range(15):
    s = 'abcdefghijklmnopqrstuvwxyz'
    # 获取随机的字符串
    ticket += random.choice(s)
print(ticket)
now_time = int(time.time())
ticket = 'TK' + ticket + str(now_time)

print(ticket)
print(len(ticket))