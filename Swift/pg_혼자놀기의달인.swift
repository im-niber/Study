import Foundation

// pg_혼자 놀기의 달인
// 문제에서 설명한대로 구현하면 되는 문제이다
// 방문 상태를 나타내는 배열을 만들어서 풀면 간단하다
func solution(_ cards:[Int]) -> Int {
    var result = 0
    var visited = Array(repeating: false, count: cards.count)
    var groups: [Int] = []
    var queue: [Int] = []
    
    for i in 0..<cards.count {
        var count = 0
        if visited[i] { continue }
        queue.append(cards[i])
        visited[i] = true
        
        while(!queue.isEmpty) {
            count += 1
            var item = queue.removeFirst() - 1
            
            if !visited[item] {
                queue.append(cards[item])
                visited[item] = true
            }
        }
        
        groups.append(count)
    }
    groups.sort(by: >)
    if groups.count == 1 { return 0 }
    return groups[0] * groups[1]
}

print(solution([8,6,3,7,2,5,1,4]))
