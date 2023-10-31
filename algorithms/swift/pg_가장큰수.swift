import Foundation

// pg_가장 큰 수
// 처음 시도로는 맨 앞자리가 같은 친구들끼리 자릿수로 비교하려고했는데
// 코드도 방대해지고 잘 풀리지가 않아서 좀 고민하다가
// 결국 문자열 2개 붙여서 큰 값을 비교해주면 되겠다 라고 생각해서 한 번 해보니까
// 풀려쓰,, 문제를 작게 쪼개서 생각해보는것도 조을듯~~
func solution(_ numbers:[Int]) -> String {
    let strNums = numbers.map { String($0) }.sorted { lhs, rhs in
        return Int(lhs + rhs)! > Int(rhs + lhs)!
    }
    if strNums.first == "0" { return "0" }
    
    return strNums.reduce("", +)
}
