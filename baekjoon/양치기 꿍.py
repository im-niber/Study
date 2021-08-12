#양치기 꿍 v=늑대 k=양 #=울타리 .= 빈공간
from collections import deque

def bfs(row,col):
    global v_count
    global k_count
    v = 0
    k = 0

    dr=[-1,1,0,0]
    dc=[0,0,-1,1]

    if maps[row][col] == 'v' :
        v +=1
    elif maps[row][col] == 'k' :
        k +=1

    deq = deque()
    deq.append((row,col))
    visited[row][col] = 1

    while deq :
        row, col = deq.popleft()

        for i in range(4):
            nr = row + dr[i]
            nc = col + dc[i]

            if 0<= nr < R and 0 <= nc < C :
                if visited[nr][nc] == 0 and maps[nr][nc] == 'v' :
                    v += 1
                    deq.append((nr,nc))
                    visited[nr][nc] = 1
                    
                elif visited[nr][nc] == 0 and maps[nr][nc] == 'k' :
                    k += 1
                    deq.append((nr,nc))
                    visited[nr][nc] = 1
                
                elif maps[nr][nc] == '.' and visited[nr][nc] == 0 :
                    deq.append((nr,nc))
                    visited[nr][nc] = 1

                else :
                    continue
    
    if k <= v : 
        k_count -= k

    else :
        v_count -= v


R, C = map(int,input().split())

maps = []
visited = [[0 for _ in range(C)] for _ in range(R)] 

k_count = 0
v_count = 0

for i in range(R):
    data = input()
    v_count += data.count('v')
    k_count += data.count('k')
    maps.append(data)


for row in range(R):
    for col in range(C):
        if maps[row][col] == 'v' or maps[row][col] == 'k' :    # v이거나 k 일때 해주면댐
            bfs(row,col)

print(k_count, v_count)
