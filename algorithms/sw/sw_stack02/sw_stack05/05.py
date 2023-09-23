# 문제가 잘 안풀려서 다른사람의 풀이코드를 참고하였습니다
# 정점에서 어느 방향으로 갈지를 정할 때 if문으로 조건을 일일이 적었었는데 거기서 부터 문제 풀이가 힘들었던것 같습니다.
# 밑에 코드처럼 델타를 사용 하였다면 쉽게 풀렸을 듯 합니다

def func(x,y):      
    dx = [1,0,-1,0]
    dy = [0,-1,0,1]
    global result

    if data[y][x] == 3:
        result = 1
        return

    visited.append((x,y))
    for j in range(4):
        nextX = x + dx[j]
        nextY = y + dy[j]

        if (nextX, nextY) not in visited and (0<=nextX<count and 0<=nextY<count) and data[nextY][nextX] != 1 :
            func(nextX,nextY)


for i in range(1,int(input()) + 1):
    result = 0
    count = int(input())
    visited = []
    data = [list(map(int,input())) for _ in range(count)]

    for k in range(count):
        if 2 in data[k] :
            x = data[k].index(2)
            y = k

    func(x,y)
 
    print(f"#{i} {result}")
