import collections

def bfs(row,col) :
    dr = [0,0,-1,1]
    dc = [-1,1,0,0]

    deq = collections.deque()
    deq.append((row,col))
    visited[row][col] = 1

    while len(deq) > 0 :
        row, col = deq.popleft()
        for i in range(4):
            nr = row + dr[i]
            nc = col + dc[i]

            if 0<= nr < N and 0 <= nc < M :
                if map_list[nr][nc] == 1:
                    if visited[nr][nc] == 0:
                        visited[nr][nc] = 1 
                        deq.append((nr,nc))


for i in range(1, int(input())+1):
    M, N, K = map(int,input().split())

    map_list = [[0 for _ in range(M)] for _ in range(N)]
    
    for _ in range(K):
        col, row = map(int,input().split())
        map_list[row][col] = 1

    visited = [[0 for _ in range(M)] for _ in range(N)]
    count = 0

    for col in range(M) :
        for row in range(N) :
            if map_list[row][col] == 1 :
                if visited[row][col] == 0:
                    count += 1
                    bfs(row,col)

    print(count)

### 다시 풀어본 ver

from collections import deque
import sys

input = sys.stdin.readline

dx = [0, 1, -1, 0]
dy = [1, 0, 0, -1]

T = int(input())

for _ in range(T):
    M, N, K = map(int, input().split())
    count = 0

    maps = [[0 for _ in range(M)] for _ in range(N)]
    for _ in range(K):
        x, y = map(int, input().split())
        maps[y][x] = 1

    for r in range(N):
        for c in range(M):
            if maps[r][c] == 1:
                count += 1
                queue = deque()
                queue.append((r, c))
                maps[r][c] = 0
                while queue:
                    y, x = queue.popleft()

                    for i in range(4):
                        ny, nx = y + dy[i], x + dx[i]

                        if 0 <= ny < N and 0 <= nx < M and maps[ny][nx] == 1:
                            queue.append((ny, nx))
                            maps[ny][nx] = 0

    print(count)

### dfs ver

from collections import deque
import sys
sys.setrecursionlimit(10 ** 6)
input = sys.stdin.readline

dx = [0, 1, -1, 0]
dy = [1, 0, 0, -1]

T = int(input())

def solve(maps, r, c):
    for i in range(4):
        ny, nx = r + dy[i], c + dx[i]

        if 0 <= ny < N and 0 <= nx < M and maps[ny][nx] == 1:
            maps[ny][nx] = 0
            solve(maps, ny, nx)

for _ in range(T):
    M, N, K = map(int, input().split())
    count = 0

    maps = [[0 for _ in range(M)] for _ in range(N)]
    for _ in range(K):
        x, y = map(int, input().split())
        maps[y][x] = 1

    for r in range(N):
        for c in range(M):
            if maps[r][c] == 1:
                count += 1
                maps[r][c] = 0
                solve(maps, r, c)

    print(count)