count = 1
chk_count = 0
N, M = map(int,input().split())
r, c, d = map(int,input().split())

area = [list(map(int,input().split())) for _ in range(N)]
visited = [[0 for _ in range(M)] for _ in range(N)]
visited[r][c] = 1

while True :
  if chk_count == 4 :
    if d == 0 and area[r+1][c] != 1:
      r += 1
      chk_count = 0
      continue
    elif d == 1 and area[r][c-1] != 1 :
      c -= 1
      chk_count = 0
      continue
    elif d == 2 and area[r-1][c] != 1:
      r -=1
      chk_count = 0
      continue
    elif d == 3 and area[r][c+1] != 1:
      c += 1
      chk_count = 0
      continue
    else :
      break

  if d == 0 and area[r][c-1] == 0 and visited[r][c-1] == 0:
    d = 3
    c -= 1 
    visited[r][c] = 1
    count += 1
    chk_count = 0
    continue

  elif d == 0 and (visited[r][c-1] == 1 or area[r][c-1] == 1):
    chk_count += 1
    d = 3
    continue

  elif d == 1 and area[r-1][c] == 0 and visited[r-1][c] == 0:
    d = 0
    r -= 1 
    visited[r][c] = 1
    count += 1
    chk_count = 0
    continue

  elif d == 1 and (visited[r-1][c] == 1 or area[r-1][c] == 1) :
    chk_count += 1
    d = 0
    continue

  elif d == 2 and area[r][c+1] == 0 and visited[r][c+1] == 0:
    d = 1
    c += 1 
    count += 1
    visited[r][c] = 1
    chk_count = 0
    continue
  elif d == 2 and (visited[r][c+1] == 1 or area[r][c+1] == 1):
    chk_count += 1
    d = 1
    continue

  elif d == 3 and area[r+1][c] == 0 and visited[r+1][c] == 0:
    d = 2
    r += 1 
    count += 1
    visited[r][c] = 1
    chk_count = 0
    continue

  elif d == 3 and (visited[r+1][c] == 1 or area[r+1][c] == 1):
    chk_count+=1
    d = 2
    continue

print(count)