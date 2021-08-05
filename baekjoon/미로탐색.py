import collections

def bfs(row, col) :
    dr = [0,0,-1,1]
    dc = [-1,1,0,0]

    deq = collections.deque()
    deq.append((row-1,col-1))
 
    visited[row-1][col-1] = 1
    distance[row-1][col-1] = 1

    while len(deq) > 0 :
        row, col = deq.popleft()
        for i in range(4) :
            nr = row + dr[i]
            nc = col + dc[i]
            if 0<= nr < M and 0<= nc < N :
                if nr == M-1 and nc == N-1 :
                    distance[nr][nc] = distance[row][col] + 1
                    return distance[nr][nc]
            
                elif maze[nr][nc] == 1 and visited[nr][nc] == 0 :
                    visited[nr][nc] = 1
                    distance[nr][nc] = distance[row][col] + 1
                    deq.append((nr,nc))

M, N = map(int,input().split())
maze = []
for i in range(M):
    data = list(map(int,input()))
    maze.append(data)

distance = [[0] * N for _ in range(M)]
visited = [[0 for _ in range(N)]for _ in range(M)]

print(bfs(1,1))
