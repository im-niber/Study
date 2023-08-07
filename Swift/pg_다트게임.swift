import Foundation

// pg_다트게임
// 구현문제, 문자열을 나눠서 풀었다면 더 깔끔했을듯함
// 다음 숫자가 나오는걸 조건으로 두어 계산을 진행하였다.
func solution(_ dartResult:String) -> Int {
    var res = 0
    var beforeNum = 0
    var num = 0
    
    var flag = false
    
    for char in dartResult {
        
        if char.isNumber {
            if num != 0 && !flag { num = 10; continue }
            
            if flag && beforeNum == 0 {
                beforeNum = num
                flag = false
            } else if flag && beforeNum != 0 {
                res += beforeNum
                beforeNum = num
                flag = false
            }
            
            num = Int(String(char))!
        }
        
        else if char == "*" || char == "#" {
            if char == "*" { beforeNum *= 2; num *= 2 }
            else { num *= -1 }
        }
        
        else {
            if char == "S" { flag = true }
            if char == "D" { num *= num; flag = true }
            if char == "T" { num *= num * num; flag = true }
        }
    }
    
    return res + num + beforeNum
}
