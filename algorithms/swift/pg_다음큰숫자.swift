import Foundation

// 다음 큰 숫자
// 조건이 자기보다 큰 자연수면서, 2진수의 1의 개수가 같아야 하는 가장 작은 수
// 를 찾는 문제고 n 은 백만 이하기도해서 그냥 반복해서 풀었다
// 2진수 만들어서 규칙 찾을까 싶기도 했는데 고냥 안했음
func solution(_ n:Int) -> Int {
    var countOne = String(n, radix: 2).filter { $0 == "1" }.count
    var i = 0
    
    while(true) {
        i += 1
        var val = n + i
        
        if String(val, radix: 2).filter({ $0 == "1" }).count == countOne {
            return val
        }
    }
    
    return 0
}
