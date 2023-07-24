import Foundation

// pg_전력망을 둘로 나누기
// 전선을 끊어서 전력망 두 부분의 노드 개수를 최대한 비슷하게 하는 문제
// 방문 배열을 이용해서 해결하였다
func solution(_ n:Int, _ wires:[[Int]]) -> Int {
    var ans = 100
    let wires = wires
    var maps: [Int: [Int]] = [:]
    
    for k in 0..<n - 1 {
        if maps[wires[k][0]] != nil {
            maps[wires[k][0]]?.append(wires[k][1])
        }
        else { maps[wires[k][0]] = [wires[k][1]] }
        
        if maps[wires[k][1]] != nil {
            maps[wires[k][1]]?.append(wires[k][0])
        }
        else { maps[wires[k][1]] = [wires[k][0]] }
    }
    
    for wire in wires {
        var visited = Array(repeating: false, count: n + 1)
        
        // 전선을 끊었다는 부분을 둘 다 방문했다고 치고, true로 주었다
        // 이렇게 한다면 다음 노드로 가는 부분이 끊기므로 노드의 연결을 끊는 효과와 동일하다
        visited[wire[0]] = true
        visited[wire[1]] = true
        
        var queue = [wire[0]]
        
        while(!queue.isEmpty) {
            let item = queue.popLast()!
            
            for node in maps[item]! {
                if !visited[node] {
                    visited[node] = true
                    queue.append(node)
                }
            }
        }
        // 방문 배열에서 true로 끊었으므로 그 수치만큼 1을 빼줌, false에서는 1을 더해야하는데,
        // visited가 0번 인덱스부터 시작하므로 굳이 안 더해줘도 더해진 효과와 동일함
        ans = min(ans, abs((visited.filter { $0 == true }.count - 1) - (visited.filter { $0 == false }.count)))
    }
    return ans
}

print(solution(9, [[1,3],[2,3],[3,4],[4,5],[4,6],[4,7],[7,8],[7,9]]))
print(solution(4, [[1,2],[2,3],[3,4]]))
print(solution(7, [[1,2],[2,7],[3,7],[3,4],[4,5],[6,7]]))
