import heapq

T = int(input())

ramen = []

for i in range(T):
    N, M = map(int,input().split())
    ramen.append((N,M))

ramen.sort()

q = []

for item in ramen :
    heapq.heappush(q,item[1])
    if item[0] < len(q) :
        heapq.heappop(q)

print(sum(q))