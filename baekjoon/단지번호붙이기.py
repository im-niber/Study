import collections

def bfs(row, col) :
    count_2 = 1
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

            if 0<= nr < M and 0 <= nc < M:
                if map_list[nr][nc] == 1:
                    if visited[nr][nc] != 1 :
                        count_2 += 1    
                        visited[nr][nc] = 1
                        deq.append((nr,nc))
        
    num_count.append(count_2)


M = int(input())

map_list = [[0 for _ in range(M)] for _ in range(M)]

for k in range(M):
    data = input()
    for i in range(len(data)):
        map_list[k][i] = int(data[i])


visited = [[0 for _ in range(M)] for _ in range(M)]
count = 0
num_count = []
for col in range(M):
    for row in range(M):
        if map_list[row][col] == 1:
            if visited[row][col] == 0 :
                count += 1
                bfs(row,col)

print(count)
for item in sorted(num_count) :
    print(item)