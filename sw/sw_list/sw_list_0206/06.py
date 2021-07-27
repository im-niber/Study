data = [i for i in range(1,13)]


res = []
# 부분집합 전부 구함
for k in range(1<<len(data)):
    part_set = []
    for j in range(len(data)):
        if k&(1<<j) :
            part_set.append(data[j])
    res.append(part_set)

a = int(input())
for i in range(0,a):
    result = 0
    input_data = list(map(int,input().split()))
    
    # 체크 후 출력
    for t in range(len(res)):
        if len(res[t]) == input_data[0] and sum(res[t]) == input_data[1] :
            result += 1
            
    print("#%d %d" %(i+1, result))
    
