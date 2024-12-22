from collections import deque

MAX_RANGE = 200001

def solution(c, b):
    cnt = 0
    val = 0
    
    if c == b:
        return 0
    
    queue = deque()
    queue.append(b)

    checked = [{} for _ in range(0, MAX_RANGE)]

    while c <= MAX_RANGE and queue:
        val += 1
        cnt += 1
        c += val

        for _ in range(len(queue)):
            now = queue.popleft()
            print(c, now)
            if now + 1 == c:
                return cnt

            elif now+1 < MAX_RANGE and cnt not in checked[now+1]:
                checked[now+1][cnt] = True
                queue.append(now+1)
            
            if now - 1 == c:
                return cnt

            elif 0 < now-1 < MAX_RANGE and cnt not in checked[now-1]:
                checked[now-1][cnt] = True
                queue.append(now-1)

            if now * 2 == c:
                return cnt

            elif now*2 < MAX_RANGE and cnt not in checked[now*2]:
                checked[now*2][cnt] = True
                queue.append(now*2)

            if cnt in checked[c]:
                return cnt

    return -1

c = int(input())
b = int(input())

print(solution(c, b))