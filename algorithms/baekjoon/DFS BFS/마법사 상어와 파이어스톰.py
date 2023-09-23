dx = [0,0,-1,1]
dy = [-1,1,0,0]

def bfs2(y,x) :
    counts = 1
    deq = list()
    deq.append((y,x))
    icefield[y][x] = 0
    while deq :
        y, x = deq.pop()

        for z in range(4) :
            ny = y + dy[z]
            nx = x + dx[z]

            if 0<= ny < 2**N and 0<= nx < 2**N and icefield[ny][nx] > 0:
                counts += 1
                icefield[ny][nx] = 0
                deq.append((ny,nx))

    if counts == 1 :
        return 0
    return counts

def bfs(ly,lx) :
    check = 0
    for z in range(4) :
        ny = ly + dy[z]
        nx = lx + dx[z]

        if 0<= ny < 2**N and 0<= nx < 2**N :
            if icefield[ny][nx] > 0 :
                check += 1

    if check >= 3 :
        return
    else :
        minus_chk[ly][lx] = 1

def spin(L) :
    if L == 0 :
        return

    for i in range(0,2**N,2**L) : 
        for k in range(0,2**N,2**L) : 
            c = 0 
            for q in range(k, k + 2**L) :
                for t in range(2**L) : 
                    icefield[t+i][q] = temp_icefield[i + 2 **L - c - 1][k+t]
                c += 1


N, Q = map(int,input().split())
icefield = [list(map(int,input().split())) for _ in range(2 ** N)]
counted = list(map(int,input().split()))

num = 0
count = 0

for w in range(Q) :
    minus_chk =[[0 for _ in range(2**N)] for _ in range(2 ** N)]
    temp_icefield = [item[:] for item in icefield]

    spin(counted[w])

    for y in range(2**N):
        for x in range(2**N) :
            if icefield[y][x] > 0 :
                bfs(y,x)

    for y in range(2**N) :
        for x in range(2**N) :
            if minus_chk[y][x] == 1 and icefield[y][x] > 0 :
                icefield[y][x] -= 1


for item in (icefield) :
    num += sum(item)

for y in range(2**N) :
    for x in range(2**N):
        if icefield[y][x] > 0 :
            temp = bfs2(y,x)
            if count < temp :
                count = temp
            

print(num)
print(count)