def bin_data(first,end): #계속해서 반으로 쪼개는 작업.
    if first == end :
        return first

    ft = bin_data(first, (first+end)//2)
    en = bin_data((first+end)//2 + 1, end)
    return winner(ft, en)


def winner(l,r) :   #승리한 index 반환 
    if data[l] == 1 :
        if data[r] == 2 :
            return r
        else :
            return l
    elif data[l] == 2 :
        if data[r] == 3 :
            return r
        else :
            return l
    elif data[l] == 3:
        if data[r] == 1 :
            return r
        else :
            return l


for i in range(1,int(input()) + 1):
    count = int(input())
    data = [0] + list(map(int,input().split()))
    result = 0

    result = bin_data(1,count)
    print(f"#{i} {result}")
