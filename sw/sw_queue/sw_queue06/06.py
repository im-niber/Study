def bfs(row, col) :     #bfs 를 사용하여서 문제를 풀었다.
    dr = [0,0,-1,1]
    dc = [-1,1,0,0]

    queue = []
    queue.append((row,col))
    visited[row][col] = 1

    while len(queue) > 0 :
        row, col = queue.pop(0)
        for i in range(4) :
            nr = row + dr[i]
            nc = col + dc[i]
            if 0<= nr < M and 0<= nc < M :
                if matrix[nr][nc] == 3:
                    distance[nr][nc] = distance[row][col]       # 탈출점이므로 그전의 값을 대입해줌.
            
                elif matrix[nr][nc] == 0 and visited[nr][nc] == 0 :
                    visited[nr][nc] = 1
                    distance[nr][nc] = distance[row][col] + 1       # 거리간의 차이를 넣어줌
                    queue.append((nr,nc))

    return distance[end_row][end_col]   #만약 해당 점이 없다면 0이 이미 들어가있으므로 출구 도달 하는것과는 상관없이 return
                    
for i in range(1,int(input()) + 1):
    M = int(input())
    count = 0
    matrix = []
    distance = [[0] * M for _ in range(M)]      #해당 점이랑 출발점사이의 거리를 나타낼 행렬
    visited = [[0 for _ in range(M)] for _ in range(M)]
    for k in range(M):
        array = list(map(int,input().strip()))
        matrix.append(array)
        if 2 in array :
            row = k
            col = array.index(2)
        if 3 in array :
            end_row = k
            end_col = array.index(3)
    
    print(f"#{i} {bfs(row, col)}")
    

  
