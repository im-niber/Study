#세 수의 합 
#배열을 입력 받아 합으로 0을 만들 수 있는 3개의 엘리먼트를 출력


#브루트 포스 풀이 시간복잡도: O(n^3) 
def threeSum(nums : list) -> list:
  results = []
  nums.sort()

  for i in range(len(nums)-2) :
    if i>0 and nums[i] == nums[i-1] :   # 중복된 값 처리.
      continue
    for j in range(i+1,len(nums)-1) :
      if j > i+1 and nums[j] == nums[j-1]:
        continue
      for k in range(j+1, len(nums)):
        if k > j+1 and nums[k] == nums[k-1] :
          continue
        if nums[i] + nums[j] + nums[k] == 0 :
          results.append([nums[i],nums[j],nums[k]])

  return results

print(threeSum([-1,0,1,2,-1,-4]))

#투 포인터로 합 계산
#시간 복잡도 O(n^2)
def threeSum_two(nums: list) -> list :
  results = []
  nums.sort()

  for i in range(len(nums)-2):
    if i > 0 and nums[i] == nums[i-1]:
      continue
    left = i+1
    right = len(nums)-1

    while left < right :
      sum = nums[i] + nums[left] + nums[right]

      if sum < 0 :
        left += 1
        continue
      
      elif sum > 0 :
        right -=1
        continue

      else:
        results.append([nums[i],nums[left],nums[right]])

        while left < right and nums[left] == nums[left+1] : #중복 체크 후 skip 처리를 해줌.
          left += 1
        while left < right and nums[right] == nums[right-1] :
          right -= 1

        left +=1
        right -=1
       

  return results

print(threeSum_two([-4,-1,-1,0,1,2]))
