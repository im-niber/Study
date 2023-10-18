import Foundation

// 2개 이하로 다른 비트
// 규칙을 찾으려고 하다가 좀 오래 걸린 문제
// 비트연산자를 써보고싶었는데 잘 떠오르지 않아서
// 문제에서 제시한대로 2가지의 비트를 바꾸는식으로 구현함
// 맨 뒤부터 0을 찾아서 1로바꿔주고 break를 해야 최소임을 보장하고
// 바꾼 인덱스부터 뒤로 순회하여 1을 0으로 바꿔주었슴
func solution(_ numbers:[Int64]) -> [Int64] {
    var ans: [Int64] = []
    
    for number in numbers {
        var flag = -1
        var str = String(number, radix: 2)
        if !str.contains("0") {
            str.insert("0", at: str.startIndex)
        }
        var arr = Array(str)
        for i in stride(from: arr.count - 1, through: 0, by: -1) {
            if arr[i] == "0" {
                arr[i] = "1"
                flag = i
                break
            }
        }
        
        for k in flag + 1..<arr.count {
            if arr[k] == "1" { arr[k] = "0"; break; }
        }
        ans.append(Int64(String(arr), radix: 2)!)
    }
    
    return ans
}

// 깔끔한 풀이 빝 연산자 개고수인듯하심,,
func solution2(_ numbers: [Int64]) -> [Int64] {
    return numbers.map(f)
}

func f(_ number: Int64) -> Int64 {
    return (number | ~number & (number + 1)) & ~((~number & (number + 1)) >> 1)
}
