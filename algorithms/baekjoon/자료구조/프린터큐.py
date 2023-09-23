a = int(input())

result = []

for i in range(a):
    
    count = 0
    b, c = list(map(int,input().split(' ')))
    queue = list(map(int,input().split(' ')))
    queue =[(i,idx) for idx, i in enumerate(queue)]
    
  
    while True:
        p = max(queue)
       # if queue[0][0] == max(queue, key=lambda x: x[0])[0]:
        if queue[0][0] == p[0]:
            count += 1
            if queue[0][1] == c:
                print(count)
                break
            else:
                queue.pop(0)
        else :
            queue.append(queue.pop(0))
        