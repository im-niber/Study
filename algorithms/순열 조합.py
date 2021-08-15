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
    
    my_combination(list, k + 1, r, target)

    my_combination(list, k + 1, r, target + [list[k]])

    
temp_list = [0,1,2,3,4,5]
visited=[False for _ in range(len(temp_list))]

#my_permutations(temp_list, 3, [])
my_combination(temp_list, 0, 3, [])
