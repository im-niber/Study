for i in range(1,int(input()) + 1):
    data = list(input().split()) 
    forth = []
    left_num = 0
    right_num = 0
    
    for item in data :
        t=item.isalnum() # 숫자인지 문자인지 판별하는 함수, 문자는 안들어오므로 이 함수를 사용하였다
        if t :
            forth.append(int(item))
        else :
            if item == '+' and len(forth) >= 2:   # 연산자라면 pop을 두번해서 계산한 뒤 스택에 넣어줌. 이 때 스택안에 길이가 2는 넘어야 가능
                right_num = forth.pop()
                left_num = forth.pop()
                forth.append(left_num + right_num)

            elif item == '-' and len(forth) >= 2 :
                right_num = forth.pop()
                left_num = forth.pop()
                forth.append(left_num - right_num)
            
            elif item == '*' and len(forth) >= 2 :
                right_num = forth.pop()
                left_num = forth.pop()
                forth.append(left_num * right_num)
            
            elif item == '/' and len(forth) >= 2 :
                right_num = forth.pop()
                left_num = forth.pop()
                forth.append(left_num // right_num)

            elif item == '.' and len(forth) == 1:
                result = forth.pop()
                break

            else :
                result ="error"
                break

    print(f"#{i} {result}")
