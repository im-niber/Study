from itertools import combinations
from collections import deque

dx = [0,0,-1,1]
dy = [-1,1,0,0]

def solution(candidates):
    safety_area = 0
    temp_data = [item[:] for item in area]

    deq = deque()
    for v in where_2:
        deq.append(v)

    for cands in candidates:
        temp_data[cands[0]][cands[1]] += 1
        
    while deq:
        x,y = deq.popleft()

        for i in range(4):
            nx = x + dx[i]
            ny = y + dy[i]

            if 0<= nx < N and 0 <= ny < M and temp_data[nx][ny] == 0:
                temp_data[nx][ny] = 2
                deq.append((nx,ny))
    
    for item in temp_data :
        safety_area += item.count(0)
        
    return safety_area

N, M = map(int,input().split())
area = [list(map(int,input().split())) for _ in range(N)]

where_2 = []
where_0 = []
answer = 0

for i in range(N):
    for j in range(M):
        if area[i][j] == 2:
            where_2.append((i,j))
        elif area[i][j] == 0:
            where_0.append((i,j))

candidate = combinations(where_0,3)

for cand in candidate:
    answer = max(answer, solution(cand))

print(answer)