a = int(input())
for i in range(0,a):
    result = []
    test_case = int(input())
    input_data = list(map(int,input().split()))
    
    #오름차순, 내림차순 배열을 만들어줌.
    ascend_list = sorted(input_data)
    descen_list = sorted(input_data, reverse=True)
    
    
    #for문으로 result 리스트에 값을 넣어줌
    for k in range(len(input_data)):
       # 만약 두배열의 값이 같은 경우가 나온다면 마지막 항이므로 하나만 append 해주고 종료해줌.
        if descen_list[k] == ascend_list [k] :
            result.append(descen_list[k])
            break
        result.append(descen_list[k])
        result.append(ascend_list[k])
        
        
    # 출력형식 
    print("#%d" %(i+1) , end= ' ')
    for i in range(0,10):
        if i == 9 :
            print("%d" %result[i])
        else :
            print("%d" %result[i] , end = ' ')

    
