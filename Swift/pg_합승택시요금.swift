import Foundation

// pg_합승 택시 요금
// 여러시도했으나 못풀어서 질문게시판을 확인해서 풀었음,,
// 정점간의 최소거리 구하는 부분이 잘 안되었던거같다 그리고 노드가 200개라 크게 고민하지않고
// 이차원 배열로 만들어서 했었어도 좋았을듯함 내가 시도한 풀이는 아래..!
func solution(_ n:Int, _ s:Int, _ a:Int, _ b:Int, _ fares:[[Int]]) -> Int {
    var MAX = 200000
    var weight: [[Int]] = Array(repeating: Array(repeating: MAX, count: n + 1), count: n + 1)

    for item in fares {
        weight[item[0]][item[1]] = item[2]
        weight[item[1]][item[0]] = item[2]
    }
    
    for i in 1...n { weight[i][i] = 0 }
    
    for i in 1...n {
        for k in 1...n {
            for j in 1...n {
                if weight[k][i] + weight[i][j] < weight[k][j] {
                    weight[k][j] = weight[k][i] + weight[i][j]
                }
            }
        }
    }
    var res = weight[s][a] + weight[s][b]
    for i in 1...n {
        res = min(res, weight[s][i] + weight[i][a] + weight[i][b])
    }
    
    return res
}

import Foundation

func solution2(_ n:Int, _ s:Int, _ a:Int, _ b:Int, _ fares:[[Int]]) -> Int {
    var dict: [Int: [(Int, Int, Int)]] = [:]
    var weight: [Int: [Int : Int]] = [:]
    var edges: Set<[Int]> = []
    
    for item in fares {
        dict[item[0], default: []].append((item[0], item[1], item[2]))
        dict[item[1], default: []].append((item[1], item[0], item[2]))
    }
    
    for i in 1...n { weight[i, default: [:]][i] = 0 }
    
    for i in 1...n {
        var queue = dict[i] ?? []
        var stack: [(Int, Int, Int)] = []
        
        while(!queue.isEmpty) {
            let node = queue.removeLast()
            
            edges.insert([node.0, node.0])
            if edges.contains([node.0, node.1]) || edges.contains([node.1, node.0]) {
                if queue.isEmpty { swap(&queue, &stack) }
                continue
            }
            edges.insert([node.0, node.1])
            edges.insert([node.1, node.0])
            
            weight[i]![node.1] = min(weight[i]?[node.1] ?? Int.max, weight[i]![node.0]! + node.2)
            weight[node.1]![i] = weight[i]![node.1]
            stack += dict[node.1] ?? []
            if queue.isEmpty { swap(&queue, &stack) }
        }
        edges = []
    }
    
    var res = weight[s]![a]! + weight[s]![b]!
    
    var visited = Array(repeating: false, count: n + 1)
    visited[s] = true
    
    var queue = dict[s] ?? []
    visited[s] = true
    while(!queue.isEmpty) {
        let node = queue.removeLast()
        if visited[node.1] { continue }
        visited[node.1] = true
        res = min(res, weight[s]![node.1]! + weight[node.1]![a]! + weight[node.1]![b]!)
        queue += dict[node.1] ?? []
    }
    
    return res
}

