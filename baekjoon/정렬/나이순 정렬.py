def my_sol():
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

#강의 풀이
def lect_sol():
  n = int(input())
  array = []

  for _ in range(n):
    input_data =input().split(' ')
    array.append((int(input_data[0]),input_data[1]))

  array = sorted(array, key = lambda x: x[0]) # key 속성으로 정렬해줌.

  for i in array :
    print(i[0], i[1])

my_sol()
lect_sol()
