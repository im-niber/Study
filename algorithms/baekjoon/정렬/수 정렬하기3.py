n = int(input())

array = [0 for _ in range(10001)]

for i in range(n) :
  x = int(input())
  array[x] += 1

for i in range(10001) :
  if array[i] != 0 :
    for k in range(array[i]) :
      print(i)
