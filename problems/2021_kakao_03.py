# 2021 카카오 블라인드 03_순위 검색
# 정확도는 맞으나, 효율성이 아직.. ㅜㅜ

def check(value, query, i, answer) :
    flag = 1
    for data in value :
        t = 0
        if int(query[-1]) <= int(data[-1]) :
            for k in range(len(query)-1) :
                if query[k] == 'and' :
                    continue
                if query[k] == '-' or query[k] == data[t] :
                    flag = 1
                    t += 1
                else :
                    flag = 0
                    break
        else :
            continue
            
        if flag :
            answer[i] += 1


def solution(info, query):
    answer = [0] * len(query)

    data = [item.split(' ') for item in info]
    query_data = [item.split(' ') for item in query]
    # query_data = {i: query[i].split(' ') for i in range(len(query))}
    i = 0
    for item in query_data :
        check(data,item,i,answer)
        i += 1

    return answer

print(solution(["java backend junior pizza 150","python frontend senior chicken 210","python frontend senior chicken 150","cpp backend senior pizza 260","java backend junior chicken 80","python backend senior chicken 50"],
["java and backend and junior and pizza 100","python and frontend and senior and chicken 200","cpp and - and senior and pizza 250","- and backend and senior and - 150","- and - and - and chicken 100","- and - and - and - 150"]))
