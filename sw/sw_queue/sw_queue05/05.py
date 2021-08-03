for i in range(1,int(input()) + 1):
    M, N = map(int,input().split())

    data = list(map(int,input().split()))

    for _ in range(N) :
        data.append(data.pop(0))
  

    print(f"#{i} {data[0]}")