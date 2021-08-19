import sys
sys.setrecursionlimit(100000)

T = int(input())

trees = [[] for _ in range(T+1)]
# trees = {idx : [] for idx in range(T+1)}
distance = [0 for _ in range(T+1)]

def dfs(node, leng) :
  for item in trees[node] :
    tree_node, weight = item
    if distance[tree_node] == -1 :
      distance[tree_node] = leng + weight
      dfs(tree_node, leng + weight)
  
for i in range(T-1):
  N, S, K = map(int,input().split())
  trees[N].append([S,K])
  trees[S].append([N,K])

dfs(1,0)

start_node = distance.index(max(distance))

distance = [-1] * (T+1)
distance[start_node] = 0
dfs(start_node, 0)

print(max(distance))