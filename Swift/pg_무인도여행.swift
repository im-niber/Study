import Foundation

// pg_무인도여행
// BFS를 사용하는 문제, 전형적인 BFS 문제인둣하다 ~
func solution(_ maps:[String]) -> [Int] {
    let maps = maps.map { $0.map { $0 } }
    var visited = Array(repeating: Array(repeating: false, count: maps[0].count), count: maps.count)
    var answer: [Int] = []
    var weight: Int = 0
    
    var queue: [(Int, Int)] = []
    
    let dx = [0, 1, 0, -1]
    let dy = [1, 0, -1, 0]
    
    for i in 0..<maps.count {
        for k in 0..<maps[0].count {
            if visited[i][k] || maps[i][k] == "X" { continue }
            queue.append((i,k))
            visited[i][k] = true
            while(!queue.isEmpty) {
                var point = queue.removeFirst()
                weight += Int(String(maps[point.0][point.1]))!
                
                for i in 0..<4 {
                    let ny = point.0 + dy[i], nx = point.1 + dx[i]
                    if (0 <= nx && nx < maps[0].count && 0 <= ny && ny < maps.count) && maps[ny][nx] != "X" && !visited[ny][nx] {
                        queue.append((ny,nx))
                        visited[ny][nx] = true
                    }
                }
            }
            answer.append(weight)
            weight = 0
        }
    }
    
    return answer.isEmpty ? [-1] : answer.sorted()
}
