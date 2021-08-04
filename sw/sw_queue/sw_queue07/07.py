def new_insert(data) :
    global rear
    if rear > 0 and rear <= M :
        data[rear-1] = pizza.pop(0)
        rear -= 1
    else :
        data[rear-1] = pizza.pop(0)
    
for i in range(1,int(input())+1) :
    M, N = map(int,input().split())
    data =list(map(int,input().split()))
    rear = M    
    pizza = [[j, data[j-1]] for j in range(1,N+1)]
    result = 0
    cir_queue = [0] * M
    
    while True :
        new_insert(cir_queue)
        if rear == 0 :
            break

    temp = cir_queue.pop()
    cir_queue.insert(0,temp)

    while len(cir_queue) > 1 :
        cir_queue[0][1] //= 2

        if cir_queue[0][1] != 0 :
            temp = cir_queue.pop()
            cir_queue.insert(0,temp)

        else :
            cir_queue.pop(0)
            if pizza :
                cir_queue.insert(0,pizza.pop(0))
                temp = cir_queue.pop()
                cir_queue.insert(0,temp)
            else :
                temp = cir_queue.pop()
                cir_queue.insert(0,temp)



    result = cir_queue[0][0]
    
    print(f"#{i} {result}")

