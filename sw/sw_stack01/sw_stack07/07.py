test_case = ['(','{','[']   # 미리 배열을 만들어줌.
test_case2 =[')','}',']']

for i in range(int(input())):
    data = input()
    result = False
    chk_list = []

    for item in data :
        closed = 0
        if item in test_case : # 열린 괄호이면 일단 삽입 !
            chk_list.append(item)

        elif item in test_case2 : # 닫힌 괄호 일 때 조건들 체크.
            if item == ')' :
                if len(chk_list) == 0:  # 만약 chk_list : 열린괄호들을 넣는 배열에 원소가없다면 닫힌 괄호가 먼저 들어온 의미이므로 false.
                    result = False
                    break

                closed = chk_list.pop()

                if closed == '(' :
                    result = True
                else :
                    result = False
                    break
                
            elif item == '}' :
                if len(chk_list) == 0:
                    result = False
                    break
                
                closed = chk_list.pop()
            
                if closed == '{' :
                    result = True
                else :
                    result = False
                    break

            elif item == ']':
                if len(chk_list) == 0:
                    result = False
                    break
                
                closed = chk_list.pop()
                
                if closed == '[' :
                    result = True
                else :
                    result = False
                    break
                    
    if len(chk_list) != 0 : # 열린괄호가 배열안에 남아있다면 다 안닫혔으므로 
        result = False


    print("#%d %d" %(i+1, result))
