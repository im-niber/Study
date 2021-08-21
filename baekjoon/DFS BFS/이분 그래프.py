# 실패한 풀이.. 이분 그래프는 모든 정점에 홀수인 사이클이 존재하면 안된다고 하여서
# 사이클을 판별하면서 길이가 홀수이면 break 하여 NO 출력하고 아니면 YES 출력으로 하려고하는데
# 메모리초과 시간초과가 너무 발생하여서 아무래도 코드의 문제인거 같은데 잘 모르겠다..
# 여러 시도중..


import sys
sys.setrecursionlimit(10 ** 6)

K = int(input())   

def dfs(check_node, pre_node, node, leng) :
  global flag
  visited[node] = 1

  if flag :     
    return True

  data = nodes[node]

  for item in data :
    if visited[item] == 0 :
      dfs(check_node, pre_node, item, leng+1)
    elif visited[item] == 1 and pre_node != item:
      if leng % 2 == 1 :
        flag = 1
        return True
      continue
  return

      
for _ in range(K) :
  flag = 0
  V, E = map(int,input().split())
  nodes = [[] for i in range(V+1)]
  visited = [0] * (V+1)

  for k in range(E) :
    V1, V2 = map(int,input().split())
    nodes[V1].append(V2)
    nodes[V2].append(V1)

  for i in range(1, V+1):
    if visited[i] == 0:
      dfs(i,i,i,-1)
      if flag :
        print("NO")
        break
  else :
    print("YES")