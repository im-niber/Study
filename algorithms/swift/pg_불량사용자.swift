import Foundation

// pg_불량 사용자
// 제재하는 아이디와 유저 아이디를 비교해서 몇가지 경우의수가 나오는지 구하는 문제
// 먼저 banned_id 배열과 user_id를 비교하여 딕셔너리를 만들었다.
// 밴 아이디 목록에서 *rodo *rodo 이런 경우를 무시하고 모든 케이스를 구했다가 5번케이스에서 시간초과가 발생함
// 그래서 idx를 맨뒤에 추가로 붙여줘서 경우를 줄여서 통과함
extension String {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        if lhs.count != rhs.count { return false }
        var rhs = Array(rhs), lhs = Array(lhs)
        for i in 0..<lhs.count {
            if lhs[i] == "*" { rhs[i] = "*" }
        }
        return lhs == rhs
    }
}

func solution(_ user_id:[String], _ banned_id:[String]) -> Int {
    var idDict: [String: [String]] = [:]
    var users: Set<Set<String>> = []
    var i = 0
    for banid in banned_id {
        for user in user_id {
            if banid == user { idDict[banid + "\(i)", default: []].append(user) }
        }
        i += 1
    }
    
    func dfs(_ array: [String], _ idx: Int, _ temp: Set<String>) {
        if idx == array.count || (temp.count == array.count) {
            users.insert(temp)
            return
        }
        var temp = temp

        for k in 0..<idDict[array[idx] + "\(idx)"]!.count {
            if temp.insert(idDict[array[idx] + "\(idx)"]![k]).inserted {
                dfs(array, idx + 1, temp)
                temp.remove(idDict[array[idx] + "\(idx)"]![k])
            }
        }
    }
    
    dfs(banned_id, 0, [])
    return users.count
}

print(solution(["frodo", "fradi", "crodo", "abc123", "frodoc"], ["fr*d*", "abc1**"]))
print(solution(["frodo", "fradi", "crodo", "abc123", "frodoc"], ["*rodo", "*rodo", "******"]))
print(solution(["frodo", "fradi", "crodo", "abc123", "frodoc"], ["fr*d*", "*rodo", "******", "******"]))
