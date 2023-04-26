import Foundation


// DFS를 사용해서 풀었는데 문제 조건을 자세히 읽지않아서 좀 걸렸다
// 간만에 DFS라 좀 미숙한데 연습해야게쓰..
func solution(_ tickets:[[String]]) -> [String] {
    var answers: [[String]] = []
    var answer: [String] = ["ICN"]
    
    func setModel(_ tickets: [[String]]) -> [String : [String]]{
        var data: [String : [String]] = [:]
        
        for item in tickets {
            if data[item[0]] != nil {
                data[item[0]]?.append(item[1])
            } else {
                data[item[0]] = [item[1]]
            }
        }
        for item in data {
            data[item.key] = item.value.sorted { $1 < $0 }
        }
        return data
    }
    
    func dfs(_ items: [String: [String]], _ stack: [String], _ answer: [String], _ current: String) {
        var items = items, stack = stack, answer = answer
        
        if answer.count == tickets.count + 1 {
            answers.append(answer)
            return
        } else if stack.count == 0 { return }
        
        for item in stack {
            var temp = stack
            var tempItem = items[current]
            
            answer.append(item)
            var index = items[current]?.firstIndex(of: item)
            items[current]?.remove(at: index!)
        
            stack = items[item] ?? []
            
            dfs(items, stack, answer, item)
            
            answer.removeLast()
            stack = temp
            items[current] = tempItem
        }
    }
    
    var data = setModel(tickets)
    var stack: [String] = data["ICN"]!
    dfs(data, stack, answer, "ICN")
    
    answers = answers.sorted { lhs, rhs in
        var bool: Bool = false
        for i in 0..<lhs.count {
            if lhs[i] == rhs[i] { continue }
            else if lhs[i] < rhs[i] {
                bool = true
                break
            }
            bool = false
            break
        }
        return bool
    }

    return answers.first!
}

print(solution([["ICN", "JFK"], ["HND", "IAD"], ["JFK", "HND"]]))
print(solution([["ICN", "SFO"], ["ICN", "ATL"], ["SFO", "ATL"], ["ATL", "ICN"], ["ATL","SFO"], ["ICN", "SFO"], ["SFO", "ICN"]]))
print(solution([["ICN", "COO"], ["ICN", "BOO"], ["COO", "ICN"], ["BOO", "DOO"]]))
