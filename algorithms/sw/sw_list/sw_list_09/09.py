a = int(input())

for i in range(0,a):
    max_result = 0
    min_result = 999999999 # 최소값을 구하기 위해 값을 크게 줌 float('inf') 도 가능.
    data = list(map(int,input().split()))
    sample_data = list(map(int,input().split()))
    
    #밑에 방식으로 해서 계속 memory error 가 발생했는데 아무래도 split(' ') 해서 그런것 같다.
    #뭔 짓을 해도 에러가 뜨길래 split() 로 바꾸니까 해결되었다..

  #  max_result = sum(sample_data[0:data[1]])
  #  min_result = sum(sample_data[0:data[1]])

   # for k in range(1, data[0] - data[1] +1):
    #    if max_result <= sum(sample_data[k:k+data[1]]) :
     #       max_result = sum(sample_data[k:k+data[1]])
      #  if min_result >= sum(sample_data[k:k+data[1]]) :
       #     min_result = sum(sample_data[k:k+data[1]])

     # 전체 크기와 구간이 같다면 0을 반환. break.
    if data[1] == data[0] :
        print("#%d %d" %(i+1, 0))
        break
       
     
    # 이중 반복문으로 문제를 해결. 처음부터 전체크기 - 구간 +1 로 처음 for문을 설정후
    # 그 k 값에서 구간만큼 값에 더해주고 비교를 하여 대입을 하면 max,min 값이 나오므로 두개의 차를 반환하면 해결
    for k in range(0, data[0] - data[1] +1):
        test_min = 0
        test_max = 0
        for j in range(k, k+data[1]):
            test_max += sample_data[j]
            test_min += sample_data[j]

        if test_max >= max_result :
            max_result = test_max
        if test_min <= min_result :
            min_result = test_min
        

    print("#%d %d" %(i+1, max_result - min_result))
    
    
