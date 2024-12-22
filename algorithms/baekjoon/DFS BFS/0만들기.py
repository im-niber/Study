import sys
input = sys.stdin.readline

T = int(input())

cases = [' ', '+', '-']

def solve(nums: list[str], idx: int=1):

    if idx >= len(nums):
        total = -1
        temp = nums[:]
        nums = [item for item in nums if item != ' ']

        l_num = ''
        before_op_idx = -1
        op = ''
        for i in range(0, len(nums)):
            if not nums[i].isdigit():
                if l_num == '':
                    l_num = ''.join(nums[before_op_idx+1:i])
                    before_op_idx = i
                else:
                    if op == '+':
                        l_num = int(l_num) + int(''.join(nums[before_op_idx+1:i]))
                    elif op == '-':
                        l_num = int(l_num) - int(''.join(nums[before_op_idx+1:i]))
                    before_op_idx = i

                op = nums[i]
        
        if op == '+':
            total = int(l_num) + int(''.join(nums[before_op_idx+1:]))
        elif op == '-':
            total = int(l_num) - int(''.join(nums[before_op_idx+1:]))

        if total == 0:
            print(''.join(temp))

        return

    for oper in cases:
        nums[idx] = oper
        solve(nums, idx+2)
        nums[idx] = 'x'

for _ in range(0, T):
    N = int(input())

    nums = [str(i) for i in range(1, N + 1)]
    for i in range(1, N*2-1, 2):
        nums.insert(i, 'x')
    solve(nums)
    print()