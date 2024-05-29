import Foundation

// boj_14722 우유 도시
// DP의 냄새가 났지만 그냥 한 번 완탐으로 풀어보려다가 시초나고
// DP로 풀이시도하였다.

func baek() {
    let N = Int(readLine()!)!
    var milk: [[Int]] = []

    for _ in 0..<N {
        let input = readLine()!.split(separator: " ").compactMap { Int($0) }
        milk.append(input)
    }
    
    let dy = [0, 1]
    let dx = [1, 0]
    
    var dp = Array(repeating:Array(repeating:Array(repeating:0,count:3),count:N),count:N)
    
    for i in 0..<N {
        for j in 0..<N {
            
            if milk[i][j] == 0 {
                dp[i][j][0] = max(dp[i][j][0],1)
            }
            
            for k in 0..<2 {
                let (ny, nx) = (i+dy[k], j+dx[k])
                if nx >= N || ny >= N { continue }
                for l in 0..<3 {
                    let n = milk[ny][nx]
                    
                    if dp[i][j][l] != 0 && (l >= 2 ? 0 : l+1) == n {
                        dp[ny][nx][n] = max(dp[ny][nx][n], dp[i][j][l]+1)
                    }
                    else {
                        dp[ny][nx][l] = max(dp[ny][nx][l], dp[i][j][l])
                    }
                }
            }
        }
    }
    
    
    print(dp[N - 1][N - 1].max()!)
}

baek()
