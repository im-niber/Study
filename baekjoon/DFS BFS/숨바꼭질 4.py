from collections import deque

rev = ['plus','minus','mul2']

def append(op, item) :
    deq2 = deque()
    deq2.append((op,item))

    while deq2 :
        chk, item = deq2.popleft()
        if chk == -1 :
            result.append(item)
            return
        result.append(item)
        
        if chk == 'plus' :
            if item - 1 in visited :
                deq2.append((visited[item-1],item-1))

        elif chk == 'minus' :
            if item + 1 in visited :
                deq2.append((visited[item+1],item+1))
    
        else :
            if item / 2 in visited :
                deq2.append((visited[item//2], item//2))

def bfs(n):
    deq = deque()
    deq.append((-1,n))
    visited[n] = -1

    while deq :
        chk, item = deq.popleft()

        if item == K :
            print(answer[item])
            append(chk,item)
            return
        
        for op, i in ((rev[0],item+1), (rev[1],item-1), (rev[2],item*2)) :
            if 0 <= i <= 100000 and not answer[i] :
                answer[i] = answer[item] + 1
                deq.append((op,i))
                if i not in visited :
                    visited[i] = op

N, K = map(int,input().split())


result = []
visited = {}
answer = [0] * 1000001

bfs(N)
for item in result[::-1] :
    print(item, end = ' ')