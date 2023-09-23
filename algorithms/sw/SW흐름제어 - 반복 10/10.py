p =input()

list = [str(i) for i in range(0,10)]
list2 = [0 for i in range(0,10)]

#p.split()

for i in range(0, len(p)):
    for k in range(0, 10):
        if p[i] == list[k] :
            list2[k] += 1
            

for i in range(0,10):

    if i == 9 :
        print(list[i])
    else :
        print(list[i], end =' ')
        
for i in range(0,10): 
    if i == 9 :
        print(list2[i])
    else :
        print(list2[i], end =' ')
