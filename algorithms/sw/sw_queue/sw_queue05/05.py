for i in range(1,int(input()) + 1):
    M, N = map(int,input().split())

    data = list(map(int,input().split()))

    for _ in range(N) : #회전은 앞에 원소를 빼서 다시 넣으면 된다.
        data.append(data.pop(0))
  

    print(f"#{i} {data[0]}")
