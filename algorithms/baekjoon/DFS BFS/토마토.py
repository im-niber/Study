import collections

def bfs(row, col) :   #bfs를 사용하였다
    dr = [0,0,-1,1]
    dc = [-1,1,0,0]

    for i in range(4) :
        nr = row + dr[i]
        nc = col + dc[i]

        if 0 <= nr < N and 0 <= nc < M:
            if map_list[nr][nc] == 0 and map_list[nr][nc] != -1:
                if visited[nr][nc] != 1 :
                    map_list[nr][nc] = 1
                    visited[nr][nc] = 1
                    one_queue.append((nr,nc))
          
M, N = map(int,input().split())

one_queue = collections.deque()

zero_check = True     # 처음 입력에 0이 없는지 체크
map_zero_check = False # bfs 함수 실행 후 맵리스트에 0이 있는지 체크

map_list = [[0 for _ in range(M)] for _ in range(N)]

for k in range(N):
   data = list(map(int,input().split()))
   for i in range(len(data)):
       map_list[k][i] = data[i]
       if data[i] == 1:
           one_queue.append((k,i))    # 값이 1의 좌표를 넣어줌 

for t in range(len(map_list)):
    if 0 not in map_list[t] :
        zero_check = True
    else :
        zero_check = False
        break

visited = [[0 for _ in range(M)] for _ in range(N)]
day = -1

while len(one_queue) > 0 and zero_check == False:
    day += 1
    for k in range(0,len(one_queue)):
        row, col = one_queue.popleft()
        visited[row][col] = 1
        bfs(row, col)

for t in range(len(map_list)):
    if 0 in map_list[t] :
        map_zero_check = True
        break

if zero_check :
    print("0")

elif zero_check == False and map_zero_check == True:
    print("-1")

else :
    print(day)
