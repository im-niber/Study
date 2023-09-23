n = input()
n = list(n)

for i in range(len(n)):
  for k in range(i+1,len(n)) :
    if n[i] < n[k] :
      n[i],n[k] = n[k],n[i]

print(''.join(n))