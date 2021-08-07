for i in range(1, int(input())+1):
    N, M = map(int,input().split())
    text = list(map(int,input().split()))

    for _ in range(M-1) :
        idx = -1
        text2 = list(map(int,input().split()))

        for k in range(0, len(text)) :
            if text2[0] < text[k] :
                idx = k
                break

        if idx != -1 :
            text[idx:idx] = text2           # 슬라이싱으로 풀었는데 주석된 부분으로 하면 시간초과 때문에 오답이다.
            # temp_text = text[:k]            다른 사람 풀이를 참고하여서 text[idx:idx] 식으로도 사용을 하는걸 보고 해결하였다.
            # temp_text.extend(text2)
            # temp_text.extend(text[k:])
            # text = temp_text
        else :
            text.extend(text2)


    print(f"#{i}",end= ' ')
    for t in text[:-11:-1]:
        print(f"{t}", end = ' ')
    print()


######################################## 연결리스트 풀이, 목차에 맞게 연결리스트로 풀면 이런식이다.
class Node:
  def __init__(self, d=0, p=None, n=None):
    self.data = d
    self.prev = p
    self.next = n

class LinkedList:
  def __init__(self) :
    self.head = None
    self.tail = None
    self.size = 0

def addList(lst,arr):
  first = last = Node(arr[0])
  for val in arr[1:]:
    new = Node(val,last)
    last.next = new
    last = new

  if lst.head is None:
    lst.head, lst.tail = first, last
  else :
    cur =lst.head
    while cur is not None:
      if cur.data>arr[0]: break
      cur = cur.next

    if cur is None:
      first.prev = lst.tail
      lst.tail.next = first
      lst.tail = last
    elif cur.prev is None :
      last.next = lst.head
      lst.head.prev = last
      lst.head = first
    else :
      prev = cur.prev
      first.prev = prev
      last.next = cur
      prev.next = first
      cur.prev = last
  lst.size += len(arr)

def printList(lst) :
  if lst.head is None:
    return
  cur = lst.tail
  cnt = 10
  while cnt :
    print(cur.data,end=' ')
    cur = cur.prev
    cnt -=1
  print()

for tc in range(1, int(input())+1):
  n, m = map(int,input().split())
  arr = list(list(map(int,input().split())) for _ in range(m))
  mylist = LinkedList()
  for i in range(m):
    addList(mylist,arr[i])
  print(f"#{tc}",end =' ')
  printList(mylist)
