'''
푸는 중.. 
'''


from collections import deque

def func(num,op_idx,i) :
    if op_idx == 0 :
        num[i+1] += num[i] 

    elif op_idx == 1 :
        num[i+1] -= num[i]

    elif op_idx == 2 :
        num[i+1] *= num[i]
    
    else :
        if num[i] < 0:
            num[i] *= -1
            num[i+1] //= num[i]
            num[i+1] *= -1
            
        else :
            num[i+1] //= num[i]
    
    return num[i+1]


def dfs(num,op_idx,idx) :
    global max_num
    global min_num

    temp = func(num,op_idx,idx)
    idx += 1

    if max_num < temp :
        max_num = temp
    
    if min_num > temp :
        min_num = temp

    if idx == len(num) :
        return 

    for i in range(4):
        if op[i] != 0:
            op[i] -= 1
            dfs(num,i,idx)
            op[i] += 1
    

N = int(input())
number = list(map(int,input().split()))
op = list(map(int,input().split()))

sum_num = 0
max_num = -1000000001
min_num = 10000000001

for i in range(4) :
    if op[i] != 0:
        op[i] -= 1
        dfs(number,i,0)
        op[i] += 1

print(max_num)
print(min_num)
