### pypy는 메모리초과 안뜸,, python3는 뜸
import heapq
import sys

input = sys.stdin.readline

K, N = map(int, input().split(' '))
nums = list(map(int, input().split(' ')))
chk_num = set()
nums2 = []

for item in nums:
    heapq.heappush(nums2, item)

count = 0
while count<N:
    r = heapq.heappop(nums2)
    
    if r in chk_num:
        continue

    chk_num.add(r)
    count+=1
    for item in nums:
        if item*r < 2 ** 31:
            heapq.heappush(nums2, item * r)

print(r)

### python3 풀이
import heapq
import sys

input = sys.stdin.readline

K, N = map(int, input().split(' '))
nums = list(map(int, input().split(' ')))
nums2 = []

for item in nums:
    heapq.heappush(nums2, item)

for _ in range(N):
    num = heapq.heappop(nums2)
    for i in range(K):
        temp = num * nums[i]
        heapq.heappush(nums2, temp)

        if num % nums[i] == 0:
            break

print(num)

### 내풀이
# 중복체크를 힙에서 뺀거만하고, 10만번 줄이는 방식을 생각못했다 
# 힙의 특성상 최소 데이터만 계속빼니까 결국은 N번 빼면 그게 정답일건데
# 깨닫지못했으,,

import heapq
import sys

input = sys.stdin.readline

K, N = map(int, input().split(' '))
nums = list(map(int, input().split(' ')))
nums2 = nums[:]
chk_num = set(nums)

heapq.heapify(nums2)

while len(chk_num) <= N * 2:
    r = heapq.heappop(nums2)
    
    for item in nums:
        if item * r not in chk_num:
            heapq.heappush(nums2, item * r)
            chk_num.add(item*r)


answer_list = list(chk_num)
answer_list.sort()