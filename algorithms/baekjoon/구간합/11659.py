import sys
input = sys.stdin.readline

N, M = map(int, input().split())

arr = list(map(int, input().split()))
temp_arr = [0]
before_value = 0

for i in range(N):
    before_value += arr[i]
    temp_arr.append(before_value)
    

for _ in range(M):
    start, end = map(int, input().split())
    print(temp_arr[end] - temp_arr[start - 1])
