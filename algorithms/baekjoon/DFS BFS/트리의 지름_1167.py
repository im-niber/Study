import sys
sys.setrecursionlimit(10**6)

def dfs(t) :
    for idx,weight in tree[t] :
        if visited[idx] == 0:
            visited[idx] = visited[t] + weight
            dfs(idx)

V = int(input())
tree = {}
visited = [0] * (V+1)

for i in range(1,V+1) :
    temp = list(map(int,input().split()))
    tree[temp[0]]= []
    for k in range(1,len(temp)-1,2) :
        tree[temp[0]].append((temp[k],temp[k+1]))
minvalue = 0

dfs(1)
for i in range(len(visited)) :
    if minvalue < visited[i] :
        minvalue = visited[i]
        idx = i
visited = [0] * (V+1)
dfs(idx)
visited[idx] = 0

print(max(visited))
# 위의 풀이로는 메모리 초과가 떠서 계속 실패하여서 밑의 풀이로는 통과 하였다
import sys
 
def get_farthest(i):
  farthest, dist = 0, 0
  visit = [False] * (v+1)
  visit[i] = True
  stack = link[i][:]

  for s in stack:
      visit[s[0]] = True
      if s[1] > dist:
          farthest = s[0]
          dist = s[1]
  
  while stack:
      bridge, now = stack.pop()
      for b in link[bridge]:
          if not visit[b[0]]:
              visit[b[0]] = True
              new = now + b[1]
              stack.append((b[0], new))
              if new > dist:
                  farthest = b[0]
                  dist = new

  return farthest, dist

v = int(sys.stdin.readline())
link = {}
for _ in range(v):
    data = list(map(int, sys.stdin.readline().split()))
    link[data[0]] = []
    for i in range(1, len(data)-1, 2):
        link[data[0]].append((data[i], data[i+1]))
 
farthest, dist = get_farthest(1)
sys.stdout.write(str(get_farthest(farthest)[1]))

