extension Int {
    static public var max: Int {
        return 2000000
    }
}

// pg_배달
// 처음엔 dfs 방식으로 시도를 하였으나 32번 케이스에서 계속 시간초과가 떠서
// 좀 고민하다가 가중치가 매우 작고, k는 매우 클 때는 모든 노드를 다 살펴보니까
// 최악의 경우 N! 정도가 나올거라 생각했어서 dfs 방식은 좀 힘들거라 생각해서
// 플로이드 와샬 풀이로 풀었다
func solution(_ N:Int, _ road:[[Int]], _ k:Int) -> Int {
    var answer = 0
    var dict: [Int: [Int:Int]] = [:]
    
    for i in 1...N {
        for k in 1...N {
            dict[i, default: [:]][k, default: Int.max] = Int.max
            dict[k, default: [:]][i, default: Int.max] = Int.max
        }
    }
    
    dict[1]![1] = 0
    
    for item in road {
        dict[item[0]]![item[1]]! = min(item[2], dict[item[0]]![item[1]]!)
        dict[item[1]]![item[0]]! = min(item[2], dict[item[1]]![item[0]]!)
    }
    
    for k in 1...N {
        for i in 1...N {
            for j in 1...N {
                if (dict[i]![k]! != Int.max && dict[k]![j]! != Int.max) &&
                    dict[i]![j]! > dict[i]![k]! + dict[k]![j]! {
                    dict[i]![j]! = dict[i]![k]! + dict[k]![j]!
                }
            }
        }
    }
    
    for item in dict[1] ?? [:] {
        if item.value <= k { answer += 1 }
    }
    
    return answer
}

// pg_배달 dfs 방식, 32 케이스 시간초과 -> 아무리 시도해도 힘들지않을가시픔
func solution_dfs(_ N:Int, _ road:[[Int]], _ k:Int) -> Int {
    var answer = 0
    var dict: [Int: [Int:Int]] = [:]
    
    for item in road {
        dict[item[0], default: [:]][item[1], default: Int.max] = min(item[2], dict[item[0], default: [:]][item[1], default: Int.max])
        dict[item[1], default: [:]][item[0], default: Int.max] = min(item[2], dict[item[1], default: [:]][item[0], default: Int.max])
    }
    
    func chkRoad(node: Int, next: Int, value: Int, visited: [Bool]) {
        var visited = visited
        visited[node] = true
        
        if value > k { return }
        
        if dict[1]![next] != nil {
            dict[1]![next]! = min(dict[1]![next]!, value)
        }
        
        else { dict[1]![next] = value }
        
        for item in dict[next] ?? [:] {
            if !visited[item.key] {
                chkRoad(node: next, next: item.key, value: value + item.value, visited: visited)
            }
        }
    }
    
    var visited: [Bool] = Array(repeating: false, count: N + 1)
    visited[1] = true
    
    for item in dict[1] ?? [:] {
        chkRoad(node: 1, next: item.key, value: item.value, visited: visited)
    }
    
    for item in dict[1]! {
        if k >= item.value { answer += 1 }
    }
    
    return answer + 1
}
