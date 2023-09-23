# 2020_카카오 블라인드 02_괄호 변환

def check(p) :
    stack = []
    chk_stack = []
    flag = True
    for k in range(len(p)) :
        stack.append(p[k])

    while stack :
        if stack[-1] == ')' :
            chk_stack.append(stack.pop())

        if not chk_stack :
            flag = False
            break

        temp = stack.pop()

        if temp != chk_stack[-1] :
            chk_stack.pop()
        else :
            chk_stack.append(temp)

    return flag

def uv_maker(p) :
    flag = False

    if len(p) != 0 :
        flag = check(p)
    
    elif len(p) == 0 :
        return ''

    if flag :
        return p

    temp = ''
    left = 0
    right = 0 
    stack = []
    for i in range(0, len(p)) :

        if p[i] == '(' :
            left += 1
        else:
            right += 1

        stack.append(p[i])

        if left == right and left > 0 :
            temp += func(stack, p[i+1:])
            return temp

def func(u,v) :
    temp_str = ''
    flag = True

    if len(u) != 0 :
        flag = check(u)

    if flag :
        temp_str += ''.join(u)
        temp_str += uv_maker(v)

    else :
        temp_str += '('
        temp_str += uv_maker(v) + ')'
        u.pop(0)
        u.pop(-1)

        for t in range(len(u)) :
            if u[t] == '(' :
                u[t] = ')'
            else:
                u[t] = '('

        temp_str += ''.join(u)
        return temp_str

    return temp_str

def solution(p):
    answer = ''
    flag = check(p)

    if flag:
        return p
    else :
        answer = uv_maker(p)

    return answer

print(solution("()))((()"))