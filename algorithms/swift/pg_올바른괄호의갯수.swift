// pg_올바른 괄호의 갯수
// dp 냄새가 나서 시도했는데 점화식이 잘 떠오르지 않아서 질문게시판을 보고 풀었스..
// dp와 dfs 풀이 두 개가 있었고 dp 풀이는 좀 더 생각했으면 감을 좀 잡았을거 같은데
// 어려웠다ㅏㅏㅏㅏㅏㅏ

// dp 풀이는 dp 3, 괄호 3개의 경우
// 2개의 괄호 * 괄호 0개 -> dp2 * dp0
// 1개의 괄호 dp1 * dp1
// 0개의 괄호 dp0 * dp2 ...
// 요런 수를 카탈란수라고 한다네여
func solutiondp(_ n:Int) -> Int {
    var dp = Array(repeating: 0, count: n+1)
    
    dp[0] = 1
    dp[1] = 1
    
    if n < 2 { return dp[n] }
    
    for i in 2...n {
        // dp 2 이면  0 * 1 + 1 * 0
        // dp 3 -> 0 * 2 + 1 * 1 +
        for j in 0..<i {
            dp[i] += dp[j] * dp[i-j-1]
        }
    }
    
    return dp[n]
}

// dfs 풀이
// 2^14는 그렇게 크지 않아서 dfs로 해도 풀렸을듯,, dp에 너무 고집했다ㅏ
func solution(_ n:Int) -> Int {
    func dfs(open : Int, close: Int, n : Int) -> Int {
        if open == n { return 1 }
        else if open - close < 0 { return 0 }
        
        var num = 0
        num += dfs(open: open + 1, close: close, n: n)
        num += dfs(open: open, close: close + 1, n: n)
        
        return num
    }
    
    var ans = 0
    ans = dfs(open: 0, close: 0, n: n)
    return ans
}
