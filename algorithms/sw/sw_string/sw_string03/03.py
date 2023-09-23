def boyer_match(test,data): # 보이어-무어 방식으로 풀려고함.
    n = len(test)
    j = n-1
    R_test = test[::-1]     # 거꾸로 된 배열을 만들어줌.
   # pivot = list(range(len(test)))

    while j < len(data) :   # 반복은 비교할 문자열 전체길이 보다 작게함
        t = n-1
        count = 0
        if data[j] == test[t]:    # 끝 문자가 같다면 패턴과 같은지 비교 시작
            count += 1
            t -= 1
            for k in range(j-1,j-n,-1): #끝 문자는 비교했으므로 그 앞문자부터 패턴길이만큼 비교해줌
                if test[t] == data[k]:
                    count += 1
                    if count == n :
                        return 1
                    t-=1 
                    continue
                 else :                    # 끝 문자는 같으나 패턴이 다른 경우에 count로 비교를하여서 count 가 패턴의 길이 -1 과 같다면 패턴의 가능성이 없으므로          
                    if count == n - 1 :      # 패턴 길이만큼 더하였고 그렇지 않다면 count만큼 더해서 while문 비교 다시 시작
                        j += n
                    else :
                        j += count
                    break
        else :
            if data[j] in R_test : # 만약 끝문자가아니고 r_test 패턴의 스킵배열에 문자가있다면 실행
                plus = R_test.index(data[j])    # 인덱스만큼 길이를 더해서 비교 시작하면 된다. 0인경우에는 +1 을 하였으나 이렇게 하는게 맞는지는 잘 모르겠다.
                if plus == 0 :                  
                    j += 1          
                else :
                    j += plus
                continue
            else :            # 스킵배열에도 없는 문자라면 패턴 길이만큼 더해서 while문 다시 시작.
                j += n
    return 0


a = int(input())
for i in range(0,a):
    test_case = input()
    input_data = input()

    result = boyer_match(test_case, input_data)

    print("#%d %d" %(i+1, result))

