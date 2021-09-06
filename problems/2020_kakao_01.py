# 2020_카카오 블라인드 01_문자열 압축

def solution(s):
    answer = len(s)

    for i in range(1, len(s)) :
        temp = ""
        cnt = 1
        for k in range(0, len(s), i) :
            
            if s[k:k+i] == s[k+i: k + i + i] :
                cnt += 1
                continue
        
            else :
                if cnt != 1 :
                    temp += str(cnt) + s[k:k+i]
                else :
                    temp += s[k:k+i]
                cnt = 1

        if len(temp) < answer :
            answer = len(temp)

    return answer

print(solution("xababcdcdababcdcd"))