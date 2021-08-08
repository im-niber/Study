#연결 요소의 개수 boj_11724
import sys
from collections import deque

def bfs(data): # 함수 안에서 반복문을 돌리는게 빠를거라고 생각해 그런 식으로 풀어 보았다.
    global count
    deq = deque()

    for _ in range(N):                
        if False in visited:
            k = visited.index(False)

            if len(data[k]) == 0:         # 정점이 1개 있고 간선이 없는 경우는 개수로 카운팅 하는지 몰랐어서 몇 번 틀렸다..
                visited[k] = True
                count += 1
                continue

            deq.append(data[k])
            visited[k] = True
            while deq :
                node = deq.popleft()
                for i in node :
                    if visited[i] != True:
                        visited[i] = True
                        deq.append(data[i])
        else :
            break
        count += 1
        
input = sys.stdin.readline          #sys 모듈을 사용하니 시간이 꽤 감소하여서 놀람 ;
N, M = map(int,input().split())

node_list = {idx : [] for idx in range(1, N+1)}

for _ in range(M):
    idx, value = map(int,input().split())
    node_list[idx].append(value)
    node_list[value].append(idx)

visited = [False] * (N+1)
visited[0] = True             # 0번 정점은 없으므로 True로 해주고 함수를 시작함.
count = 0

bfs(node_list)

print(count)
