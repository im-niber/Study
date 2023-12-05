import Foundation

// 가장 큰 정사각형 찾기
// 좀 걸린 문제 간단한 BFS 문제인줄 알았으나
// 아무리 반복횟수를 줄여봐도 안되겠다고 생각이 들어서
// 질문게시판 hint를 찾아 DP로 푸는거구나 깨닫고
// 좀 고민을하고 나온 풀이.. DP인걸 깨달았다면 빨리 풀었을둣
// BFS로 풀어야겠다라고 생각을 해버리니까 더 막히는듯,, 유연한사고..!
func solution(_ board: [[Int]]) -> Int {
    var answer = 0
    var dp = board
    dp.forEach { if $0.contains(1) { answer = 1 } }
    
    for y in 1..<board.count {
        for x in 1..<board[y].count {
            if dp[y][x] != 0 {
                dp[y][x] = min(dp[y - 1][x - 1], dp[y][x - 1], dp[y - 1][x]) + 1
                answer = max(answer, dp[y][x])
            }
        }
    }
    
    return answer * answer
}

// BFS 풀이 시간초오과
func solution2(_ board:[[Int]]) -> Int {
    var answer: Int = 0
    var nowCnt = 0
    
    let dy = [0, 1, 1]
    let dx = [1, 0, 1]
    
    func verify(_ a: Int, _ b: Int) -> Bool {
        0 <= a && a < board.count && 0 <= b && b < board[0].count
    }
    
    func bfs(_ y: Int, _ x: Int) {
        var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: board[0].count), count: board.count)
        visited[y][x] = true
        answer = max(answer, 1)
        
        var queue = [(y,x)]
        var value = 1
        var cnt = 1
        var tempQueue: [(Int, Int)] = []
        
        while(!queue.isEmpty) {
            for _ in 0..<queue.count {
                let item = queue.removeLast()
                
                for i in 0..<3 {
                    let (ny, nx) = (item.0 + dy[i], item.1 + dx[i])
                    if verify(ny, nx) && !visited[ny][nx] {
                        if board[ny][nx] == 1 {
                            value += 1
                            tempQueue.append((ny, nx))
                            visited[ny][nx] = true
                        }
                        else {
                            cnt += 1
                            if value == cnt * cnt {
                                answer = max(answer, value)
                                nowCnt = max(cnt, nowCnt)
                            }
                            
                            return
                        }
                    }
                }
            }
            
            queue += tempQueue
            tempQueue = []
            cnt += 1
            
            if value == cnt * cnt {
                answer = max(answer, value)
                nowCnt = max(cnt, nowCnt)
            }
            
            else { return }
        }
    }
    
    var i = 0
    while true {
        var k = 0
        while true {
            
            if board[i][k] == 1 {
                bfs(i,k)
            }
            if nowCnt == 0 { k += 1 }
            else { k += nowCnt }
            if k >= board[0].count { break }
        }
        i += 1

        if i >= board.count - nowCnt { break }
    }
//
//    for i in 0..<board.count {
//
//
//        while true {
//            var k = 0
//            if board[i][k] == 1 {
//                bfs(i,k)
//            }
//            if nowCnt == 0 { k += 1 }
//            else { k += nowCnt }
//            if k >= board[0].count { break }
//        }
//
////        for k in 0..<board[0].count {
////            if board[i][k] == 1 {
////                if verify(i + nowCnt, k + nowCnt) && board[i + nowCnt][k + nowCnt] == 1 &&
////                board[i + nowCnt][k] == 1 && board[i][k + nowCnt] == 1 {
////                    bfs(i, k)
////                }
////            }
////        }
//    }
//
    return answer
}
