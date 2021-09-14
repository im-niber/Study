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
        if board[ny][nx] == '.' or board[ny][nx] == 'B' or board[ny][nx] == 'R' :
          nx += dx[i]
        elif board[ny][nx] == 'O' :
          return ny,nx
        if board[ny][nx] == '#' :
          nx -= dx[i]
          return ny,nx
    
  else :
    for k in range(N-1) :
      if 0 < ny < N :
        if board[ny][nx] == '.' or board[ny][nx] == 'B' or board[ny][nx] == 'R'  :
          ny += dy[i]
        elif board[ny][nx] == 'O' :
          return ny,nx
        if board[ny][nx] == '#' :
          ny -= dy[i]
          return ny,nx

  return y,x

def bfs(red_y,red_x,blue_y,blue_x):
  checklist = dict()
  global count
  deq = deque()

  deq.append((red_y,red_x,blue_y,blue_x))
  checklist[(red_y,red_x,blue_y,blue_x)] = 1

  while deq:
    temp = []
    count += 1
    if count > 10 :
      return -1
    for i in range(len(deq)) :
      temp.append(deq.popleft())
    
    for ry,rx,by,bx in temp :
      board[ry][rx], board[red_y][red_x] = board[red_y][red_x], board[ry][rx]
      board[by][bx], board[blue_y][blue_x] = board[blue_y][blue_x], board[by][bx]
      chk = 1
      t = -1
      
      if ry == by :
        if rx < bx :
          nby, nbx = move(by,bx,1)
          nry, nrx = move(ry,rx,1)
          
          if nbx == nrx :
            nrx -= dx[1]

          if check(nry,nrx,nby,nbx) :
            return count

          if (nry,nrx,nby,nbx) not in checklist and board[nby][nbx] != 'O':
            deq.append((nry,nrx,nby,nbx))
            checklist[(nry,nrx,nby,nbx)] = 1
          
          t = 1

        elif rx > bx :
          nby, nbx = move(by,bx,0)
          nry, nrx = move(ry,rx,0)
        
          if nbx == nrx :
            nrx -= dx[0]

          if check(nry,nrx,nby,nbx) :
            return count

          if (nry,nrx,nby,nbx) not in checklist and board[nby][nbx] != 'O' :
            deq.append((nry,nrx,nby,nbx))
            checklist[(nry,nrx,nby,nbx)] = 1

          t = 0

      elif rx == bx :
        if ry > by :
          nby, nbx = move(by,bx,2)
          nry, nrx = move(ry,rx,2)

          if nby == nry :
            nry -= dy[2]

          if check(nry,nrx,nby,nbx) :
            return count

          if (nry,nrx,nby,nbx) not in checklist and board[nby][nbx] != 'O' :
            deq.append((nry,nrx,nby,nbx))
            checklist[(nry,nrx,nby,nbx)]= 1
          t = 2
        elif ry < by :
          nby, nbx = move(by,bx,3)
          nry, nrx = move(ry,rx,3)

          if nby == nry :
            nry -= dy[3]

          if check(nry,nrx,nby,nbx) :
            return count

          if (nry,nrx,nby,nbx) not in checklist and board[nby][nbx] != 'O' :
            deq.append((nry,nrx,nby,nbx))
            checklist[(nry,nrx,nby,nbx)] = 1
          t = 3

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
            if 0 < n_rx < M   :
              if board[n_ry][n_rx] == '.' or board[n_ry][n_rx] == 'B' or board[n_ry][n_rx] == 'R' :
                n_rx += dx[i]
              elif board[n_ry][n_rx] == 'O' :
                chk = 2
                break
              if board[n_ry][n_rx] == '#' :
                n_rx -= dx[i]
                break 
            elif 0 == n_rx or M-1 == n_rx :
              n_rx -= dx[i]
              break

          for k in range(M-1) :
            if 0 < n_bx < M -1 :
              if n_bx == n_rx and n_by == n_ry and board[n_by][n_bx] != 'O':
                n_bx -= dx[i]
                break
              if board[n_by][n_bx] == '.' or board[n_by][n_bx] == 'R' or board[n_by][n_bx] == 'B' :
                n_bx += dx[i]
              elif board[n_by][n_bx] == 'O' :
                chk = 0
                break
              elif board[n_by][n_bx] == '#':
                n_bx -= dx[i]
                break
            elif 0 == n_bx or n_bx == M-1 :
              n_bx -= dx[i]
              break

          if chk == 1 and (n_ry,n_rx,n_by,n_bx) not in checklist :
            deq.append((n_ry,n_rx,n_by,n_bx))
            checklist[(n_ry,n_rx,n_by,n_bx)] = 1
          
          if check(n_ry,n_rx,n_by,n_bx) :
            return count

        else :
          for k in range(N-1) :
            if 0 < n_ry < N :
              if board[n_ry][n_rx] == '.' or board[n_ry][n_rx] == 'B' or board[n_ry][n_rx] == 'R' :
                n_ry += dy[i]
              elif board[n_ry][n_rx] == 'O' :
                chk = 2
                break
              if board[n_ry][n_rx] == '#' :
                n_ry -= dy[i]
                break
            elif 0 == n_ry or n_ry == N-1 :
              n_ry -= dy[i]
              break

          for k in range(N-1) :
            if 0 < n_by < N :
              if n_by == n_ry and n_bx == n_rx and board[n_by][n_bx] != 'O' :
                n_by -= dy[i]
                break
              if board[n_by][n_bx] == '.' or board[n_by][n_bx] == 'R' or board[n_by][n_bx] == 'B' :
                n_by += dy[i]
              elif board[n_by][n_bx] == 'O' :
                chk = 0
                break
              elif board[n_by][n_bx] == '#':
                n_by -= dy[i]
                break
            elif 0 == n_by or n_by == N-1 :
              n_by -= dy[i]
              break

          if chk == 1 and (n_ry,n_rx,n_by,n_bx) not in checklist :
            deq.append((n_ry,n_rx,n_by,n_bx))
            checklist[(n_ry,n_rx,n_by,n_bx)] = 1

          if check(n_ry,n_rx,n_by,n_bx) :
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

print(bfs(red_y,red_x,blue_y,blue_x))