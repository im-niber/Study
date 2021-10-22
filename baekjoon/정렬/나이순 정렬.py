n = int(input())

name = dict()

for i in range(n):
  age,names = input().split()

  age = int(age)
  if age not in name :
    name[age] = [names]
  else :
    name[age].append(names)

temp = sorted(name)

for item in temp :
  for i in range(len(name[item])):
    print(item, name[item][i])
