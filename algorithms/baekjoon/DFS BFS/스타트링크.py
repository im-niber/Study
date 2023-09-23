from collections import deque

def bfs(cur,idx) :
    visited[cur] = 1
    deq = deque()
    deq.append((cur,idx))
    while deq :
        current,idx = deq.popleft()
        
        if current == G :
            return idx

        for item in [current+U, current-D] :
            if 1 <= item <= F and item not in visited:
                visited[item] = 1
                deq.append((item,idx+1))

    return "use the stairs"


F,S,G,U,D = map(int,input().split())

visited = dict()

if S > G and D == 0 :
    print("use the stairs")

elif S < G and U == 0 :
    print("use the stairs")

else :
    print(bfs(S,0))
