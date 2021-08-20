#순열
def my_permutations(list, r, target) :

    #탈출조건
    if len(target) == r :
        print(target)
        return

    for i in range(len(list)):
        if visited[i] == False :
            visited[i] = True
            my_permutations(list, r, target + [list[i]])
            visited[i] = False

#조합
def my_combination(list, k, r, target) :
    print(k)

    if len(target) == r:
        print(target)
        return

    if k >= len(list) :
        return
    
    #k = 3 일 시 리턴 -> k = 2일때 print 후 밑 k=2 인 상태로 2 번 함수 실행
    #temp = 0,1,2 r == 2이므로 마지막 항 혼자서는 print 못함 if문에 걸리지가 않음.
    #따라서 return 후 k = 1일 때 target 은 [] 인 상태를 받은 1번함수가 끝났으므로 print 후 2번함수를 시작
    #k=1 인 2번함수 실행하면 target = [1] 이 들어간후 k = 2 실행하여 target은 [1] 을 받아있는 상태
    #따라서 1,2 를 받고 r == 2 에 걸리므로 출력 후 리턴 , 하면 1일때 종료 후 k = 0 일때 2번함 수 시작.
    # target == [0] 을 받고 시작. k = 1, target = [0] 으로 1번 시작 k = 2인 상태로 2번함수로 가므로
    # target = [0,2] 가 되어 if문 받아서 출력,리턴 후 k = 1 인상태로 2번함수 시작. [0,1]받고 리턴.
    # k = 0 일때 모든 함수 실행이 되었으므로 함수 종료.


    my_combination(list, k + 1, r, target) # 1번 함수
    print("hi", k)

    my_combination(list, k + 1, r, target + [list[k]]) # 2번 함수

    
temp_list = [0,1,2]
visited=[False for _ in range(len(temp_list))]

#my_permutations(temp_list, 3, [])
my_combination(temp_list, 0, 2, [])