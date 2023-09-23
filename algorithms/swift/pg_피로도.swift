import Foundation

// pg_피로도
// 던전을 최대한 많이 공략해야 하는 문제
// 공략 순서를 전부 배열에 담아서 탐색하여 문제를 풀었다
func solution(_ k:Int, _ dungeons:[[Int]]) -> Int {
    var res = 0
    var orders: [[Int]] = []
    var visited = Array(repeating: false, count: dungeons.count)
    
    func dfs(_ order: [Int], _ visited: [Bool]) {
        if order.count == dungeons.count {
            orders.append(order)
            return
        }
        var visited = visited
        for idx in 0..<dungeons.count {
            if visited[idx] { continue }
            visited[idx] = true
            dfs(order + [idx], visited)
            visited[idx] = false
        }
    }
    dfs([], visited)
    
    for order in orders {
        var k = k
        var temp = 0
        for i in order {
            if dungeons[i][0] <= k {
                k -= dungeons[i][1]
                temp += 1
            }
        }
        res = max(res, temp)
    }

    return res
}

print(solution(80, [[80,20],[50,40],[30,10]]))
