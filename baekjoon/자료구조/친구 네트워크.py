#친구 네트워크
#union-find

def find(x) :
  if x == parent[x] :
    return x
  else :
    p = find(parent[x])
    parent[x] = p
    return parent[x]

def union(x,y) :
  x = find(x)
  y = find(y)

  if x != y :
    parent[y] = x
    number[x] += number[y]


n = int(input())

for i in range(n) :
  parent = dict()
  number = dict()

  p = int(input())

  for t in range(p) :
    char, char2 = input().split(' ')

    if char not in parent :
      parent[char] = char
      number[char] = 1
    if char2 not in parent :
      parent[char2] = char2
      number[char2] = 1

    union(char,char2)

    print(number[find(char)])
  