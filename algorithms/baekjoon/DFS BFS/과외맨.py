from collections import deque

N = int(input())
dx = [-1, -1*N, (N-1), -1 * (N-1), N ,1]

def bfs(areas):
    global chk
    deq = deque()
    deq.append((areas[0],areas[1],areas[2]))
    visited[areas[0]] = [-1,1]

    while deq :
        idx, a, b = deq.popleft()

        if idx > chk :
            chk = idx

        if idx % (2*N -1) != 1 :
            if idx % (2*N-1) != N+1 :
                for i in range(0,3) :   
                    new_idx = idx + dx[i] - 1
                    if 0<= new_idx < last and a == area[new_idx][2] and visited[new_idx+1][0] == 0 :
                        visited[new_idx+1] = (idx , visited[idx][1] + 1 )
                        deq.append((new_idx +1, area[new_idx][1], area[new_idx][2]))
            else :
                for i in range(1,3) :
                    new_idx = idx + dx[i] - 1
                    if 0<= new_idx < last and a == area[new_idx][2] and visited[new_idx+1][0] == 0 :
                        visited[new_idx+1] = (idx , visited[idx][1] + 1 )
                        deq.append((new_idx +1, area[new_idx][1], area[new_idx][2]))

        if idx % (2*N-1) != N :
            if idx % (2*N-1) != 0 :
                for i in range(3,6) :
                    new_idx = idx + dx[i] - 1
                    if 0<=new_idx < last and b == area[new_idx][1] and visited[new_idx+1][0] == 0 :
                        visited[new_idx+1] = (idx, visited[idx][1] + 1)
                        deq.append((new_idx + 1, area[new_idx][1], area[new_idx][2]))
            else :
                for i in range(3,5) :
                    new_idx = idx + dx[i] - 1
                    if 0<=new_idx < last and b == area[new_idx][1] and visited[new_idx+1][0] == 0 :
                        visited[new_idx+1] = (idx, visited[idx][1] + 1)
                        deq.append((new_idx + 1, area[new_idx][1], area[new_idx][2]))


area = []
chk = 0
last = N**2 - (N//2)
visited = [[0,0]] * (last + 1)

for i in range(1, last + 1) :
    a,b = map(int,input().split())
    area.append((i,a,b))

move_list = []

bfs(area[0])
print(visited[chk][1])

while True :
    if chk == -1 :
        break

    move_list.append(chk)
    chk = visited[chk][0]

for item in reversed(move_list):
    print(item, end= ' ')