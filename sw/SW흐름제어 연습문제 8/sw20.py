result = list()

for i in range(200,301):
    p = str(i)

    if int(p[0]) % 2 == 0 and int(p[1]) %2 == 0 and int(p[2]) %2 == 0:
        result.append(p)
        
result2 = ','.join(result)
print(result2)
        
        
        
       