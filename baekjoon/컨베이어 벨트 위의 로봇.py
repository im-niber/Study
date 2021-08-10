'''
성공한 코드 , 이 밑에는 처음 시도하였다가 실패한 코드가 있.
문제를 좀 잘못 읽어서 시간을 많이 소요하였다.
'''
from collections import deque

N, K = map(int,input().split())
dura = deque(map(int,input().split()))

is_Robot = deque([101,False] for _ in range(2*N))


count = 0

while True :
    dura_count = 0
    count += 1 

    dura.appendleft(dura.pop())
    is_Robot.appendleft(is_Robot.pop())
    
    if is_Robot[N-1][1] == True :
        is_Robot[N-1][1] = False

    for i in range(N-2,0,-1) :
        if dura[i+1] >= 1 and is_Robot[i+1][1] == False and is_Robot[i][1] == T:
            is_Robot[i][1] = False
            is_Robot[i+1][1] = True
            is_Robot[i+1][0] = is_Robot[i][0]
            is_Robot[i][0] = 101
            dura[i+1] -= 1

        if is_Robot[N-1][1] == True :
            is_Robot[N-1][1] = False
       

    if dura[0] > 0 and is_Robot[0][1] == False :
        is_Robot[0][1] = True
        dura[0] -= 1

    if dura.count(0) >= K :
        break
    
print(count)

'''
다른 사람의 풀이를 보고 시간이 매우 빨라 
적어본 코드.
'''

N, K = map(int,input().split())
dura = list(map(int,input().split()))
robot = [0] * len(dura)

start = 0                   # start를 정해줌
end = N - 1                 # end 도 정해줌 투포인터라고 하나 이런걸 그랬던것 같다
restart = len(dura) - 1     # 배열길이를 초과할 경우를 대비해 정의해줌


count = 0
dura_count = 0

while dura_count < K :
    count += 1 
    robot[end] = 0          # 내리는 위치 판별.

    start -= 1              # 회전을 한다면 start 지점은 뒤에 있던 원소가 되므로 -1, end도 마찬가지 
    end -= 1                # 이 접근은 pop append 를 사용안하므로 상당히 빨라 지는 듯 하다. 

    if start < 0 :
        start = restart
    elif end < 0 :
        end = restart

    robot[end] = 0          # 회전은 하였으므로, 내리는 위치에 로봇이 있을 시 pop

    idx = end-1             # 반복 횟수를 정해줄 idx
    if idx < 0 :        
        idx = restart       
    while start != idx :    # start +1 부터 end-1의 범위를 while 문 하는듯 함.
        if robot[idx] == 1 :
            move = idx + 1
            
            if move > restart :
                move = 0

            if robot[move] == 0 and dura[move]>0 :
                robot[idx] = 0
                robot[move] = 1
                dura[move] -= 1
                if dura[move] == 0:
                    dura_count += 1
                    
        idx-=1                          # end-1 부터 해주므로 (먼저 들어온 box는 end에 가까울 수 밖에 없다.) idx-1을 해 다음 반복 을 시작.

        if idx < 0 :
            idx = restart


    if robot[start] == 0 and dura[start] >0 :
        robot[start] = 1
        dura[start] -= 1
        if dura[start] == 0:
                dura_count += 1

print(count)



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
