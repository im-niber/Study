# 169_Majority Element (leetcode)
# 과반수를 차지하는(절반을 초과하는) 엘리먼트를 출력하라.

import collections

test_data = [2,2,1,1,1,2,2]

#my solution
visited = dict()
for item in test_data :
  if item not in visited :
    visited[item] = test_data.count(item)
print(max(visited)) # 절반을 초과하면 출력하면 되는데 문제를 잘못읽음..
######################################################################

#책의 풀이
#Brute Force
def majorityElement(nums : list) -> int :
  for num in nums:
    if nums.count(num) > len(nums) // 2 :
      return num

# DP
def majorityElement(nums : list) -> int :
  counts = collections.defaultdict(int)
  for num in nums :
    if counts[num] == 0 :
      counts[num] = nums.count(num)
    
    if counts[num] > len(nums)//2 :
      return num

#Divide and Conquer
class solution :
  def majorityElement(self,nums : list) -> int :
    if not nums :
      return None
    if len(nums) == 1 :
      return nums[0]

    half = len(nums) // 2
    a = self.majorityElement(nums[:half])
    b = self.majorityElement(nums[half:])

    return[b,a][nums.count(a) > half] # 조건을 만족하면 a를 아니면 b를 리턴

#파이썬 다운 풀이
def majorityElement(nums : list) -> int :
  return sorted(nums)[len(nums)//2]  # 과반수 이상이라면 중간에 값이 있을 것.

f = solution()
print(f.majorityElement(test_data))