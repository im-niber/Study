import Foundation

// pg_입국심사
// 이분탐색 카테고리에 들어가있어서 쉽게 풀었다
// 값을 정하고 만족하는식으로 역으로 탐색하면 쉽게 풀린다
func solution(_ n:Int, _ times:[Int]) -> Int {
    var ans = Int.max
    let maxTime = 1000000000 * 1000000000 + 1
    
    func search() {
        var start = 0
        var end = maxTime
        
        while (start < end && start != end) {
            let mid = (start + end) / 2
            let value = times.reduce(into: 0) { partialResult, item in
                partialResult += mid / item
            }
            
            if value >= n {
                ans = min(ans, mid)
                end = mid
            }
            
            else { start = mid + 1 }
        }
    }
    
    search()
    return ans
}
