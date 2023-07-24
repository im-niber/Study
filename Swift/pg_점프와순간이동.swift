import Foundation

// pg_점프와 순간이동
// 순간이동은 결국 건전지 사용량이 들지 않으므로, n이 2로 계속 나눠지는지가 중요하다
// 홀수면 1을 빼주고 건전지 사용량을 1 늘린다
func solution(_ n:Int) -> Int {
    var ans: Int = 1
    var n = n
    
    while(n != 1) {
        if n % 2 != 0 {
            ans += 1
            n -= 1
            continue
        }
        
        n /= 2
    }

    return ans
}
