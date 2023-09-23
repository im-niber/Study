import Foundation

// pg_햄버거 만들기
// 스택을 활용해서 빵이 들어온 경우에 스택 맨 마지막부터 4개를 비교
// 조건에 맞으면 remove 하고 반복을 다시 진행하면 된다
// 정답 풀이를 보니 아래 코드를 간단히 할 수 있는 방법이 있어서 코드를 추가함
func solution(_ ingredient:[Int]) -> Int {
    var stack: [Int] = []
    var res = 0

    for item in ingredient {
        stack.append(item)

        if item == 1 && stack.count >= 4 {
            var idx = stack.count - 1
            if stack[idx] == 1 && stack[idx - 1] == 3
            && stack[idx - 2] == 2 && stack[idx - 3] == 1 {
                res += 1
                stack.removeLast()
                stack.removeLast()
                stack.removeLast()
                stack.removeLast()
            }
        }
    }

    return res
}

func solution(_ ingredient:[Int]) -> Int {
    var stacks: [Int] = []
    var count: Int = 0
    for ingredient in ingredient {
        stacks.append(ingredient)
        let suffix = stacks.suffix(4)
        if suffix == [1,2,3,1] {
            count += 1
            stacks.removeLast(4)
        }
    }
    return count
}
