import collections

def bfs(row, col, h) :
    dr = [0,0,-1,1]
    dc = [-1,1,0,0]

    deq = collections.deque()
    deq.append((row,col))
    visited[row][col] = 1

    while len(deq) > 0 :
        row, col = deq.popleft()
        for i in range(4) :
            nr = row + dr[i]
            nc = col + dc[i]

            if 0<= nr < M and 0<= nc < M :
                if map_list[nr][nc] >= h :
                    if visited[nr][nc] == 0 :
                        visited[nr][nc] = 1
                        deq.append((nr,nc))
                    

M = int(input())
map_list = [list(map(int,input().split())) for _ in range(M)]
max_check = 0
count = 0
area = []

for k in range(M) :
    if max_check < max(map_list[k]) : 
        max_check=max(map_list[k])

for h in range(1,max_check+1) :
    visited = [[0 for _ in range(M)]for _ in range(M)]
    for col in range(M) :
            for row in range(M) :
                if map_list[row][col] >= h :
                    if visited[row][col] == 0:
                        count += 1
                        bfs(row,col,h)
                
    area.append(count)
    count = 0

print(max(area))
