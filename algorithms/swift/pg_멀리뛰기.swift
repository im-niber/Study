import Foundation

// pg_멀리 뛰기
// 간단한 dp문제여쓰, n까지 갈 수 있는 경우는 n - 1, n - 2 에서 출발
// 하는 경우 밖에 없으므로 n-1, n-2 까지 갈 수 있는 경우를 계속 찾아주면댄다
// 오버플로우가 나지 않게 매번 덧셈에 나머지 연산을 하는게 좋을둣
func solution(_ n:Int) -> Int {
    var dp: [Int] = [0, 1, 2, 3]
    if n < 4 { return dp[n] }
    for i in 4..<n + 1 { dp.append((dp[i - 1] + dp[i - 2]) % 1234567) }
    
    return dp[n]
}

print(solution(6))
print(solution(4))
print(solution(3))
print(solution(2))
