from collections import deque

def bfs(node,i): # bfs로 해결 함.
    global max_count
    deq = deque()
    deq.append(node[i])
    visited[i] = 1
    count = 0 

    while deq :
        count += 1
        item = deq.popleft()

        for data in item :
            if visited[data] == 0 :
                visited[data] = 1
                deq.append(node[data])
    
    return count          # count 값을 리턴하여서 count 가 제일 높은게 많은 양의 컴퓨터를 해킹한다는 뜻임.

N, M = map(int,input().split())

node = {idx+1 : [] for idx in range(N)}
visited = [0 for _ in range(N+1)]

data = deque()

for i in range(M) :
    A, B = map(int,input().split())
    node[B].append(A)           # 문제를 보면 양방향 그래프가 아닌 단방향 그래프로 설정 되어있어서 그에 맞게 설정함.

for t in range(1, N+1) :
    data.append(bfs(node,t))
    visited = [0] * (N+1)

max_result = max(data)

for i in range(len(data)):        # 노드 순서대로 bfs를 실행하므로 출력은 idx+1 을 해주면 된다.
    if data[i] == max_result :
        print(i+1, end =' ')
