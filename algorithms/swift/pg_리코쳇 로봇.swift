import Foundation

// pg_리코쳇 로봇 9/15 다시 풀어 볼 일이 있어서 다시푼 코드
// 기억이 안나서 그런지 이전 풀이랑은 좀 많이 달라진둣
func solution(_ board:[String]) -> Int {
    let board = Array(board.map { Array($0) })
    var res = 1
    var start = (0, 0)
    
    for i in 0..<board.count {
        for k in 0..<board[0].count {
            if board[i][k] == "R" { start = (i, k) }
        }
    }
    func verify(_ position: (Int, Int)) -> Bool {
        (position.0 >= 0 && position.0 < board.count) && (position.1 >= 0 && position.1 < board[0].count)
    }
    
    var queue = [(start, 1)]
    var visited = Array(repeating: Array(repeating: false, count: board[0].count), count: board.count)
    let dx = [-1, 1, 0, 0]
    let dy = [0, 0, 1, -1]
    
    while(!queue.isEmpty) {
        let (temp, count) = queue.removeFirst()
        
        var (row, col) = temp
        visited[row][col] = true
        
        for i in 0..<4 {
            while(verify((row + dy[i], col + dx[i])) && board[row + dy[i]][col + dx[i]] != "D") {
                row += dy[i]; col += dx[i]
            }
        
            if board[row][col] == "G" { return count }
            else if board[row][col] == "." && !visited[row][col] { queue.append(((row, col), count + 1)) }
            (row, col) = temp
        }
    }

    return -1
}

// 프로그래머스 - 리코쳇 로봇
// 되게 오랜만에 다시 코테 문제 풀어봤는데 겨우겨우 풀었지만 효율이 썩 좋지는 않은듯하다...
// 다시 열씨미 해야겠그만
// 그리고 큐를 사용하는 코드 보면서 하나 배운게
// front라는 프로퍼티를 두어서 removeFirst 대신 얘를 사용해서 하는 코드가 있는데 좋아보였다.
extension String {
    subscript(idx: Int) -> String {
        guard (0..<count).contains(idx) else { return "" }
        let target = index(startIndex, offsetBy: idx)
        return String(self[target])
    }
}

let board: [String] = [".D.R", "....", ".G..", "...D"]

var start: (Int, Int) = (-1, -1)
var destination: (Int, Int) = (-1, -1)
var visited: [[Int]] = Array(repeating: Array(repeating: 0, count: board[0].count), count: board.count)

var answer = -1

for i in 0..<board.count {
    for k in 0..<board[0].count {
        if board[i][k] == "R" {
            start = (i, k)
        }
        else if board[i][k] == "G" {
            destination = (i, k)
        }
    }
}

func bfs() {
    let dx = [0, 1, 0, -1]
    let dy = [-1, 0, 1, 0]
    
    var count = 0
    var queue: [(Int, Int)] = [start]
    
    while(!queue.isEmpty) {
        count += 1
        
        for _ in 0..<queue.count {
            var position = queue.removeFirst()
            visited[position.0][position.1] = 1
            
            for i in 0..<4 {
                var max = position
                
                while(true) {
                    if (max.0 + dy[i] >= 0 && max.0 + dy[i] < board.count) && (max.1 + dx[i] >= 0 && max.1 + dx[i] < board[0].count) {
                        if (board[max.0 + dy[i]][max.1 + dx[i]] != "D") {
                            max = (max.0 + dy[i], max.1 + dx[i])
                        }
                        else { break }
                    }
                    else { break }
                }
                
                if max == position { continue }
                
                if board[max.0][max.1] == "G" {
                    answer = count
                    return
                }
                else if visited[max.0][max.1] == 1 {
                    continue
                }
                queue.append(max)
            }
        }
        
    }
}

bfs()
print(answer)
