import sys
sys.setrecursionlimit(10000)

def dfs(maps,y,x) :
  dx = [0,0,-1,1]
  dy = [-1,1,0,0]

  if maps == maps_rgb :
    check_area = maps[y][x]
    visited[y][x] = 1

    for t in range(4) :
      nx = x + dx[t]
      ny = y + dy[t]
      if 0<= nx < N and 0 <= ny < N and maps[ny][nx] == check_area and visited[ny][nx] == 0:
        visited[ny][nx] = 1
        dfs(maps,ny,nx)

  else :
    check_area = maps[y][x]
    visited2[y][x] = 1

    for t in range(4) :
      nx = x + dx[t]
      ny = y + dy[t]
      if 0<= nx < N and 0 <= ny < N and maps[ny][nx] == check_area and visited2[ny][nx] == 0 :
        visited2[ny][nx] = 1
        dfs(maps,ny,nx)
  return 1
      
# def dfs2(y,x) :
#   dx = [0,0,-1,1]
#   dy = [-1,1,0,0]
  
#   check_area = maps[y][x]
#   visited[y][x] = 1

#   for t in range(4) :
#     nx = x + dx[t]
#     ny = y + dy[t]
#     if check_area == 'R' or check_area == 'G' :
#       if 0<= nx < N and 0 <= ny < N and maps[ny][nx] != 'B' and visited[ny][nx] != 1 :
#         visited[ny][nx] = 1
#         dfs2(ny,nx)

#     else :
#       if 0<= nx < N and 0 <= ny < N and maps[ny][nx] == check_area and visited[ny][nx] != 1 :
#         visited[ny][nx] = 1
#         dfs2(ny,nx)



N = int(input())
visited = [[0 for _ in range(N)] for _ in range(N)]
visited2 = [[0 for _ in range(N)] for _ in range(N)]
maps_rgb =[list(input()) for _ in range(N)]
maps_rb = [[x if x == 'B' else 'R' for x in y]for y in maps_rgb]

#maps = [[0 for _ in range(N)] for _ in range(N)]
result = [0,0]

# for i in range(N) :
#   maps[i] = input()

for i in range(N):
  for k in range(N):
    if visited[i][k] == 0 :
      result[1] += dfs(maps_rgb,i,k)
    if visited2[i][k] == 0 :
      result[0] += dfs(maps_rb,i,k)

# visited = [[0 for _ in range(N)] for _ in range(N)]
# for i in range(N):
#   for k in range(N):
#     if visited[i][k] == 0 :
#       result[0] += 1
#       dfs2(i,k)

print(result[1], result[0])
