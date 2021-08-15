#11_자신을 제외한 배열의 곱

def output(data : list) -> list :
    result = []
    
    for i in range(len(data)):
        temp = 1
        
        for k in range(len(data)) :
            if i != k :
                temp *= data[k]
        result.append(temp)

    return result

print(output([1,2,3,4]))

# 왼쪽 곱셈의 결과에 오른쪽 곱셈 결과를 곱하는 풀이.

def output2(data : list) -> list :
    out = []
    p = 1

    #왼쪽 곱셈
    for i in range(0, len(data)):
        out.append(p)
        p *= data[i]
    p = 1
    # 왼쪽 곱셈 결과에 오른쪽 값을 차례대로 곱셈
    for i in range(len(data)-1,-1,-1):
        out[i] *= p
        p *= data[i]
    return out

print(output2([1,2,3,4]))


