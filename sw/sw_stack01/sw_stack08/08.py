def value_check(node,visited) : # 한 정점에 연결된 정점이 많은 경우 조건을 판별해서 다음 정점을 return해줌
    if node == 0 :
        return 0
    else :
        for j in range(0, len(node)):
            if visited[node[j]] == False :
                return node[j]
        return 0


for i in range(1,int(input()) + 1):
    result = True
    node_list = dict()
    chk_list = list()
    data = list(map(int,input().split()))

    visited = {i : 0 for i in range(1,data[0]+1)} #정점 수 만큼 방문체크를 위한 딕셔너리 생성. 방문 안했다면 0 했으면 1

    for k in range(data[1]):                      # 딕셔너리에 정점 간선 정보를 넣음 처음에 int로 받다가 이미 존재하면 list로 넣으려고 하였으나
        node = list(map(int,input().split()))     # 연결된 정점이 3개 이상이면 딕셔너리 밸류 값이 2차원 배열이 되어 계속 런타임 에러가 발생
        if node[0] in node_list :                 # 겨우 찾아서 처음부터 list 형태로 value를 주었다.
            #temp_list.append(node_list[node[0]])
            #temp_list.append(node[1])
            node_list[node[0]].extend([node[1]]) #= temp_list
            continue
            
        node_list[node[0]] = [node[1]]

    for t in range(1,data[0]+1) :       # 정점의 모든 정보가 있는지 체크해서 없다면 다음 정점과의 연결이 없으므로 0을 넣어줌.
        if t not in node_list.keys() :
            node_list[t] = 0
    
    check_node = list(map(int,input().split()))

    chk_list.append(check_node[0])    # 시작 정점을 먼저 넣어주었다.
    visited[check_node[0]] = 1

    while check_node[0] not in chk_list or check_node[1] not in chk_list : #chk_list에 시작 정점과 끝 정점이 있다면 경로가 있다는 의미로 조건을 줌.
        value = value_check(node_list[chk_list[-1]], visited)         # value_check 함수를 사용하고 인자로는 마지막에 들어온 정점 값을 주었다 [-1]

        if value == 0 and len(chk_list) != 0 :    #시작 정점까지 pop 해버리면 경로가 없다는 의미로 break 해줌
            check = chk_list.pop()
            if check == check_node[0] :
                result = False
                break
            continue

        chk_list.append(value)
        visited[value] = 1

        
    print("#%d %d" %(i, result))
        

    
