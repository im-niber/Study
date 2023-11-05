import Foundation

// pg_미로탈출
// 탐색문제, BFS 사용하였고 문제 조건에 맞게
// 몇 부분만 수정해서 구현을 진행하였다
// Start -> Lever, Lever -> End
// 두 번 돌리면 되는 간단한문제였으
func solution(_ maps:[String]) -> Int {
    var ans = -1
    
    let maps = maps.map { Array($0) }
    
    let dx = [0, 0, 1, -1]
    let dy = [1, -1, 0, 0]
    
    var start = (0, 0)
    var lever = (0, 0)
    var end = (0, 0)
    
    var isLeverOn = false
    
    for i in 0..<maps.count {
        for k in 0..<maps[i].count {
            if maps[i][k] == "S" { start = (i, k) }
            if maps[i][k] == "L" { lever = (i, k) }
            if maps[i][k] == "E" { end = (i, k) }
        }
    }
    
    func bfs(_ start: (Int, Int), _ goal: (Int, Int)) {
        var queue = [(start, 0)]
        var visited = Array(repeating: Array(repeating: false, count: maps.first!.count), count: maps.count)
        
        while(!queue.isEmpty) {
            let ((y, x), val) = queue.removeFirst()
            visited[y][x] = true
            
            for i in 0..<4 {
                let (ny, nx) = (y + dy[i], x + dx[i])
                if 0 <= ny && ny < maps.count && 0 <= nx && nx < maps[0].count && !visited[ny][nx] {
                    if maps[ny][nx] != "X" {
                        queue.append(((ny, nx), val + 1))
                        visited[ny][nx] = true
                    }
                    
                    if (ny, nx) == goal && goal == lever {
                        isLeverOn = true
                        ans = val + 1
                        return
                    }
                    
                    else if (ny, nx) == goal && isLeverOn {
                        ans += val + 1
                        return
                    }
                }
            }
        }
        ans = -1
    }
    
    bfs(start, lever)
    if !isLeverOn { return -1 }
    bfs(lever, end)
    
    return ans
}
