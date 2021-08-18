import sys
sys.setrecursionlimit(10000)

dx = [0,0,-1,1]    
dy = [-1,1,0,0]


# 시작점을 찾는 함수.
def check_num(data : list) :
  for i,item in enumerate(data) :
    if item.count(0) != M :
      for k in range(M) :
        if item[k] > 0 :
          y = i
          x = k
          break
  return y,x

# 만약 한번의 dfs를 실행한 후 방문 카운트를 세어서 한 덩어리 전부를 순회했는지 체크
def mountain_check(data : list) -> int:
  nums = 0
  for y in range(1,N-1):
    for x in range(1,M-1):
      if data[y][x] >= 1:
        nums += 1
  return nums

def dfs(y,x) :
  visited[y][x] = 1

  for t in range(4) :
    nx = x + dx[t]
    ny = y + dy[t]

    if 0<= nx < M and 0 <= ny < N :
      if check_map[ny][nx] == 0 :
        map[y][x] -= 1
        if map[y][x] < 0 :
          map[y][x] = 0

      elif visited[ny][nx] == 0 and check_map[ny][nx] > 0:
        dfs(ny,nx)


N, M = map(int,input().split())
map = [list(map(int, input().split())) for _ in range(N)]
empty_map = [[0 for _ in range(M)] for _ in range(N)]
visited = [[0 for _ in range(M)] for _ in range(N)]
check_map = [item[:] for item in map]
count = 0

while True :
  y, x= check_num(map)
  dfs(y,x)
  
  # 한덩어리라면 visited는 check_map과 빙산의 수가 같으므로 count +=1해주고 visited 초기화
  if mountain_check(visited) == mountain_check(check_map) :
    count += 1
    visited = [[0 for _ in range(M)] for _ in range(N)]

  else : 
    print(count)
    break

  check_map = [item[:] for item in map]

  if map == empty_map :
    print(0)
    break
