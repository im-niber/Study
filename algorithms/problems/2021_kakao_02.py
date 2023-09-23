# 2021 카카오 블라인드 02_메뉴 리뉴얼
temp_list = []

def combination(list,k,r,target) :

    if len(target) == r :
        temp_list.append(target)
        return
    
    if k >= len(list) :
        return 

    combination(list, k + 1, r, target)
    combination(list, k + 1, r, target + list[k])

def solution(orders, course):
    for i in range(0,len(orders)) :
        orders[i] = sorted(orders[i])

    answer = []
    max = 2
    for i in range(len(course)) :
        for t in range(len(orders)) :
            combination(orders[t], 0, course[i], '')
            
        for item in temp_list :
            if max <= temp_list.count(item) :
                max = temp_list.count(item)
        
        for item in temp_list :
            if max == temp_list.count(item) :
                if item not in answer :
                    answer.append(item)
                
        temp_list.clear()
        max = 2

    answer = sorted(answer)
    return answer