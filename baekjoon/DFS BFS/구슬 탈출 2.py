#boj_13460 구슬 탈출 2
from collections import deque

dy = [0,0,-1,1]
dx = [-1,1,0,0]

def move(y,x,i) :
  pass

def bfs(red_y,red_x,blue_y,blue_x,hole_y,hole_x):
  global count
  deq_red = deque()
  deq_blue = deque()
  deq_red.append((red_y,red_x))
  deq_blue.append((blue_y,blue_x))

  while count < 10 :
    count += 1
    ry,rx = deq_red.popleft()
    by,bx = deq_blue.popleft()

    if ry == by :
      if rx < bx :
        move(by,bx,1)
        move(ry,rx,1)
      else :
        move(ry,rx,0)
        move(by,bx,0)
    elif rx == bx :
      if ry > by :
        pass
      else :
        pass


    for i in range(4) :
      nry = ry + dy[i]
      nby = by + dy[i]
      if i < 2:
        for k in range(M-1) :
          pass
      if i >= 2 :
        for k in range(N-1) :
          pass

  return -1

N, M = map(int,input().split())

board = [list(input()) for _ in range(N)]
count = 0

for i in range(1,N) :
  for k in range(1,M) :
    if board[i][k] == 'B' :
      blue_y, blue_x = i,k
      continue
    if board[i][k] == 'R' :
      red_y, red_x = i,k
      continue
    if board[i][k] == 'O' :
      hole_y,hole_x = i,k 
      continue

if bfs(red_y,red_x,blue_y,blue_x,hole_y,hole_x) :
  print(count)
else :
  print(-1)
