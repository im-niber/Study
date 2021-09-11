def combinations(array, r):
    for i in range(len(array)):
        if r == 1:
            yield [array[i]]
        else:
            ## array[i+1: ] -> array[i: ] 변경
            for next in combinations(array[i:], r-1):
                yield [array[i]] + next

def permutations_4(array, r):
    for i in range(len(array)):
        if r == 1:
            yield [array[i]]
        else:
            for next in permutations_4(array, r-1):
                yield [array[i]] + next

# yield 란
# return 과 다르게 generator라는 객체를 만들어 주게 됩니다. return은 어떤 객체를 한번에
# 반환하는 역할을 한다면, yield는 generator 라는 객체를 통해 반환해야하는 것이 순차적으로
# 일어난다면, 이를 순차적으로 한번에 처리하는 것이 아니라, 함수를 호출 할 때마다 하나씩
# 전달을 해줌. 즉 반복 횟수 만큼 호출 가능.