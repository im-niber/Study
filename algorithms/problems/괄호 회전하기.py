# 코테에 스위프트가 없어서;; 파이썬 문법 공부할 겸 문제를 하나 품
# 스택을 사용해서 풀었는데, 다른 사람들 풀이보면 어차피 올바른 괄호는 붙어있는 것을 이용해서
# 간단하게 푸셨다,, 그리고 스택도 좀 이상하게 다룬듯 배열 2개를 사용했는데 하나면 되었을듯하다,,

from collections import deque

def solution(s):
    answer = 0
    arrS = list(s)

    for i in range(len(arrS)):
        arrS = list(arrS)

        temp = arrS[:]
        tempArr = list(temp.pop())

        for k in range(len(arrS)):
            if not temp and not tempArr :
                answer += 1
                break

            if not temp:
                break

            elif not tempArr:
                tempArr.append(temp.pop())

            if tempArr[-1] == ")" :
                if temp[-1] == "(" :
                    tempArr.pop()
                    temp.pop()

                else :
                    if temp :
                        tempArr.append(temp.pop())

            elif tempArr[-1] == "}" :
                if temp[-1] == "{" :
                    tempArr.pop()
                    temp.pop()

                else :
                    if temp :
                        tempArr.append(temp.pop())


            elif tempArr[-1] == "]" :
                if temp[-1] == "[" :
                    tempArr.pop()
                    temp.pop()

                else :
                    if temp :
                        tempArr.append(temp.pop())

            else :
                break

        arrS = deque(arrS)
        arrS.append(arrS.popleft())

    return answer
