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

