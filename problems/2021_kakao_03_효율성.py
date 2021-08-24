# 2021 카카오 블라인드 03_순위 검색
# 효율성은 좀 생각을 해봤지만 풀리지 않아 카카오 풀이를 보았습니다 ㅠㅠ

result = []
def combination(data, k, r, target):

    if len(target) == r :
        return result.append(target)
    
    if k >= len(data) :
        return 

    combination(data, k+1, r, target)
    combination(data, k+1, r, target + [data[k]])

def solution(info, query):
    answer = []
    data = {}
    for i in info :
        temp = i.split()
        check = temp[:-1]
        score = int(temp[-1])
        for i in range(5):
            result.clear()
            combination([0,1,2,3], 0, i, [])
            for c in result :
                case = check[:]
                for v in c :
                    case[v] = '-'
                change = ''.join(case)
                if change in data :
                    data[change].append(score)
                else :
                    data[change] = [score]

    for item in data.values() :
        item.sort()

    for q in query :
        ques = [i for i in q.split() if i != 'and']
        ques_check = ''.join(ques[:-1])
        ques_score = int(ques[-1])
        if ques_check in data :
            item = data[ques_check]
            if len(item) > 0 :
                start, end = 0, len(item)
                while start != end and start != len(item) :
                    if item[(start+end) // 2] >= ques_score :
                        end = (start + end) // 2
                    else :
                        start = (start + end) // 2 + 1
                answer.append(len(item) - start)
        else :
            answer.append(0)

    return answer

print(solution(["java backend junior pizza 150",
"python frontend senior chicken 210","python frontend senior chicken 150",
"cpp backend senior pizza 260","java backend junior chicken 80",
"python backend senior chicken 50"],
["java and backend and junior and pizza 100","python and frontend and senior and chicken 200","cpp and - and senior and pizza 250","- and backend and senior and - 150","- and - and - and chicken 100","- and - and - and - 150"]))
