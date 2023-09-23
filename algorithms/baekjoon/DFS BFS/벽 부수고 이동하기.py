from collections import deque

dx = [0,0,-1,1]
dy = [-1,1,0,0]

def bfs():
    deq = deque()
    deq.append((0,0,0))
    visited[0][0][0] = 1

    while deq :
        y, x, chk = deq.popleft()

        if y == N-1 and x == M-1 :
            return visited[chk][y][x]

        for i in range(4) :
            ny = y + dy[i]
            nx = x + dx[i]
            
            if 0<= ny < N and 0<= nx < M and visited[chk][ny][nx] == 0:
                if area[ny][nx] == 1 :
                    if chk == 0 and visited[1][ny][nx] == 0:
                        deq.append((ny,nx,1))
                        visited[1][ny][nx] = visited[0][y][x] + 1
                else :
                    deq.append((ny,nx,chk))
                    visited[chk][ny][nx] = visited[chk][y][x] + 1
    return -1

N, M = map(int,input().split())
area = [list(map(int,input())) for _ in range(N)]
visited = [[[0 for _ in range(M)] for _ in range(N)] for _ in range(2)]

if N == 1 and M == 1 :
    print(1)
    
else :
    print(bfs())