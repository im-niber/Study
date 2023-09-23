import copy

data_list = []
data=[]
result=[]

for i in range(2,10):
    for k in range(1,10):
        data_list.append(i*k)
    p = copy.deepcopy(data_list)
    data.append(p)
    del data_list[:]



for item in data:
    for i in range(0,9):
        if item[i] % 3 !=0 and item[i] % 7 !=0:
            data_list.append(item[i])
    p = copy.deepcopy(data_list)
    result.append(p)
    del data_list[:]


#result=[item[i] for item in data for i in range(0,9) if item[i] % 3 !=0 and item[i] % 7 != 0]

print(result)