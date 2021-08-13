# 10_배열파티션 I
# n 개의 페어를 이용한 min(a, b)의 합으로 만들 수 있는 가장 큰 수를 출력.
# 입력 : [1,4,3,2] 출력 : 4 

# 오름차순 풀이. 
def arrayPairsum(nums : list) -> int :
  sum = 0
  pair =[]
  nums.sort()

  for n in nums:
    pair.append(n)

    if len(pair) == 2 :   # 두개가 되면 페어가 이루어지고 min을 판단해서 더해줌. 
                                        #오름차순이므로 최대값임.
      sum += min(pair)
      pair = []

  return sum

print(arrayPairsum([1,4,3,2]))


# 짝수 번째 계산.
def arrayPairsum2(nums : list) -> int :
  sum = 0
  nums.sort()

  for i, n in enumerate(nums):
    if i % 2 == 0 :
      sum += n

  return sum


# 파이썬 다운 방식. 두 번째 원소마다 슬라이싱을 하여 더해줌.
def arrayPairsum3(nums : list) -> int :
  return sum(sorted(nums[::2]))
