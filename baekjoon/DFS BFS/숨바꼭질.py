#숨바꼭질 boj_1697
import sys
from collections import deque

def bfs(data):
    deq=deque()
    deq.append(data)

    while deq :
        item = deq.popleft()
        
        if item == M :
            print(count[item])
            break

        for i in (item-1, item+1, item*2): # 경우를 나누어서 하나씩 받음. 
            if 0<= i <= MAX and not count[i]:
                count[i] = count[item] + 1
                deq.append(i)
           
MAX = 100000
input = sys.stdin.readline()
N, M = map(int,input.split())
count = [0] * (MAX+1) # 시간을 체크할 리스트를 만들어줌.

bfs(N)
