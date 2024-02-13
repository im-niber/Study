// boj_마법사 상어와 파이어볼
// 구현문제인데 인덱스를 넘어가는 부분 처리에서 뭔가 좀 막혀서
// 오래걸렸다,,, 찾아보니 Swift에서 % 연산자는 음수는 다른 언어와 좀 다르게
// 작동해서 N을 더 해줘야 한다.. 요 부분이 빠져서 좀 걸려쓰..
func baek() {
    let input = readLine()!.split(separator: " ").compactMap { Int($0) }
    let N = input[0], M = input[1], K = input[2]
    
    struct FireBall {
        let r: Int, c: Int, m: Int, s: Int, d: Int
    }
    
    var nowFireballs: [FireBall] = []
    
    for _ in 0..<M {
        let fireBallInput = readLine()!.split(separator: " ").compactMap { Int($0) }
        let fireBall = FireBall(r: fireBallInput[0] - 1, c: fireBallInput[1] - 1, m: fireBallInput[2], s: fireBallInput[3], d: fireBallInput[4])
        nowFireballs.append(fireBall)
    }
    
    let d = [(-1, 0), (-1, 1), (0, 1), (1, 1), (1, 0), (1, -1), (0, -1), (-1, -1)]
    
    var maps = Array(repeating: Array(repeating: [FireBall](), count: N), count: N)
    
    for _ in 0..<K {
        while !nowFireballs.isEmpty {
            let fireBall = nowFireballs.removeLast()
            
            let (dy, dx) = (d[fireBall.d].0 * fireBall.s, d[fireBall.d].1 * fireBall.s)
            var row = fireBall.r + dy
            var col = fireBall.c + dx
            row %= N
            col %= N

            if row < 0 { row += N }
            if col < 0 { col += N }
            maps[row][col].append(fireBall)
        }
        
        for i in 0..<N {
            for j in 0..<N {
                
                if maps[i][j].count == 1 {
                    let fireBall = FireBall(r: i, c: j, m: maps[i][j].first!.m, s: maps[i][j].first!.s, d: maps[i][j].first!.d)
                    nowFireballs.append(fireBall)
                    
                    maps[i][j] = []
                }
                
                if maps[i][j].count >= 2 {
                    var m = 0, s = 0
                    
                    for item in maps[i][j] {
                        m += item.m
                        s += item.s
                    }
                    m /= 5
                    s /= maps[i][j].count
                    
                    var ds = [0, 2, 4, 6]
                    var flag: Int? = nil

                    for item in maps[i][j] {
                        if flag == nil { flag = item.d % 2 }
                        else {
                            if flag == item.d % 2 { continue }
                            else { ds = [1,3,5,7] }
                        }
                    }
                    
                    
                    maps[i][j] = []
                    if m == 0 { continue }
                    
                    for k in 0..<4 {
                        let fireball = FireBall(r: i, c: j, m: m, s: s, d: ds[k])
                        nowFireballs.append(fireball)
                    }
                }
            }
        }
    }

    var ans = 0

    while !nowFireballs.isEmpty {
        let fireBall = nowFireballs.removeLast()
        ans += fireBall.m
    }
    print(ans)
}

baek()
