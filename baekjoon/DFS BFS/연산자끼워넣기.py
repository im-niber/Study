from collections import deque # import 하고 사용안하였다.. 

def func(temp,op_idx,i) : # 연산을 실행할 함수
    if op_idx == 0 :
        temp += number[i+1] 

    elif op_idx == 1 :
        temp -= number[i+1]

    elif op_idx == 2 :
        temp *= number[i+1]
    
    else :
        if temp < 0:
            temp *= -1
            temp //= number[i+1]
            temp *= -1
            
        else :
            temp //= number[i+1]
    
    return temp


def dfs(temp,op_idx,idx) :
    global max_num
    global min_num

    temp = func(temp,op_idx,idx)
    idx += 1

    if idx == len(number) - 1 :     # 한번의 연산과정이 전부 끝났다면 max min 값 비교하고 return

        if max_num < temp :
            max_num = temp
    
        if min_num > temp :
            min_num = temp

        return 

    for i in range(4):
        if op[i] != 0:
            op[i] -= 1
            dfs(temp,i,idx)
            op[i] += 1
    

N = int(input())
number = list(map(int,input().split()))
op = list(map(int,input().split()))

sum_num = 0
max_num = -1000000001
min_num = 10000000001

temp = number[0]

for i in range(4) :
    if op[i] != 0:
        op[i] -= 1
        dfs(temp,i,0)       # dfs 한 뒤에 i를 다시 연산자 리스트를 다시 원상복구해줌
        op[i] += 1

print(max_num)
print(min_num)
