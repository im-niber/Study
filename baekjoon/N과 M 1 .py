def permutations(k):
  if k == R :
    for item in result :
      print(item, end = ' ')
    print()
    return

  for i in range(len(data)):
    if visited[i] == False :
      visited[i] = True
      result[k] = data[i]

      permutations(k+1)
      visited[i] = False


N, R = map(int,input().split())
data = [item for item in range(1,N+1)]
visited = [False for _ in range(N)]
result = [0 for i in range(R)]

permutations(0)
