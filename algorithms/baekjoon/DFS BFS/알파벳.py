#DFS로 풀어보았는데 상당히 스트레스를 받은 문제.
#무슨 짓을 해도 시간초과가 뜨고 시간초과를 해결하면 90퍼대에서 틀렸다고 뜨는데
#초기값 1을 안줘서 그런걸 깨닫고 너무 화가 났다.

import sys
sys.setrecursionlimit(10000)

dx = [0,0,-1,1]     # 전역으로 주어 시간초과를 벗어나려고 발악함.
dy = [-1,1,0,0]

def dfs(y,x) :
  global max

  for t in range(4) :
    nx = x + dx[t]
    ny = y + dy[t]

    if 0<= nx < C and 0 <= ny < R and check_alpa[alp[ny][nx]] == 0 :
      check_alpa[alp[ny][nx]] = 1
      distance[ny][nx] = distance[y][x] + 1     # 처음칸과의 거리를 전부 계산하여서 최대값을 출력하는 형식
      if max < distance[ny][nx] and distance[ny][nx] <= 26 :
        max = distance[ny][nx]
      dfs(ny,nx)
      check_alpa[alp[ny][nx]] = 0   # 다른 경우도 체크해야하므로 0.
        

R, C = map(int,input().split())
alp = [list(map(lambda x: ord(x) - 65, input())) for _ in range(R)] # 맨처음에는 ord를 dfs안에
#alp = [list(input()) for _ in range(R)]                            # 사용하면서 풀었지만 이것도
distance = [[0 for _ in range(C)] for _ in range(R)]                # 시간에 영향을 줄 것 같아서 바꿈
check_alpa = [0] * 26

max = 1
check_alpa[alp[0][0]] = 1
distance[0][0] = 1
dfs(0,0)

print(max)