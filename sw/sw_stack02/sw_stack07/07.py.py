def min_sum(idx, summ):
    global max_result
    if idx == count :
        if summ < max_result :
            max_result = summ
        return
    
    if summ >= max_result :
        return

    for k in range(count):
        if used[k] == False :
            used[k] = True
            min_sum(idx+1,summ+data_case[idx][k])
            used[k] = False
 

for i in range(1,int(input()) + 1):
    count = int(input())
    max_result = 999999999
    used = [False] * count
    data_case = []
    for _ in range(count):
        data = list(map(int,input().split()))
        data_case.append(data)
  
    min_sum(0,0)
    print(f"#{i} {max_result}")