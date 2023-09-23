import sys
sys.setrecursionlimit(10000)

def dfs(y,x) :
  dx = [0,0,-1,1]
  dy = [-1,1,0,0]
  global temp
  
  maps[y][x] = 1

  for t in range(4) :
    nx = x + dx[t]
    ny = y + dy[t]
    if 0<= nx < N and 0 <= ny < M and maps[ny][nx] == 0 :
      maps[ny][nx] = 1
      temp += 1
      dfs(ny,nx)

M, N, K = map(int,input().split())
#visited = [[0 for _ in range(N)] for _ in range(M)]
maps = [[0 for _ in range(N)] for _ in range(M)]
xy = []
temp = 0

for i in range(K) :
  x1, y1, x2, y2 = map(int,input().split())
  
  for y in range(y1,y2):
    for x in range(x1,x2) :
      maps[y][x] = 1

for i in range(M):
  for k in range(N):
    if maps[i][k] == 0 :
      temp += 1
      dfs(i,k)
      xy.append(temp)
      temp = 0


print(len(xy))
xy.sort()
for item in xy :
  print(item, end = ' ')