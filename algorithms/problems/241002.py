# 1. 제일 작은 수 제거하기
def solution(arr):
    if len(arr) == 1:
        return -1
    arr.remove(min(arr))
    return arr

# 2. 문자열 내림차 순 배치하기
def solution(s):
    return ''.join(sorted(s, reverse=True))