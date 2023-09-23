def my_sol():
  n = int(input())

  array = dict()

  for _ in range(n):
    x, y = input().split(' ')
    x = int(x)
    y = int(y)
    if x not in array :
      array[x] = [y]
    else :
      array[x].append(y)

  temp = sorted(array)

  for item in temp :
    for y in sorted(array[item]) :
      print(item, y)

#강의 풀이
def lect_sol() :
  n = int(input())
  array = []

  for _ in range(n) :
    x, y= map(int,input().split(' '))
    array.append((x,y))

  array = sorted(array)

  for i in array :
    print(i[0], i[1])


my_sol()
lect_sol()