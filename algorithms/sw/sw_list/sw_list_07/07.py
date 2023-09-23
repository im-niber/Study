a = int(input())

for i in range(0,a):
    # 입력을 받는 구간, count 는 충전 횟수, current 는 현재 위치
    count = 0
    current = 0
    data = list(map(int,input().split(' '))) # 0 : k, 1 : n, 2: m
    sample_data = list(map(int,input().split(' ')))
    
    # 무한 반복을 하고 break를 받아 종료하려고 함
    while True :
        # 현재 위치에서 k 만큼 이동해서 충전기가 있는 정류장이라면 if문 실행
        if current + data[0] in sample_data :
            count +=1
            current += data[0]

        # 그렇지 않은 경우.
        else :
            t = []
            #exit_count = 0
            p = 0
            # 충전기가 있는 정류장 만큼의 반복.
            for k in range(0, data[2]):
                # 현재 위치 보다 크고 k 더한거 보다 작은 정류장들을 t에 삽입.
                if current+data[0] > sample_data[k] and sample_data[k] > current :
                    t.append(sample_data[k])
            # t에 값이 존재한다면 최대값 반환 최소 충전횟수를 구해야하므로
            for item in sample_data:
                if item in t :
                    p = max(t)
            # p 가 현재 위치이거나 0 이라면 충전 할 정류장 위치에 도달할 수 없으므로 종료.
            if p == current or p == 0 :
                print("#%d %d" %(i+1, 0))
                break
            
            # 그렇지 않다면 p로 이동. count ++
            else :
                count += 1
                current = p
            
        # 이미 종점을 넘었거나 같다면 도착 한 의미 이므로 종료.
        if current + data[0] >= data[1] :
            print("#%d %d" %(i+1, count))
            break
