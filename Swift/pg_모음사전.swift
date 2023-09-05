import Foundation

// pg_모음 사전
// 알파벳의 순서를 문제대로 다 구현하여 firstIndex를 찾아서 해결한 문제
// 종료 조건을 잘 생각해야하는 문제인듯함
func solution(_ word:String) -> Int {
    var visited: [String: Int] = [:]
    var alphabets: [String] = []
    let moum = ["A", "E", "I", "O", "U"]

    func dfs(_ alphabet: String) {
        if alphabet.count > 5 { return }
        
        for i in 0..<5 {
            if visited[moum[i], default: 0] == 5 || alphabet.count == 5 {
                visited[moum[i], default: 0] -= 1
                continue
            }
            visited[moum[i], default: 0] += 1
            alphabets.append(alphabet + moum[i])
            dfs(alphabet + moum[i])
        }
    }
    dfs("")
    return alphabets.firstIndex(of: word)! + 1
}

print(solution("AAAAE"))
print(solution("AAAE"))
print(solution("I"))
print(solution("EIO"))
