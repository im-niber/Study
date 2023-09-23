def distance(y,x,ry,rx) :
    return abs(x-rx) + abs(y-ry)

def bfs(x,y,z,d):
    c = 1
    nx = M
    chekk = 0
    d_count = 0
    global count
    while True :
        if d_count == count :
            return enemy.append(count)
        
        elif d_count + chekk == count :
            return enemy.append(d_count)

        for ry,rx in (x,y,z) :
            mins = 100000
            for k in range(c,N+1):
                if 1 in area[N-k] or 3 in area[N-k] :
                    for i in range(M) :
                        if area[N-k][i] != 0:
                            temp = distance(N-k,i,ry,rx)
                            if (mins > temp and d >= temp) or (mins == temp and i < nx) :
                                mins = temp
                                nx = i
                                ny = N - k

            if mins != 100000 and area[ny][nx] == 1:
                area[ny][nx] = 3 
                d_count += 1
            if mins != 100000 and area[ny][nx] == 3:
                continue

        chekk += area[N-c].count(1)
        area[N-c] = [0 for _ in range(M)]

        for item in area :
            if 3 in item :
                for i in range(M) :
                    if item[i] == 3 :
                        item[i] = 0
        d += 1
        c += 1


N, M, D = map(int,input().split())
area = [list(map(int,input().split())) for _ in range(N)]
area.append([0 for _ in range(M)])

count = 0
for item in area :
    count += item.count(1)

enemy = []
temp_area = [item[:] for item in area]

for a in range(M-2) :
    for b in range(a+1,M-1) :
        for c in range(b+1, M) :
            area[N][a],area[N][b],area[N][c] = 2,2,2
            bfs((N,a),(N,b),(N,c),D)
            area = [item[:] for item in temp_area]
    
print(max(enemy))