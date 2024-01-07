import Foundation

// pg_가장 먼 노드
// 프로그래머스 AI 추천문제 인디
// 바로 전에 푼 단어변환이랑 큰 차이가 없는듯하다
// BFS만 쓰면 풀려서 크게 고민할 부분은 없었고, 방문할 때의 가중치 값을
// 저장하는 배열을 사용하면서 풀면 된다.
func solution(_ n:Int, _ edge:[[Int]]) -> Int {
    var nodeVal: [Int] = Array(repeating: 0, count: n + 1)
    var dict: [Int: [Int]] = [:]
    
    for item in edge {
        dict[item[0], default: []].append(item[1])
        dict[item[1], default: []].append(item[0])
    }
    
    var queue: [Int] = dict[1]!
    for item in dict[1]! { nodeVal[item] = nodeVal[1] + 1 }
    nodeVal[1] = -1
    
    while !queue.isEmpty {
        let item = queue.removeFirst()
        
        for next in dict[item]! {
            if nodeVal[next] == 0 {
                nodeVal[next] = nodeVal[item] + 1
                queue.append(next)
            }
        }
    }
    let maxVal = nodeVal.max()!
    return nodeVal.filter { $0 == maxVal }.count
}
