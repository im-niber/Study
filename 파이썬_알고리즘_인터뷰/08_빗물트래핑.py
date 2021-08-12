#투포인터 이용

def trap(height : list) -> int :
  if not height :
    return 0

  volume = 0
  left, right = 0, len(height) -1
  left_max , right_max = height[left] , height[right]

  while left < right :                    #가운데가 오면 종료.

    left_max = max(left_max, height[left])
    right_max = max(right_max, height[right])

    if left_max <= right_max :            # 큰곳으로 한칸 이동 왼쪽이 큰 경우 right -= 1 
      volume += left_max - height[left]
      left += 1
    else :
      volume += right_max - height[right]
      right -=1

  return volume

print(trap([0,1,0,2,1,0,1,3,2,1,2,1]))

#stack 이용

def trap_stack(height : list) -> int :
  stack = []
  volume = 0

  for i in range(len(height)) :
    while stack and height[i] > height[stack[-1]] : # 스택 top 보다 높은 지점일때 실행.
      top = stack.pop()

      if not len(stack) :   # 존재 안하면 break
        break

      distance = i - stack[-1] - 1            #현재지점과 그 이전 지점의 거리 . (물을 넣을 공간)
      waters = min(height[i],height[stack[-1]]) - height[top] # 최소값으로 받아야 물을 넣을수 있기 때문에 min, 그리고 top에 높이가 있다면 그 부분도 빼준다.

      volume += distance * waters
    
    stack.append(i)
  return volume


print(trap_stack([0,1,0,2,1,0,1,3,2,1,2,1]))

