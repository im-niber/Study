def bfs(row, col) :
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
                    distance[nr][nc] = distance[row][col]
            
                elif matrix[nr][nc] == 0 and visited[nr][nc] == 0 :
                    visited[nr][nc] = 1
                    distance[nr][nc] = distance[row][col] + 1
                    queue.append((nr,nc))

    return distance[end_row][end_col]
                    
for i in range(1,int(input()) + 1):
    M = int(input())
    count = 0
    matrix = []
    distance = [[0] * M for _ in range(M)]
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
    

  