from collections import deque

def rotate_L(num):
    # return (num%1000) * 10 + (num // 1000)

    x1 = num // 1000
    x2 = (num % 1000) // 100 
    x3 = (num % 100) // 10  
    x4 = num % 10

    return x2*1000+x3*100+x4*10+x1


def rotate_R(num):
    # return (num%10) * 1000 + (num//10)

    x1 = num // 1000
    x2 = (num % 1000) // 100 
    x3 = (num % 100) // 10  
    x4 = num % 10

    return x4*1000+x1*100+x2*10+x3

def bfs(a,b):
    deq = deque()
    deq.append([a,''])
    visited = [0] * 10000
    visited[a] = (-1,a)

    while deq :
        num,strr = deq.popleft()

        if num == b :
            return strr
            # while True :
            #     if visited[num][0] == -1:
            #         break
            #     else :
            #         case.append(visited[num][0])
            #         num = visited[num][1]

            # for item in reversed(case):
            #     print(item,end='')
            # print()
            # return

        for chk,item in [('D',(num*2) % 10000), ('S',(num-1)%10000),('L',(num%1000) * 10 + (num // 1000)),('R',(num%10) * 1000 + (num//10))] :
            if visited[item] == 0:
                visited[item] = 1
                deq.append([item, strr+chk])


T = int(input())
for i in range(T) :
    case = []
    a,b = map(int,input().split())
    print(bfs(a,b) +'\n')
