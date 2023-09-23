# 2019_카카오 블라인드 01_오픈채팅방

def solution(record):
    answer = []
    temp = {}

    for i in range(len(record)-1,-1,-1) :
        tes = record[i].split(' ')
        if ("Change" in record[i] or "Enter" in record[i]) and tes[1] not in temp:
            temp[tes[1]] = tes[2]

    for i in range(len(record)) :
        if "Enter" in record[i] :
            tes = record[i].split(' ')
            answer.append("{}님이 들어왔습니다.".format(temp[tes[1]]))
            continue
        if "Leave" in record[i] :
            tes = record[i].split(' ')
            answer.append("{}님이 나갔습니다.".format(temp[tes[1]]))
            continue

    return answer

print(solution(["Enter uid1234 Muzi", "Enter uid4567 Prodo","Leave uid1234",
"Enter uid1234 Prodo","Change uid4567 Ryan"]))