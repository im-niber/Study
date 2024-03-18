// boj_별 찍기 - 10, 2447
// 재귀문제인데 좀 오래걸렸다 규칙을 찾아서 할까하다가 잘 생각이 안나서,,,
// 시도하던중에 결국 지우기만 하면 풀리겠다 싶어서
// 먼저 다 별을 그린 배열을 만들고 지우는 부분만 구현을 시도했다
// 근데 시간초과가 나서 이유를 모르고있다가
// print를 매우 많이하고 있다는걸 깨닫고 joined 을 사용해서 print 횟수를 줄였더니
// 다행히도 통과했다
func baek() {
    let N = Int(readLine()!)!
    var ans: [[String]] = Array(repeating: Array(repeating: "*", count: N), count: N)

    func recursive(sti: Int, stk: Int, n: Int) {
        if n == 1 { return }
        
        for i in 0..<3 {
            for k in 0..<3 {
                let sti = sti + i * n / 3
                let stk = stk + k * n / 3
                
                if i == 1, k == 1 {
                    for i in 0..<n/3 {
                        for k in 0..<n/3 {
                            ans[sti + i][stk + k] = " "
                        }
                    }
                }
                
                recursive(sti: sti, stk: stk, n: n / 3)
            }
        }
    }
    
    recursive(sti: 0, stk: 0, n: N)
    
    for i in 0..<N {
        print(ans[i].joined())
    }
}

baek()
