a = int(input())
for i in range(0,a):
    data = []
    test_case = list(map(int,input().split()))
    for k in range(test_case[0]):
        data.append(input())

    ran = test_case[0] - test_case[1] +1 # 구간을 정해줘야 하므로 변수로 만듦

    for item in data:
        for k in range(ran):
            temp_data = item[k:k+test_case[1]] # 슬라이싱을 사용해서 temp_data에 구간 만큼 값을 넣어줌
            if temp_data == temp_data[::-1] :   # ::-1 은 reversed 와 같은 효과
                print("#%d %s" %(i+1, temp_data))
                break

    h_data = []         # 세로로도 회문을 판단해야하므로 세로 문자열을 받을 리스트를 선언함

    for k in range(test_case[0]):       # 세로로 넣는 과정
        temp_data = []
        for p in range(test_case[0]):
            temp_data.append(data[p][k])
        case = ''.join(temp_data)
        h_data.append(case)

    for item in h_data:           #위의 가로 반복문을 그대로 가져오고 item in h_data 만 다름.
        for k in range(ran):
            temp_data = item[k:k+test_case[1]]
            if temp_data == temp_data[::-1] :
                print("#%d %s" %(i+1, temp_data))
                break
        
        
        
