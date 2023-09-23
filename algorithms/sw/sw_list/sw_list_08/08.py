a = int(input())

for i in range(0,a):
    result = 0
    data = int(input())
    sample_data = input()
    # 딕셔너리 형태로 0~9 까지의 키의 값을 0 으로 만들어줌 count 용
    datas= {item : 0 for item in range(0,10)}

    # 문자열이므로 int를 하여 값에 +1 해줌
    for k in range(data):
        if int(sample_data[k]) in datas.keys() :
            datas[int(sample_data[k])] += 1

    #맥스값을 찾아냄
    result = max(datas, key = lambda x: datas[x])
    
    # 같은 값이 있을 수 있기 때문에 list를 하나 만듦
    same_list = []
  
    #same_list에 값을 넣고 마지막에 있는 값이 제일 idx 값이 크기 때문에 출력에는 [-1]함
    for k in range(0,10):
        if datas[result]  == datas[k] :
            same_list.append(k)


    print("#%d %d %d" %(i+1, same_list[-1], datas[same_list[-1]]))





    
    
