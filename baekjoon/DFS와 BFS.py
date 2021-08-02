import collections

def bfs(data, start) :
    deq = collections.deque()
    deq.append(data[start])
    bfs_text.append(start)
    visited[start] = 1

    while len(deq) > 0 :
        item = sorted(deq.popleft())
        for i in item :
            if visited[i] != 1 :
                visited[i] = 1
                bfs_text.append(i)
                deq.append(data[i])


def dfs(data, start) :
    if visited[start] != 1 :
        deq.append(data[start])
        dfs_text.append(start)
        visited[start] = 1

    while len(deq) > 0 :
        item = sorted(deq.pop())
        for i in item :
            if visited[i] != 1:
                visited[i] = 1
                dfs_text.append(i)
                deq.append(data[i])
                dfs(data,i)
                


bfs_text = []
dfs_text = []

M, N, start = map(int,input().split())

node_list = {idx : [] for idx in range(1, M+1)}

for _ in range(N):
    idx, value = map(int,input().split())
    node_list[idx].append(value)
    node_list[value].append(idx)


visited = [0 for i in range(M+1)]
bfs(node_list,start)
visited = [0 for i in range(M+1)]
deq = collections.deque()
dfs(node_list,start)

for item in dfs_text :
    if item == dfs_text[len(dfs_text)-1] :
        print(item)
    else :
        print(item, end=' ')

for item in bfs_text :
    if item == bfs_text[len(dfs_text)-1] :
        print(item)
    else :
        print(item, end=' ')