import Foundation

// pg_네트워크
// AI추천문제,, 또 dfs bfs 문제 추천해줘씀;
// 이번에는 간단한 DFS 문제였다. 왜 레벨 3인지 모르겠으,,
// 방문처리 해주믄 간단하게 풀린다.. 또 lv3인거 보고 뭔가 더 많은게
// 있나보다하고 생각을 좀 더 해봤지만 없었으..
func solution(_ n:Int, _ computers:[[Int]]) -> Int {
    var dict: [Int: [Int]] = [:]
    var visited: [Bool] = Array(repeating: false, count: n + 1)
    var cnt = 0
    
    for i in 0..<n {
        for k in 0..<n {
            if i != k && computers[i][k] == 1 {
                dict[i + 1, default: []].append(k + 1)
            }
        }
    }
    
    for i in 1...n where visited[i] != true {
        cnt += 1
        visited[i] = true
        var items = dict[i] ?? []
        while !items.isEmpty {
            let item = items.removeLast()
            visited[item] = true
            
            for next in dict[item] ?? [] {
                if !visited[next] { items.append(next) }
            }
        }
    }
    
    return cnt
}
