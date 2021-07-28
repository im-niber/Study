a = int(input())

def bin_search(l,r,target):
    count= 0
    c = (l+r) // 2

    while True:
        c = (l+r) // 2
        if target == c :
            count += 1
            return count

        elif target < c :
            count += 1
            r = c
            continue

        else :
            count +=1
            l = c
            continue


for i in range(a):
    data = list(map(int,input().split()))
    l = 1
    r = data[0]
    count_a=bin_search(l,r,data[1])
    count_b=bin_search(l,r,data[2])

    if count_a > count_b :
        print("#%d %c" % (i+1, 'B'))
        continue

    elif count_a < count_b :
        print("#%d %c" % (i+1, 'A'))
        continue

    else :
         print("#%d %d" % (i+1, 0))


   
