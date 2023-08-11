import Foundation

// pg_소수 찾기
// 숫자의 모든 케이스를 찾아서 소수 판별 알고리즘을 적용해서 풀었던 문제
// 효율적인지는 잘 모르게씀,, 그리고 프로그래머스에서 split("") 이 부분이 오류가 뜨는데 why?
func solution(_ numbers:String) -> Int {
    var res = 0
    var splitNumbers: [String] = []
    for item in numbers {
        splitNumbers.append(String(item))
    }
    var totalCase: Set<Int> = []
    var visited: [Int: Bool] = [:]
    
    func isPrime(_ num: Int) {
        if num < 2 { return }
        for i in 2..<num {
            if i*i > num { break }
            if num % i == 0 { return }
        }
        res += 1
    }
    
    func dfs(arr: [String], count: Int, visited: [Int: Bool]) {
        var visited = visited
        
        if arr.count == count && arr.first! != "0" {
            totalCase.insert(Int(arr.joined())!)
            return
        }
        
        for i in 0..<splitNumbers.count {
            if visited[i, default: false] { continue }
            visited[i, default: false] = true
            dfs(arr: arr + [splitNumbers[i]], count: count, visited: visited)
            visited[i, default: false] = false
        }
    }

    for i in 1...splitNumbers.count {
        for k in 0..<splitNumbers.count {
            dfs(arr: [], count: i, visited: visited)
            visited[k] = false
        }
        for item in totalCase {
            isPrime(item)
        }
        totalCase = []
    }

    return res
}
print(solution("123"))
print(solution("17"))
print(solution("011"))
