# 1940, 주몽
import sys
input = sys.stdin.readline

N = int(input())
M = int(input())

arr = list(map(int, input().split()))
arr.sort()

l, r = 0, len(arr) - 1
ans = 0

while l < r:
    temp = arr[l] + arr[r]
    if temp == M:
        ans += 1
        l += 1
        r -= 1
    elif temp < M:
        l += 1
    else:
        r -= 1

print(ans)