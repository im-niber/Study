import collections

def bfs(data, start) :
    deq = collections.deque()
    deq.append(data[start])
 
    visited[start] = 1

    while len(deq) > 0 :
        item = sorted(deq.popleft())
        for i in item :
            if visited[i] != 1 :
                visited[i] = 1
                deq.append(data[i])

# 1번 컴퓨터가 바이러스 걸리는 기준.

M = int(input())
N = int(input())
node_list = {idx : [] for idx in range(1, M+1)}

for _ in range(N):
    idx, value = map(int,input().split())
    node_list[idx].append(value)
    node_list[value].append(idx)

visited = [0 for i in range(M+1)]

bfs(node_list, 1)
print(sum(visited)-1)
