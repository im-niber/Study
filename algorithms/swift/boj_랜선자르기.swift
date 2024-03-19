import Foundation

// boj_랜선자르기, 1654
// 이분탐색 문제를 한 번 풀어볼겸 푼 문제
// 예전에도 비슷한 문제를 풀었어서 구현하는 방식만 조금씩 다 다르게
// 느껴졌다ㅏㅏ
func baek() {
    let KN = readLine()!.split(separator: " ").compactMap { Int($0) }
    let K = KN[0], N = KN[1]
    
    var ans = 0
    
    var items: [Int] = []
    for _ in 0..<K { items.append(Int(readLine()!)!) }
    
    var start = 0
    var end = 2147483648
    
    while(start <= end) {
        let mid = (start + end) / 2
        var cnt = 0
        
        for item in items {
            cnt += (item / mid)
        }
        
        if cnt >= N {
            start = mid + 1
            ans = max(ans, mid)
        }
        
        else {
            end = mid - 1
        }
    }
    
    print(ans)
}
baek()
