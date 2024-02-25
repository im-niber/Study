// boj_단절선 11400
// 많이 어려웠떤문제,, 방문 여부를 어떻게 해서
// 종료해야할지 고민을 많이 했는데 결국 잘 안풀려서
// 검색찬스를 사용해버렸다,, 방문한 순서를 바탕으로
// 구분을 짓는 방식으로 해결하였다...
// 처음 시도할때는 사이클이 생기는지를 체크하려고했는데 좀 잘 안되는듯요게,,
func baek() {
    let input = readLine()!.split(separator: " ").compactMap { Int($0) }
    let V = input[0], E = input[1]
    
    var tree: [Int: [Int]] = [:]
    
    for _ in 0..<E {
        let input = readLine()!.split(separator: " ").compactMap { Int($0) }
        tree[input[0], default: []].append(input[1])
        tree[input[1], default: []].append(input[0])
    }
    
    struct Edge: Hashable {
        let left: Int
        let right: Int
    }
    
    var cnt = 0
    var answerEdges: [Edge] = []
    var indexs: [Int] = Array(repeating: 0, count: V + 1)
    
    func dfs(_ now: Int, _ parent: Int) -> Int {
        indexs[now] = cnt + 1
        cnt += 1
        
        var num = indexs[now]
        
        for item in tree[now] ?? [] {
            let next = item
            
            if item == parent { continue }
            
            if indexs[next] == 0 {
                let indexNum = dfs(next, now)
                num = min(num, indexNum)
                
                if indexNum > indexs[now] {
                    answerEdges.append((Edge(left: min(now, next), right: max(now, next))))
                }
            }
            
            else { num = min(indexs[next], num) }
            
        }
        
        return num
    }
    
    dfs(1, 0)
    
    print(answerEdges.count)
    for item in answerEdges.sorted(by: { lhs, rhs in
        if lhs.left == rhs.left { return lhs.right < rhs.right }
        return lhs.left < rhs.left
    }) {
        print(item.left, item.right)
    }
}

baek()
