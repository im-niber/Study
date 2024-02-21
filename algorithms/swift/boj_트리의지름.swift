/* 
 boj_1167 트리의지름
 예전에 파이썬으로 풀어봤는데 너무 오래전이라 다시 함 풀어봄
 처음 접근은 루트 노드를 찾아서 얘한테서 젤 먼 노드를 찾고, 가장 먼 노드를 기준으로
 다른 리프 노드들과 거리 비교를 하려고 했는데, 루트노드를 어떻게 찾지 하다가
 아무거나 정해도 괜찮겠다 싶어서 그렇게 하고
 이제 젤 먼 노드를 찾으면 얘부터 다른 리프노드를 비교해야하는데
 그렇게 된다면 최악의 경우 비교할때마다 다른 노드 전부 다 탐색이 되어야함
 부모노드가 뭔지 모르기때무네,, log V로 탐색을 올라가는게 쉽지 않아보였음 V log V로 풀고싶었는데
 그래서 이 방법도 좀 와닿지가 않아서 좀 더 생각하다가,,
 구하고 싶은건 아무 노드에서 -> 가장 먼 노드, 가장 먼 노드에서 -> 가장 먼 노드 이기 떄문에
 그냥 dfs 두 번 돌리면 되겠네 라는걸 깨달아버림,, 근데 직관적으로 아무 노드에서 가장 먼 노드에서 또 가장 먼게
 지름이라는 부분이 느낌이와서 이렇게했는데 다행히도 통과함,, 아마 예에ㅔㅅ날에 기억이 난듯?
 */
func baek() {
    let V = Int(readLine()!)!
    
    var tree: [Int: [Int: Int]] = [:]
    for _ in 0..<V {
        var input = readLine()!.split(separator: " ").compactMap { Int($0) }
        let first = input.removeFirst()
        
        for i in stride(from: 0, through: input.count, by: 2) {
            if input[i] == -1 { break }
            tree[first, default: [:]][input[i]] = input[i + 1]
        }
    }
    
    var ans = 0
    var tempNode = 0
    
    func dfs(_ start: Int) {
        var nodes = [(start, 0)]
        var visited: [Bool] = Array(repeating: false, count: V + 1)
        
        while !nodes.isEmpty {
            let (node, val) = nodes.removeLast()
            if val > ans { tempNode = node; ans = val }
            visited[node] = true
            
            for (k, v) in tree[node] ?? [:] {
                if !visited[k] {
                    nodes.append((k, v + val))
                    visited[k] = true
                }
            }
        }
    }
    
    dfs(1)
    dfs(tempNode)
    print(ans)
}

baek()
