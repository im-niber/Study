from collections import deque

dx =[0, 0, -1, 1]
dy =[-1, 1, 0, 0]

def bfs(data,check_2) :
    safety_area = 0
    deq = deque()
    
    for item in check_2 :
        deq.append(item)
        while deq :
            y, x = deq.popleft()
            for i in range(4):
                ny = dy[i] + y
                nx = dx[i] + x
                if 0<= ny < N and 0<= nx < M and data[ny][nx] == 0 :
                    data[ny][nx] = 2
                    deq.append((ny,nx))

    for item in data :
        safety_area += item.count(0)

    result.append(safety_area)
    return 

def wall(data,checking) :
    if checking == 2:
        temp_data = [item[:] for item in data]
        bfs(temp_data, where_2)
        return

    for y in range(N) :
        for x in range(M) :
            if data[y][x] == 0 :
                data[y][x] = 1
                wall(area,checking+1)
                data[y][x] = 0
    
N, M = map(int,input().split())

where_2 = []
area = [list(map(int,input().split())) for _ in range(N)]
result = []

for i in range(N) :
    for k in range(M) :
        if area[i][k] == 2 :
            where_2.append((i,k))

for y in range(N) :
    for x in range(M) :
        if area[y][x] == 0 :
            area[y][x] = 1
            wall(area,0)
            area[y][x] = 0

print(max(result))