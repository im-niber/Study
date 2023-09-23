import collections

def dfs(n) :
    stack = []
    stack.append((n,'RED'))
    visited[n] = [True,'RED']

    while stack :
        node, color = stack.pop()
        for next_node in graph[node]:
            if visited[next_node][0] == False :
                if color == 'RED' :
                    visited[next_node] = [True,'BLACK']
                    stack.append((next_node,'BLACK'))
                elif color == 'BLACK' :
                    visited[next_node] = [True,'RED']
                    stack.append((next_node,'RED'))
            else :
                if color == visited[next_node][1] :
                    return 'NO'
    return 'YES'
            


def bfs(n) :
    deq = collections.deque()
    deq.append((n,'RED'))
    visited[n] = [True, 'RED']

    while deq :
        node, color = deq.popleft()
        for next_node in graph[node]:
            if visited[next_node][0] == False :
                if color =='RED' :
                    visited[next_node] = [True, 'BLACK']
                    deq.append((next_node,'BLACK'))
                elif color == 'BLACK' :
                    visited[next_node] = [True, 'RED']
                    deq.append((next_node,'RED'))

            else :
                if color == visited[next_node][1]:
                    return 'NO'

    return 'YES'


T = int(input())
for test_case in range(1, T+1) :

    result = "YES"
    V, E = map(int, input().split())
    graph = {i : [] for i in range(1, V+1)}
    visited = [[False, ''] for _ in range(V+1)]

    for _ in range(E) :
        n1, n2 = map(int,input().split())
        graph[n1].append(n2)
        graph[n2].append(n1)

    for n in range(1,V+1):
        if visited[n][0] == False :
            res = dfs(n)
            if res == 'NO' :
                result = 'NO'
                break

    print(result)

    

