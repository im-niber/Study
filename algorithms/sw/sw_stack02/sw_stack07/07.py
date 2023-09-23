#Backtracking을 사용하는 문제
#다른사람의 코드를 참고하였다 아직 재귀에 대해 이해가 부족한 것 같다..


def min_sum(idx, summ):
    global max_result
    if idx == count :       #count만큼 반복이 되었다면 값을 비교 후 return 해줌
        if summ < max_result :
            max_result = summ   
        return
    
    if summ >= max_result :     #가지치기 
        return

    for k in range(count):      
        if used[k] == False : # 사용하지 않았다면 실행 
            used[k] = True      # 사용하고있다고 true로 변경해줌
            min_sum(idx+1,summ+data_case[idx][k]) #행을 1 더해주고, 값을 더해 준 뒤 함수 호출
            used[k] = False
 

for i in range(1,int(input()) + 1):
    count = int(input())
    max_result = 999999999
    used = [False] * count
    data_case = []
    for _ in range(count):
        data = list(map(int,input().split()))
        data_case.append(data)
  
    min_sum(0,0)
    print(f"#{i} {max_result}")
