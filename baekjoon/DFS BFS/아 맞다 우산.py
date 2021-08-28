from collections import deque
from sys import setrecursionlimit
setrecursionlimit(100000)

dx = [0,1,0,-1]
dy = [-1,0,1,0]

def bfs(sy,sx,walk,x_chk,visited2):
    deq = deque()
    deq.append((sy,sx,walk,x_chk))
    visited2 = [item[:] for item in temp_visited]

    while deq:
        y, x, walk, x_chk = deq.popleft()
        visited2[y][x] = 1

        for i in range(4) :
            ny = y + dy[i]
            nx = x + dx[i]

            if 0<= ny < M and 0<= nx < N and visited2[ny][nx] != 1 and area[ny][nx] != '#':
                if x_chk == X_count and area[ny][nx] == 'E' :
                    count.append(walk)
                    break

                if area[ny][nx] == 'S' :
                    deq.append((ny,nx,walk+1,x_chk))
                    visited2[ny][nx] = 1

                if area[ny][nx] == '.' :
                    deq.append((ny,nx,walk+1,x_chk))
                    visited2[ny][nx] = 1
            
                if area[ny][nx] == 'X' :
                    if X_visited[ny,nx] == 0 :
                        visited2[ny][nx] = 1
                        X_visited[ny,nx] = 1
                        bfs(ny,nx,walk+1,x_chk+1,[])
                        X_visited[ny,nx] = 0
                    else :
                        visited2[ny][nx] = 1
                        deq.append((ny,nx,walk+1,x_chk))

N, M = map(int,input().split())
area = [input() for _ in range(M)]
visited = [[0 for _ in range(N)] for _ in range(M)]
X_visited = dict()
X_count = 0

for i in range(len(area)):
    if 'S' in area[i] :
        for k in range(len(area[i])):
            if 'S' == area[i][k] :
                y,x = i, k
                break
    if 'X' in area[i] :
        for k in range(len(area[i])):
            if 'X' == area[i][k] :
                X_count += 1
                X_visited[i,k] = 0
    
temp_visited = [item[:] for item in visited]
count = []
bfs(y,x,0,0,[])

if count :
    print(min(count) +1)
else :
    print(1)
    