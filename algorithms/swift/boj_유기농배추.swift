// boj_유기농배추
// bfs,dfs의 기초 문제 올만에 풀어봤다~
// 크게 어려운점은 없었고 좌표가 인덱스에서 벗어나는지, 방문여부 체크만 잘하믄댈듯
// 아래 문제는 visited도 안 써도 풀리지 싶음 방문하면 0으로 바꾸거나해서 ?
func baek() {
    let T = Int(readLine()!)!
    let dy = [1, 0, -1, 0]
    let dx = [0, 1, 0, -1]
    
    for _ in 0..<T {
        let input = readLine()!.split(separator: " ").compactMap { Int($0) }
        let M = input[0], N = input[1], K = input[2]
        
        var maps: [[Int]] = Array(repeating: Array(repeating: 0, count: M), count: N)
        var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: M), count: N)
        
        for _ in 0..<K {
            let input = readLine()!.split(separator: " ").compactMap { Int($0) }
            maps[input[1]][input[0]] = 1
        }
        
        
        func valid(_ y: Int, _ x: Int) -> Bool { 0 <= y && y < N && 0 <= x && x < M }
        
        var queue: [(Int, Int)] = []
        var cnt = 0
        
        for i in 0..<N {
            for k in 0..<M {
                
                if !visited[i][k] && maps[i][k] == 1 {
                    queue.append((i, k))
                    
                    while !queue.isEmpty {
                        let next = queue.removeFirst()
                        visited[next.0][next.1] = true
                        
                        for j in 0..<4 {
                            let (ny, nx) = (next.0 + dy[j], next.1 + dx[j])
                            
                            if valid(ny, nx) && !visited[ny][nx] && maps[ny][nx] == 1 {
                                queue.append((ny, nx))
                                visited[ny][nx] = true
                            }
                        }
                    }
                    cnt += 1
                }
            }
        }
        
        print(cnt)
    }
   
}

baek()
