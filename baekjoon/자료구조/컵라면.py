import heapq

time = 1
count = 0
chk = -1

T = int(input())

ramen = [[] for _ in range(T+2)]
size = [0 for _ in range(T+2)]

for i in range(T):
    N, M = map(int,input().split())
    if len(ramen[N]) == 0 :
        ramen[N] = [-M]
    else :
        ramen[N].append(-M)

for i in range(1,T+1):
    size[i] = len(ramen[i])

for i in range(1, T+1):
    while(time <= i):
        b = 0
        if len(ramen[i]) != 0 :
            heapq.heapify(ramen[i])
            heapq.heapify(ramen[i+1])
            a = ramen[i][0]
            if i != chk and len(ramen[i+1]) != 0:
                b = ramen[i+1][0]
            if (a <= b) :
                count += a
                heapq.heappop(ramen[i])
            else :
                count += b
                heapq.heappop(ramen[i+1])

            time += 1

        else :
            break
    else :
        continue

print(-count)