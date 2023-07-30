import Foundation

// pg_큰 수 만들기
// 테스트케이스 하나에서 시초가 나서 꽤 오래 걸렸는데 9를 먼저 발견하면 최댓값이므로
// 반복을 멈추는식으로 하니 해결이 되었다.
func solution(_ number:String, _ k:Int) -> String {
    let number = Array(number)
    var ans: [Character] = Array(repeating: "0", count: number.count - k)
    
    var idx = 0
    var i = 0
    var flag = 0

    while(idx != ans.count && i != number.count) {
        
        while(ans.count - idx <= number.count - i) {
            if number[i] == "9" {
                ans[idx] = "9"
                flag = i
                break
            }
            else if ans[idx] < number[i] {
                ans[idx] = number[i]
                flag = i
            }
            
            i += 1
        }
        
        i = flag + 1
        idx += 1
    }
    
    return String(ans)
}
