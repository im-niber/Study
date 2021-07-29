# 규칙을 찾아서 입력 범위인 10<= n <= 300 까지 result에 값을 넣어준뒤
# index를 계산해서 출력하는 형식으로 품

a = int(input())
q = 4 # 짝수항
p = 3 # 제곱
t = 4
result = [1,3,5,11,21]

for k in range(3,16) :
    result.append(t**k - result[q])
    result.append(t**k + result[q])   
    q +=2
    
for i in range(0,a):
    data = int(input())
    index= data // 10 - 1

    print("#%d %d" %(i+1, result[index]))
