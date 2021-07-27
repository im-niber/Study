a = int(input())

for i in range(0,a):
    p = int(input())
    data = list(map(int,input().split(' ')))
    big = data[0]
    sm = data[0]

    for k in range(0, len(data)):
        if big < data[k] :
            big = data[k]
        if sm > data[k] :
            sm = data[k]
    
    print("#%d %d" %(i+1, big-sm))


