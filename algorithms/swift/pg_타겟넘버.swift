import Foundation

// pg_타겟 넘버
// 간단한 dfs 문제 ! 배열의 숫자들을 더하거나 빼서 마지막에 타겟의 값과 같은지 판별하는문제다
// 케이스가 많지 않아서 시간 초과는 나지 않았다
func solution(_ numbers:[Int], _ target:Int) -> Int {
    var res = 0
    
    func dfs(currentValue: Int, idx: Int) {
        if idx == numbers.count  {
            if currentValue == target { res += 1 }
            return
        }

        dfs(currentValue: currentValue + numbers[idx], idx: idx + 1)
        dfs(currentValue: currentValue - numbers[idx], idx: idx + 1)
    }
    dfs(currentValue: -numbers[0], idx: 1)
    dfs(currentValue: numbers[0], idx: 1)
    
    return res
}

print(solution([1, 1, 1, 1, 1], 3))
print(solution([4, 1, 2, 1], 4))
