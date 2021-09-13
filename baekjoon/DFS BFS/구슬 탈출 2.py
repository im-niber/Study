#boj_13460 구슬 탈출 2
from collections import deque

dy = [0,0,-1,1]
dx = [-1,1,0,0]

def check(ry,rx,by,bx) :
  if board[ry][rx] == 'O' and board[by][bx] == 'O' :
    return False
  elif board[ry][rx] == 'O' :
    return True

  return False
  
def move(y,x,i) :
  ny = y + dy[i]
  nx = x + dx[i]

  if i < 2 :
    for k in range(M-1) :
      if 0 < nx < M :
        if board[ny][nx] == '.' or board[ny][nx] == 'B' :
          nx += dx[i]
        elif board[ny][nx] == 'O' :
          return ny,nx
        else :
          nx -= dx[i]
          return ny,nx
    
  else :
    for k in range(N-1) :
      if 0 < ny < N :
        if board[ny][nx] == '.' or board[ny][nx] == 'B' :
          ny += dy[i]
        elif board[ny][nx] == 'O' :
          return ny,nx
        else :
          ny -= dy[i]
          return ny,nx

  return y,x

def bfs(red_y,red_x,blue_y,blue_x):
  global count
  t = 0
  deq_red = deque()
  deq_blue = deque()
  deq_red.append((red_y,red_x))
  deq_blue.append((blue_y,blue_x))

  while count != 11 :
    count += 1
    ry,rx = deq_red.popleft()
    by,bx = deq_blue.popleft()

    if ry == by :
      if rx < bx :
        nby, nbx = move(by,bx,1)
        nry, nrx = move(ry,rx,1)
        if check(nry,nrx,nby,nbx) :
          return count
        if nbx == nrx :
          nrx -= dx[1]
        deq_blue.append((nby,nbx))
        deq_red.append((nry,nrx))
        t = 1
      elif rx > bx :
        nby, nbx = move(by,bx,0)
        nry, nrx = move(ry,rx,0)
        if check(nry,nrx,nby,nbx) :
          return count
        if nbx == nrx :
          nrx -= dx[0]
        deq_blue.append((nby,nbx))
        deq_red.append((nry,nrx))
        t = 0
    if rx == bx :
      if ry > by :
        nby, nbx = move(by,bx,2)
        nry, nrx = move(ry,rx,2)
        if check(nry,nrx,nby,nbx) :
          return count
        if nby == nry :
          nry -= dx[2]
        deq_blue.append((nby,nbx))
        deq_red.append((nry,nrx))
        t = 2
      elif ry < by :
        nby, nbx = move(by,bx,3)
        nry, nrx = move(ry,rx,3)
        if check(nry,nrx,nby,nbx) :
          return count
        if nby == nry :
          nry -= dx[3]
        deq_blue.append((nby,nbx))
        deq_red.append((nry,nrx))
        t = 3

    else :
      for i in range(4) :
        if i == t :
          continue
        chk = 1
        n_ry = ry + dy[i]
        n_rx = rx + dx[i]

        n_by = by + dy[i]
        n_bx = bx + dx[i]

        if i < 2 :
          for k in range(M-1) :
            if 0 < n_rx < M :
              if board[n_ry][n_rx] == '.' :
                n_rx += dx[i]
              elif board[n_ry][n_rx] == 'O' :
                chk = 2
                break
              if board[n_ry][n_rx] == '#' :
                n_rx -= dx[i]
                break 

          for k in range(M-1) :
            if 0 < n_bx < M :
              if n_bx == n_rx :
                n_bx -= dx[i]
                break
              if board[n_by][n_bx] == '.' or board[n_by][n_bx] == 'R':
                n_bx += dx[i]
              elif board[n_by][n_bx] == 'O' :
                chk = 0
                break
              if board[n_by][n_bx] == '#':
                n_bx -= dx[i]
                break

          if chk == 1 :
            deq_red.append((n_ry,n_rx))
            deq_blue.append((n_by,n_bx))
          
          if chk == 2 :
            return count

        else :
          for k in range(N-1) :
            if 0 < n_ry < N :
              if board[n_ry][n_rx] == '.' :
                n_ry += dy[i]
              elif board[n_ry][n_rx] == 'O' :
                chk = 2
                break
              if board[n_ry][n_rx] == '#' :
                n_ry -= dy[i]
                break

          for k in range(N-1) :
            if 0 < n_by < N :
              if n_by == n_ry :
                n_by -= dy[i]
                break
              if board[n_by][n_bx] == '.' or board[n_by][n_bx] == 'R' :
                n_by += dy[i]
              elif board[n_by][n_bx] == 'O' :
                chk = 0
                break
              if board[n_by][n_bx] == '#':
                n_by -= dy[i]
                break

          if chk == 1 :
            deq_red.append((n_ry,n_rx))
            deq_blue.append((n_by,n_bx))

          if chk == 2 :
            return count
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

bfs(red_y,red_x,blue_y,blue_x)

if count <= 10 :
  print(count)
else :
  print(-1)