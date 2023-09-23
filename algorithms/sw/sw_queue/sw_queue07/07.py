def new_insert(data) : # 처음 큐를 채워주려고 뒤에서 부터 넣음
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
    pizza = [[j, data[j-1]] for j in range(1,N+1)] # index를 출력해야하므로 이중리스트로 만들어서 넣었다.
    result = 0
    cir_queue = [0] * M
    
    while True :    # 처음 큐에 넣는 과정
        new_insert(cir_queue)
        if rear == 0 :
            break

    temp = cir_queue.pop()      # 이 두줄이 회전하는 역할
    cir_queue.insert(0,temp)

    while len(cir_queue) > 1 :      # 간단한거 같았는데 처음 값을 입력할 때 튜플로 했다가 꼬여서 시간이 꽤 들었다.
        cir_queue[0][1] //= 2       # 조건만 체크해서 반복문을 돌리는 식으로 풀었다. 나중에 다른사람 풀이를 참고할 예정
                                    # 너무 조잡하게 푼 느낌이 없지않아 있는듯 ㅜ
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

