for i in range(1,int(input()) + 1):
    data = input()
    l_point = 0       #인덱스를 나타내기 위해 두개의 변수 사용
    r_point = 1

    while r_point != len(data) :
        if data[l_point] == data[r_point] : # 앞뒤로 2개만 같으면 지우는 조건식
            temp_data = data[0:l_point]       # 처음에는 del data[l_point:r_point+1] 을 해서 실행하였지만
            temp_data += data[r_point+1:]     # 문자열은 del 함수를 사용 못하여서 반복문자인 열 빼고 복사를 해주는 식으로 문제를 풀었다.
            data = temp_data
            l_point = 0
            r_point = 1
        else :
            l_point += 1
            r_point += 1


    print(f"#{i} {len(data)}")
