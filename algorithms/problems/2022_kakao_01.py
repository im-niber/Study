# 출처: 프로그래머스 코딩 테스트 연습, https://programmers.co.kr/learn/challenges

def solution(id_list, report, k):
    answer = []
    temp = {item : 0 for item in id_list}
    answer_dict = {item : 0 for item in id_list}
    report_dict ={}
    for i in range(len(report)) :
        res = report[i].split(' ')
        if res[0] not in report_dict :
            report_dict[res[0]] = []
            report_dict[res[0]].append(res[1])
            temp[res[1]] += 1
        else :
            if res[1] not in report_dict[res[0]] :
                report_dict[res[0]].append(res[1])
                temp[res[1]] += 1

    for idx,val in temp.items() :
        if val >= k :
            for id,test in report_dict.items() :
                if idx in report_dict[id] :
                    answer_dict[id] += 1
    for val in answer_dict.values() :
        answer.append(val)


    return answer
print(solution(["muzi", "frodo", "apeach", "neo"],
["muzi frodo","apeach frodo","frodo neo","muzi neo","apeach muzi"],2))

print(solution(["con", "ryan"],["ryan con", "ryan con", "ryan con", "ryan con"],3))