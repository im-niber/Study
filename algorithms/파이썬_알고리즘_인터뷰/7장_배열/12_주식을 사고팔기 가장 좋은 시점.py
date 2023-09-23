#12_주식을 사고팔기 가장 좋은 시점

# 나의 풀이
def output(nums : list) -> int :
    min = float('inf')
    for i in range(0, len(nums)): 
        for k in range(i+1, len(nums)):
            if min > nums[i] - nums[k] :
                min = nums[i] - nums[k]

    return -min

print(output([7,1,5,3,6,4]))

#브루트 포스 풀이
def output2(nums : list) -> int :
    max_price = 0

    for i, price in enumerate(nums):
        for j in range(i, len(nums)):
            max_price = max(nums[j] - price , max_price)

    return max_price

print(output2([7,1,5,3,6,4]))

#저점과 현재 값과의 차이 계산
def output3(nums: list) -> int :
    profit = 0
    min_price = float('inf')

    #저점에서 현재값을 계산하여 큰 값을 찾는 문제이므로
    #저점을 꾸준히 갱신하고, 그 저점을 토대로 현재값과의 차이를 계산해 나감.
    for item in nums :
        min_price = min(min_price, item)
        profit = max(profit, item - min_price)

    return profit

print(output3([7,1,5,3,6,4]))