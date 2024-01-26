import Foundation

// pg_양과 늑대
// Lv3라서 좀 이상하게 되어버린,,
// 일반적인 DFS랑 많이 안 다른데
// 양 마다 늑대 index 저장하고 차집합 카운트해서
// 적은 늑대를 마주치는 양을 먼저 탐색해야겠다라고 생각하고 풀이를 시작했는데
// 결국 똑같은 숫자의 경우 어떤 양을 고를지는 다 해봐야하므로 완탐문제였다..
// 시도를 이런식으로 해버려서 좀 먼길을 가버림,,
func solution(_ info:[Int], _ edges:[[Int]]) -> Int {
    
    var tree: [Int: Int] = [:]
    let visitedWolf: Set<Int> = []
    
    var sheepWolfDict: [Int : Set<Int>] = [:]
    var totalsheepCnt = 1
    
    for item in edges { tree[item[1]] = item[0] }
    
    func chkWolf(node: Int) {
        var stack: [Int] = [node]
        
        while !stack.isEmpty {
            let item = stack.removeLast()
            if item == 0 { return }
            let parent = tree[item]!
            stack.append(parent)
            if info[parent] == 1 { sheepWolfDict[node, default: []].insert(parent) }
        }
    }
    
    for i in 1..<info.count {
        if info[i] == 0 {
            sheepWolfDict[i] = []
            chkWolf(node: i)
        }
    }
    
    func solve(sheepWolfDict: [Int : Set<Int>], visitedWolf: Set<Int>, cnt: Int) -> Int {
        var sheepWolfDict = sheepWolfDict
        var visitedWolf = visitedWolf
        var sheepCnt = cnt
        
        while (sheepWolfDict.count != 0) {
            
            for item in sheepWolfDict {
                let subtracted = item.value.subtracting(visitedWolf)
                sheepWolfDict[item.key] = subtracted
            }
            
            let sortedSets = sheepWolfDict.sorted { lhs, rhs in
                lhs.value.count < rhs.value.count
            }
            
            let sameCntSets = sortedSets.filter({ lhs in
                lhs.value.count == sortedSets.first?.value.count
            })
            
            for item in sortedSets {
                let (node, wolfs) = item
                var visitedWolf2: Set<Int> = []
                
                for item in wolfs {
                    visitedWolf.insert(item)
                    visitedWolf2.insert(item)
                }
                
                if visitedWolf.count >= sheepCnt { break }
                sheepCnt += 1
    
                
                let sets = sheepWolfDict[node]
                sheepWolfDict[node] = nil
                
                totalsheepCnt = max(totalsheepCnt, solve(sheepWolfDict: sheepWolfDict, visitedWolf: visitedWolf, cnt: sheepCnt))
                
                visitedWolf.subtract(visitedWolf2)
                sheepCnt -= 1
                sheepWolfDict[node] = sets
            }
            
            let (node, wolfs) = sortedSets.first!
            sheepWolfDict[node] = nil
            
            for item in wolfs {
                visitedWolf.insert(item)
            }
            
            if visitedWolf.count >= sheepCnt { break }
            sheepCnt += 1
        }
        
        return max(totalsheepCnt, sheepCnt)
    }
    
    return solve(sheepWolfDict: sheepWolfDict, visitedWolf: visitedWolf, cnt: 1)
}
