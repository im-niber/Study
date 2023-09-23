def chec(case) :
    result = []
    p = max(case)
    temp = [0 for i in range(p+1)]

    for item in case :
        temp[item] += 1
    
    for i in range(len(temp)):
        if temp[i] == 1 or temp[i] == 2:
            result.append(i)
    
    return result


test_case = [12,24,35,24,88,120,155,88,120,155]
print(chec(test_case))