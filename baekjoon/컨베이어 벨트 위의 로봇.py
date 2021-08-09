'''
시도는 하였으나 실패한 코드를 첨부함.
내려 가는걸 밑에 벨트에 넣고 우선순위도 비교 하는식으로 하려고 하였다.
'''

from collections import deque

N, K = map(int,input().split())
dura = deque(map(int,input().split()))

is_Robot = [[101,False] for _ in range(2*N)]

true_list = list()

order_count = 0
count = 0

# is_Robot[0][1] = True
# is_Robot[0][0] = order_count
# order_count += 1
# dura[0] -= 1

while True :
    dura_count = 0
    count += 1 

    dura.insert(0,dura.pop())
    is_Robot.insert(0,is_Robot.pop())

    for i in range(0,len(is_Robot)):
        if is_Robot[i][1] == True :
            true_list.append(is_Robot[i])

    for robot in sorted(true_list) :
        i = is_Robot.index(robot)
        if i == 2*N - 1 :
            if dura[0] >= 1 and is_Robot[0][1] ==  False :
                is_Robot[i][1] = False
                is_Robot[0][1] = True
                is_Robot[0][0] = is_Robot[i][0]
                is_Robot[i][0] = 101 
                dura[0] -= 1
        else :
            if dura[i+1] >= 1 and is_Robot[i+1][1] == False :
                is_Robot[i][1] = False
                is_Robot[i+1][1] = True
                is_Robot[i+1][0] = is_Robot[i][0]
                is_Robot[i][0] = 101
                dura[i+1] -= 1
        
        true_list.pop(true_list.index(robot))
       

    if dura[0] >= 1 :
        is_Robot[0][1] = True
        is_Robot[0][0] = order_count
        order_count += 1
        dura[0] -= 1

    for k in range(0,2*N) :
        if dura[k] == 0 :
            dura_count += 1

        if K == dura_count :
            break

    if K == dura_count :
        break

print(count)
