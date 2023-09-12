import Foundation

// pg_삼각달팽이
// 조금 애먹었던 문제, 규칙이 있는지 찾아보다가 포기하고
// 문제대로 구현을 진행함
// 먼저 down 함수를 반복하고 종료되면 right를, 종료되면 up을 하는 식으로 계속 돌렸다
// 시초는 안나서 다행,,
func solution(_ n:Int) -> [Int] {
    let maxValue = (n * (n + 1)) / 2
    var idx: [Int] = [-1, 1]
        
    var result: [Int] = Array(repeating: 0, count: maxValue + 1)
    result[0] = 1
    result[1] = 1
    
    for i in 2..<n + 1 {
        for _ in 0..<i {
            idx.append(i)
        }
    }
    
    var nextIdx = 1
    func down(_ next: Int) -> Bool {
        if next + idx[next] < maxValue && result[next + idx[next]] == 0 {
            result[next + idx[next]] += result[next] + 1
            nextIdx += idx[next]
            return true
        }
        return false
    }
    
    func right(_ next: Int) -> Bool {
        if next + 1 <= maxValue && result[next + 1] == 0 {
            result[next + 1] += result[next] + 1
            nextIdx += 1
            return true
        }
        return false
    }
    
    func up(_ next: Int) -> Bool {
        if next - idx[next] >= 0 && result[next - idx[next]] == 0 {
            result[next - idx[next]] += result[next] + 1
            nextIdx = next - idx[next]
            return true
        }
        return false
    }
        
    while(result.contains(0)) {
        while(down(nextIdx)) { continue }
        while(right(nextIdx)) { continue }
        while(up(nextIdx)) { continue }
    }
    result.removeFirst()
    return result
}

print(solution(1))
print(solution(4))
print(solution(5))
print(solution(6))

