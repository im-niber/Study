from collections import deque
import sys
import copy

input = sys.stdin.readline

N, K = map(int, input().split())

maps = [list(map(int, input().strip())) for _ in range(N)]

dy = [0, 1, 0, -1]
dx = [1, 0, -1, 0]

while True:
    same_maps = copy.deepcopy(maps)
    visited = [[0 for _ in range(10)] for _ in range(N)]

    for r in range(N):
        for c in range(10):
            if visited[r][c] == 0 and maps[r][c] != 0:
                queue = deque()
                value = maps[r][c]
                
                queue.append((r, c))
                temp = []
                visited[r][c] = 1
                
                while queue:
                    y, x = queue.popleft()
                    temp.append((y, x))

                    for i in range(4):
                        ny, nx = y + dy[i], x + dx[i]

                        if 0 <= ny < N and 0 <= nx < 10 and \
                            visited[ny][nx] == 0 and value == maps[ny][nx]:
                            queue.append((ny, nx))
                            visited[ny][nx] = 1

                    
                if len(temp) >= K:
                    for ty, tx in temp:
                        maps[ty][tx] = 0
                else:
                    for ty, tx in temp:
                        visited[ty][tx] = 0
    
    for dr in range(N-1, 0, -1):
        for c in range(10):
            if maps[dr][c] == 0:
                for dr2 in range(dr-1, -1, -1):
                    if maps[dr2][c] != 0:
                        maps[dr][c] = maps[dr2][c]
                        maps[dr2][c] = 0
                        break

    if maps == same_maps: break

print(maps)

for y in range(N):
    for x in range(10):
        print(maps[y][x], end='')
    print()