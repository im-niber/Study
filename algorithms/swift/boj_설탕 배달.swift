// BOJ_설탕배달
// 그리디문제! dp로 풀었씀
func baekjoon() -> Int {
    let N = Int(readLine()!)!
    var dp: [Int : Int] = [:]
    dp[3] = 1; dp[4] = -1; dp[5] = 1
    
    if N < 6 { return dp[N]! }
    
    for i in 6...N {
        var lhs = Int.max
        var rhs = Int.max
        
        if dp[i - 3] != nil && dp[i - 3] != -1 {
            lhs = dp[i - 3]! + dp[3]!
        }
        
        if dp[i - 5] != nil && dp[i - 5] != -1 {
            rhs = dp[i - 5]! + dp[5]!
        }
        
        dp[i] = min(lhs, rhs)
        if dp[i] == Int.max { dp[i] = -1 }
    }
    
    return dp[N]!
}
