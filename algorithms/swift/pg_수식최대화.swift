import Foundation

// pg_수식 최대화
// 연산자의 우선순위를 조정하여 최댓값을 리턴하는 문제
// 연산자가 최대 3개라서 모든 케이스를 배열에 담아서 반복하여 해결하였다
func solution(_ expression:String) -> Int64 {
    var res: Int64 = 0
    let operArray: [[String]] = [
        ["+", "*", "-"],
        ["+", "-", "*"],
        ["*", "+", "-"],
        ["*", "-", "+"],
        ["-", "+", "*"],
        ["-", "*", "+"]
    ]
    
    let numbers = expression.split { $0 == "-" || $0 == "*" || $0 == "+" }.map { Int($0)! }
    let opers = expression.split { $0.isNumber }.map { String($0) }
    
    for item in operArray {
        var numbers = numbers
        var opers = opers

        for char in item  {
            
            while(opers.contains(char)) {
                let idx = opers.firstIndex(of: char)!
                
                if char == "+" {
                    numbers[idx] += numbers[idx + 1]
                }
                else if char == "*" {
                    numbers[idx] *= numbers[idx + 1]
                }
                else {
                    numbers[idx] -= numbers[idx + 1]
                }
                numbers.remove(at: idx + 1)
                opers.remove(at: idx)
            }
        }
        
        res = max(res, Int64(abs(numbers[0])))
    }
    
    return res
}

print(solution("100-200*300-500+20"))
print(solution("50*6-3*2"))
