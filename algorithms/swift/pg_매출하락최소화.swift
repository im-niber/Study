import Foundation

// pg_매출 하락 최소화
// 좀 어려운 문제였지만 dp라는걸 눈치채면 조금은 쉬워지는 문제였다
// 제일 아래 노드부터 값을 업데이트 하면서 계속 최솟값을 업데이트 해주기로 했다
// 그래서 dp 테이블 만들고, 해당 노드가 워크샵에 참석한 경우 최솟값은 1번 인덱스
// 아니면 0번 인덱스에 넣어줌
// 젤 아래 노드를 찾기 위해서 bfs로 레벨을 기록하고 노드들을 저장했는데
// 이거 그냥 DFS로 했으면 더 깔끔했을둣,,
// 업데이트하면서 중요한점은 해당 직원이 참석한 그룹이여도 다른 직원이
// 참석하는게 값이 더 낮은 경우도 있어서 그런 부분들을 비교해줘야한다는점이다.
// 고렇게 비교해서 적절한 값들로 업데이트 해주면서 쭉 0번 직원 CEO 까지 가면 된다 ~
func solution(_ sales:[Int], _ links:[[Int]]) -> Int {
    var dp: [Int : [Int]] = [:]
    var lv: [Int: [Int]] = [:]
    
    var parent: [Int : [Int]] = [:]
    var child: [Int : Int] = [:]
    
    lv[0] = [0]
    
    for item in links {
        parent[item[0] - 1, default: []].append(item[1] - 1)
        child[item[1] - 1] = item[0] - 1
    }
    
    func bfs() {
        var queue: [(Int, Int)] = [(0, 0)]
        while !queue.isEmpty {
            let (start, now) = queue.removeFirst()
            
            for item in parent[start] ?? [] {
                queue.append((item, now + 1))
                lv[now + 1, default: []].append(item)
            }
        }
    }
    
    bfs()
    
    for now in lv.keys.sorted(by: >) {
        
        for item in lv[now] ?? [] {
            
            if parent[item] != nil {
                
                let val = parent[item]?.reduce(0, { partialResult, child in
                    return partialResult + dp[child]![0]
                })
                
                var minValue = 0
                var minDiff = Int.max
                
                var isPossible = false
                for child in parent[item]! {
                    minDiff = min(minDiff, abs(dp[child]![0] - dp[child]![1]))
                    
                    if dp[child]![0] < dp[child]![1] {
                        minValue += dp[child]![0]
                    }
                    else {
                        isPossible = true
                        minValue += dp[child]![1]
                    }
                }
                
                if !isPossible { minValue += minDiff }
                
                dp[item, default: []].append(minValue)
                dp[item, default: []].append(min(val! + sales[item], minValue + sales[item]))
            }
            
            else {
                dp[item, default: []].append(0)
                dp[item, default: []].append(sales[item])
            }
            
        }
    }
    
    return min(dp[0]![0], dp[0]![1])
}
