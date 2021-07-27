fruit = ['   apple    ','banana','  melon']
fru = []
for key in fruit :
    p = key
    k = ""
    for i in range(len(p)):
        if p[i] != ' ' :
            k += p[i]
    fru.append(k)
        
data_dict = {key: len(key) for key in fru}

print(data_dict)