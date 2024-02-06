import Foundation

// pg_순위
// 경기에서 누가 이기고 졌는지를 나타내는 배열을 주고
// 순위를 알 수 있는 노드가 몇개인지를 구하는 문제였다
// 처음 접근은 순위를 알아내려면 관계된 노드가 자기 빼고 n-1 개 노드 전부 다
// 연결이 되어 있어야 될 거 같은 생각에 구현을 시도했고
// 아래 처럼 집합을 사용해서 중복 노드등을 제거하고, 이긴쪽 진쪽 전부다 넣어 주었다
// 그러고 마지막에 노드마다 n-1개의 원소를 가지고 있으면 정답에 +1 해주고 리턴해주니 맞아쓰
// 다른 풀이는 플로이드 와샬도 있었다 ~, 아래 두개 나눈 경우를 함수로 만들었으면 좀 더 깔끔했을둣
func solution(_ n:Int, _ results:[[Int]]) -> Int {
    var wins: [Int: Set<Int>] = [:]
    var loses: [Int: Set<Int>] = [:]
    var totals: [Int: Set<Int>] = [:]
    var ans = 0
    
    for item in results {
        wins[item[0], default: []].insert(item[1])
        loses[item[1], default: []].insert(item[0])
    }
    
    for i in 1..<n + 1 {
        var set: Set<Int> = []
        var visited: [Bool] = Array(repeating: false, count: n + 1)
        visited[0] = true; visited[i] = true
        
        for item in loses[i] ?? [] {
            var arr = [item]
            visited[item] = true
            set.insert(item)
            
            while !arr.isEmpty {
                var newItem = arr.removeLast()
                for node in loses[newItem] ?? [] {
                    if !visited[node] {
                        arr.append(node)
                        set.insert(node)
                        visited[node] = true
                    }
                }
            }
        }
        
        for item in wins[i] ?? [] {
            var arr = [item]
            visited[item] = true
            set.insert(item)
            
            while !arr.isEmpty {
                var newItem = arr.removeLast()
                for node in wins[newItem] ?? [] {
                    if !visited[node] {
                        arr.append(node)
                        set.insert(node)
                        visited[node] = true
                    }
                }
            }
        }
        
        totals[i, default: []] = set
    }

    for i in 1..<n+1 {
        if totals[i]?.count == n - 1 { ans += 1 }
    }
    
    return ans
}
