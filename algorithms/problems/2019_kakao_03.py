# 2019_카카오 블라인드 03_후보키

def combination(temp_list,k,r,target,temp):
    if len(target) == r:
        temp.append(target)
        return
    
    if k >= len(temp_list) :
        return

    combination(temp_list, k+1, r, target,temp)
    combination(temp_list, k+1, r, target+[temp_list[k]],temp)

    return temp

def solution(relation):
    tes = ""
    answer = []
    check = {}
    temp = []
    flag = 1
    chk = 0
    temp_list =[i for i in range(len(relation[0]))]
    length = len(relation)
    case = len(temp_list)

    for i in range(1, case+1) :
        temp = combination(temp_list, 0, i, [], temp)
        for tc in temp:
            flag = 1
            b = set(tc)
            for i in range(len(answer)) :
                a = set(answer[i])
                if a.intersection(b) == a :
                    flag = 0
                    break
            if flag  :

                for item in relation :

                    for c in tc :
                        tes += str(tc)
                        tes += item[c]

                    if tes not in check :
                        check[tes] = 1
                        chk += 1
                        tes = ""

                    else :
                        tes = ""
                        chk = 0
                        break

                if chk == length :
                    answer.append(tc)
                    chk = 0

        temp.clear()
    return len(answer)
    
# print(solution([["100","ryan","music","2"],["200","apeach","math","2"],
# ["300","tube","computer","3"],["400","con","computer","4"],
# ["500","muzi","music","3"],["600","apeach","music","2"]]))

# print(solution([["100"]]))

print(solution([["100","100","ryan","music","2"], ["200","200","apeach","math","2"], ["300","300","tube","computer","3"], 
["400","400","con","computer","4"], ["500","500","muzi","music","3"],
 ["600","600","apeach","music","2"]]))