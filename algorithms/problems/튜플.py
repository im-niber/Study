# 원소중 제일 많이 나온게 순서대로 들어가면 된다

def solution(s):
    answer = []
    data = dict()

    strs = s.replace("{", "")
    strs = strs.replace("}", "")

    strs = strs.split(",")
    strs = list(map(int, strs))
    strs.sort()

    count = 0
    while True:
        data[strs[count]] = strs.count(strs[count])
        count += data[strs[count]]

        if count >= len(strs):
            break

    answer = sorted(data.items(), key=lambda x: x[1], reverse=True)
    dictStr = dict(answer)
    answer = list(map(int, dictStr.keys()))
    return answer
