import Foundation

// pg_문자열 압축
// 같은 문자열이 연속해서 나오는 경우 압축을 하는 문제
// 단순히 구현으로 풀었다. 조금 걸렸던 부분은 압축을 할 때 앞에 숫자를 붙여야하는데
// 아무 생각없이 붙는 숫자의 길이는 + 1 로 하고있어서 좀 걸렸던 문제,, 연속한
// 문자열이 100개면 100a 이런식으로 붙어야 하므로 문자열 길이 계산을 다르게 해줘야함
// 그 부분 말고는 크게 어려운 점은 없었던둣
func solution(_ s:String) -> Int {
    let arrs = Array(s)
    var ans = s.count
    
    for i in 1...s.count / 2 + 1 {
        var leng = s.count
        var count = 0
        var idx = 0
        
        while(idx + i + i <= s.count) {
            if arrs[idx..<idx + i] == arrs[idx + i..<idx + i + i] { count += 1 }
            else {
                let stringNum = String(count + 1).count
                count == 0 ? () : (leng -= (count * i) - stringNum)
                count = 0
            }
            
            idx += i
        }
        
        let stringNum = String(count + 1).count
        count == 0 ? () : (leng -= (count * i) - stringNum)
        
        ans = min(ans, leng)
    }
    
    return ans
}
