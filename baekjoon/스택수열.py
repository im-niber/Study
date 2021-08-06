a=int(input())

stack=[]
result = []
c = 1

for i in range(1,a+1):
    data = int(input())
    while c <= data:
        stack.append(c)
        c +=1
        result.append('+')
    if stack[-1] == data:
        stack.pop()
        result.append('-')
    else :
        print('NO')
        exit(0)
        
print('\n'.join(result)) 
