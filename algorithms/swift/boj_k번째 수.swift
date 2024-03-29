// k 번째 수, 1300
// 이분탐색 문제
// 자기 앞에 수가 몇 개가 되는지 규칙을 찾아야 하는 문제,, 어려웠따
// 범위 내에 임의의 수 하나 골라서 반복문으로 나눠가면서 누적해주면 되는 문제였다~
func baek() {
    let N = Int(readLine()!)!
    let K = Int(readLine()!)!
    
    var start = 1
    var end = N * N
    
    while start <= end {
        let mid = (start + end) / 2
        
        var count = 0
        for i in 1...N {
            count += min(mid / i, N)
        }
        
        if count >= K { end = mid - 1 }
        else { start = mid + 1 }
    }
    
    print(start)
}

baek()
