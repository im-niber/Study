import Foundation

// pg_퍼즐조각 채우기
// 하루걸린문제,,, 접근방식은 맞았는뎅 조금 디테일이 부족했고
// 구현이 좀 걸렸다..
// 먼저 게임 보드에서 빈칸도 1로 처리해서 bfs 함수 하나로 처리하려고 했고
// 퍼즐에서 찾은 퍼즐조각 칸들을 회전한 배열을 같이 구해주고
// 빈칸들과 비교를 시작하는데, 이때 처음에는 퍼즐에서 맨 왼쪽에 있는 idx와
// 보드에서 빈칸의 맨 왼쪽 idx의 차이를 빼줘야겠다라고 생각했는데 좀 예외가 있어서
// 3 6 8 10 13 22 케이스가 틀렸슴,, 그래서 최소 x, 최소 y를 모든 퍼즐의 idx에 빼주는 식으로 구현하여
// 기준점을 고정시키니까 맞았다 ~
func solution(_ game_board:[[Int]], _ table:[[Int]]) -> Int {
    var ans = 0
    
    let dy = [0,1,0,-1]
    let dx = [1,0,-1,0]

    var game_board = game_board
    
    for i in 0..<game_board.count {
        for k in 0..<game_board.count {
            if game_board[i][k] == 0 { game_board[i][k] = 1 }
            else { game_board[i][k] = 0 }
        }
    }
    
    var puzzles: [[[(Int, Int)]]] = []
    var emptyBoards: [[[(Int, Int)]]] = []

    func verify(_ y: Int, _ x: Int) -> Bool {
        (0 <= y && y < table.count) && (0 <= x && x < table.count)
    }
    
    // 퍼즐 찾는 함수
    func bfs(_ table: [[Int]]) -> [[[(Int, Int)]]] {
        var arr: [[[(Int, Int)]]] = []
        var visited = Array(repeating: Array(repeating: false, count: table.count), count: table.count)
        
        for y in 0..<table.count {
            for x in 0..<table.count {
                if !visited[y][x] && table[y][x] == 1 {
                    var temp: [(Int, Int)] = [(y, x)]
                    var queue: [(Int, Int)] = [(y, x)]
                    visited[y][x] = true
                    
                    while !queue.isEmpty {
                        let (y, x) = queue.removeFirst()
                        
                        for i in 0..<4 {
                            let (ny, nx) = (y + dy[i], x + dx[i])
                            
                            if verify(ny, nx) && !visited[ny][nx] && table[ny][nx] == 1 {
                                queue.append((ny, nx))
                                temp.append((ny, nx))
                                visited[ny][nx] = true
                            }
                        }
                    }
                    arr.append([temp])
                }
            }
        }
        
        return arr
    }
    
    puzzles = bfs(table)
    emptyBoards = bfs(game_board)
    
    for i in 0..<puzzles.count {
        var arr: [[(Int, Int)]] = [[], [], []]
        for puzzles in puzzles[i] {
            for var (y, x) in puzzles {
                // 90, 180, 270 idx 변환
                for k in 0..<3 {
                    (y, x) = (x, table.count - 1 - y)
                    arr[k].append((y, x))
                }
            }
        }
        
        puzzles[i] += arr
    }
    
    var visited: [Bool] = Array(repeating: false, count: puzzles.count)
    
    for item in emptyBoards {
        for temp in item {
            for j in 0..<puzzles.count {
                if puzzles[j][0].count != temp.count || visited[j] { continue }
                var boardMinX = Int.max
                var boardMinY = Int.max
                
                for (y, x) in temp {
                    boardMinX = min(boardMinX, x)
                    boardMinY = min(boardMinY, y)
                }
                
                for k in 0..<4 {
                    var puzzleMinX = Int.max
                    var puzzleMinY = Int.max
                    var isAllSame = true
                    
                    for (y, x) in puzzles[j][k] {
                        puzzleMinX = min(puzzleMinX, x)
                        puzzleMinY = min(puzzleMinY, y)
                    }
                    
                    for boardIdx in temp {
                        var isSame = false
                        
                        for puzzleIdx in puzzles[j][k] {
                            if (boardIdx.0 - boardMinY == puzzleIdx.0 - puzzleMinY
                                && boardIdx.1 - boardMinX == puzzleIdx.1 - puzzleMinX) {
                                isSame = true
                                break;
                            }
                        }
                        
                        if isSame { continue }
                        else { isAllSame = false; break; }
                    }
                    
                    if isAllSame {
                        ans += puzzles[j][k].count
                        visited[j] = true
                        break
                    }
                }
                if visited[j] { break }
            }
            
        }
    }
    
    return ans
}
