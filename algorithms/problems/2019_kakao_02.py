# 2019_카카오 블라인드 02_실패율

def solution(N, stages):
    answer = []
    check = {idx:0 for idx in range(1,N+2)}
    temp = len(stages)

    for i in range(len(stages)) :
        check[stages[i]] += 1

    for k in range(1,len(check)) :
        if temp != 0 :
            data = check[k] / temp
            temp -= check[k]
            check[k] = data
        else :
            check[k] = 0
        answer.append(k)

    answer = sorted(answer, key = lambda x: check[x], reverse=True)

    return answer