# 검색하여 푼 풀이.
# 문자열을 만들고 인덱스를 원래 3*3의 행렬에 맞게 수정해주면서
# 딕셔너리를 큐에 넣으면서 풀어나감. 

from collections import deque

dx = [-1,1,0,0]
dy = [0,0,-1,1]

def bfs() :
    deq = deque()
    deq.append(result)
    dist[result] = 0

    while deq:
        ch = deq.popleft()
        if ch == 123456789 :
            return dist[ch]
        
        st = str(ch)
        k = st.find('9')
        x,y = k//3, k % 3 # 행렬의 인덱스에 맞게 바꿔줌.

        for i in range(4) :
            nx = x + dx[i]
            ny = y + dy[i]

            if 0<= nx < 3 and 0 <= ny < 3 :
                nk = nx*3 + ny # 다시 문자열의 인덱스로 바꿔줌.
                ns = list(st)
                ns[k],ns[nk] = ns[nk],ns[k]
                nd = int("".join(ns))

                if nd not in dist :
                    dist[nd] = dist[ch] + 1
                    deq.append(nd)

    return -1


dist = dict()
result = ""

for i in range(3) :
    temp = input().replace(' ',"")
    result += temp

result = int(result.replace('0','9'))
count = []
print(bfs())
