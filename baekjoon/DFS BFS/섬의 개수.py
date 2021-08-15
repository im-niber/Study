#섬의 개수 boj_4963 
from collections import deque

def bfs(row,col):
    dr=[-1,1,0,0,-1,1,1,-1]   #대각선 판단을 위한 리스트
    dc=[0,0,-1,1,1,1,-1,-1]

    deq = deque()
    deq.append((row,col))
    visited[row][col] = 1

    while deq :
        row, col = deq.popleft()

        for i in range(8):
            nr = row + dr[i]
            nc = col + dc[i]

            if 0<= nr < R and 0 <= nc < C :
                if visited[nr][nc] == 0 and maps[nr][nc] == 1:
                    deq.append((nr,nc))
                    visited[nr][nc] = 1

while True :
    C, R = map(int,input().split())

    if R == 0 and C == 0 :
        break

    maps = [list(map(int,input().split()))for _ in range(R)]
    visited = [[0 for _ in range(C)] for _ in range(R)] 

    count = 0

    for row in range(R):
        for col in range(C):
            if maps[row][col] == 1 and visited[row][col] == 0:
                bfs(row,col)
                count += 1

    print(count)
