def combinations(t,result):

  if len(result) == R :
    full_result.append(result[:])
    return

  if t >= N :
    return

  combinations(t+1,result)
  combinations(t+1,result + [data[t]])

N, R = map(int,input().split())
data = [item for item in range(1,N+1)]
result = []
full_result = []
combinations(0,result)

for item in sorted(full_result) :
  for num in item :
    print(num , end = ' ')
  print()
