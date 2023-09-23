import collections

def bfs(start, end) :
    deq = collections.deque()
    count = 0

    deq.append(graph[start])
    visited[start] = True

    while deq :
        count += 1
        node = []
        for _ in range(len(deq)) :
            node.append(deq.popleft())

        for idx in range(len(node)):
            for item in node[idx] :
                if item == end :
                    return count

                if visited[item] == False :
                    visited[item] = True
                    deq.append(graph[item])

    return 0
                    

for i in range(1, int(input())+1):
    V, E = map(int,input().split())
    graph = [[] for _ in range(V+1)]
    visited = [False] * (V+1)
    result = 0

    for _ in range(E):
        a, b = map(int,input().split())
        graph[a].append(b)
        graph[b].append(a)
    
    start, end = map(int,input().split())

    result = bfs(start,end)

    print(f"#{i} {result}")