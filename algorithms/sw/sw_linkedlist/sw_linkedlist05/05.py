for i in range(1, int(input())+1):
    N, M, L = map(int,input().split())

    text = list(map(int,input().split()))

    for _ in range(M) :
        idx, value = map(int,input().split())
        text.insert(idx,value)

    
    print(f"#{i} {text[L]}")