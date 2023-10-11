import Foundation

// pg_프렌즈 4블록
// 2*2의 사각형 모양으로 같은 원소이면 없애고 위에 블록들이
// 내려와서 다시 자리 채우고 이를 반복하는 문제
// 좀 더 깔끔한 풀이가 없을지 고민했는데 잘 생각이 안나서
// 구현으로 풀었던 문제, 몇개를 제거한지는 마지막에 빈 원소들의 개수를 리턴하였다
func solution(_ m:Int, _ n:Int, _ board:[String]) -> Int {
    var board = board.map { Array($0).map { String($0) } }
    
    while(true) {
        var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: n), count: m)
        
        for r in 0..<m {
            for c in 0..<n {
                if board[r][c] != "" && (r != m - 1 && c != n - 1) &&
                    board[r][c] == board[r][c + 1] &&
                    board[r][c] == board[r + 1][c] &&
                    board[r][c] == board[r + 1][c + 1] {
                    visited[r][c] = true; visited[r][c + 1] = true;
                    visited[r + 1][c] = true; visited[r + 1][c + 1] = true
                }
            }
        }
        
        for r in 0..<m {
            for c in 0..<n{
                if visited[r][c] { board[r][c] = "" }
            }
        }
        
        for r in stride(from: m - 1, to: 0, by: -1) {
            for c in 0..<n {
                if board[r][c] == "" {
                    for i in stride(from: r - 1, through: 0, by: -1) {
                        if board[i][c] != "" {
                            board[r][c] = board[i][c]
                            board[i][c] = ""
                            break
                        }
                    }
                }
            }
        }
        
        if visited.filter({ $0.contains(true) }).isEmpty { break }
    }
   
    return board.reduce(0) { res, item in
        res + item.filter { $0 == "" }.count
    }
}
