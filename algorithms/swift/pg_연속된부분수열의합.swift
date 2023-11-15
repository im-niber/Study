import Foundation

// pg_연속된 부분 수열의 합
// 일일이 찾기보다는 k 값을 늘 비교하면서 적절하게 idx를 바꾸면 되지 않을까 싶어서
// k 값이 같은지 큰지 작은지를 나눠서 반복문을 돌려서 푼 문제
func solution(_ sequence:[Int], _ k:Int) -> [Int] {
    var ans: [Int] = [1000000, 1000000]
    
    var s_idx = 0
    var e_idx = 1
    var val = 0
    var count = Int.max
    let k_idx = sequence.firstIndex(of: k)
    if let kidx = k_idx { return [kidx, kidx] }
    
    val = sequence[s_idx] + sequence[e_idx]
    while(s_idx < sequence.count) {
        
        if val < k {
            if e_idx + 1 != sequence.count {
                e_idx += 1
                val += sequence[e_idx]
            }
            else { break }
        }
        
        else if val == k {
            let newCount = e_idx - s_idx - 1
            
            if count > newCount {
                ans[0] = s_idx
                ans[1] = e_idx
                count = newCount
            }
            
            else if count == newCount && s_idx < ans[0] {
                ans[0] = s_idx
                ans[1] = e_idx
            }

            val -= sequence[s_idx]
            s_idx += 1
        }
        
        else {
            val -= sequence[s_idx]
            s_idx += 1
        }
    }
    
    return ans
}
