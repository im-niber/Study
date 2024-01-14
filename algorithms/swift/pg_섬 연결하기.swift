import Foundation

// pg_섬 연결하기
// 좀 걸린 문제 Lv3이라 많이 쫄아버렸다...
// 좀 생각을 해보면 은근 간단한 문제였음
// 문제는 섬을 전부 갈 수 있게하는 최소의 경로들을 찾아야하는 문제였따
// 그래서 처음엔 전부 연결하고 하나씩 경로를 삭제해볼까했는데 시간을 되게많이 잡아먹을거같아서
// 다른 방식을 고민하다가, 경로를 하나 고를때마다 갈 수 있는지 체크를하고
// 갈 수 있다면 해당 목적지까지의 경로를 전부 비교해서 제일 비싼 값과
// 지금 선택하는 경로에 cost와 비교해서 바꿔주는식으로 하면 될거같았다
// 이 발상은 맞았는데 구현에서 이상하게 하고 있어서 좀 걸렸으
// 다른 풀이는 크루스칼? 을 사용하던데 공부해봐야게쓰

func solution(_ n:Int, _ costs:[[Int]]) -> Int {
    var ans = 0
    let visited: [Bool] = Array(repeating: false, count: n)
    
    var dict: [Int: [Int : Int]] = [:]
    
    for i in 0..<n {
        for k in 0..<n {
            dict[i, default: [:]][k] = 0
            dict[k, default: [:]][i] = 0
        }
    }
    
    func dfs(_ node: Int, _ target: Int, edges: [((Int, Int),Int)] = [], visited: [Bool]) -> ((Int, Int),Int) {
        var visited = visited
        var i = 0, k = 0
        var minVal = 0
        
        visited[node] = true
        
        if dict[node]?[target] != 0 {
            var edges = edges
            edges.append(((node, target), dict[node]?[target] ?? -1))

            for item in edges where item.1 > minVal {
                minVal = item.1
                i = item.0.0; k = item.0.1
            }
            
            return ((i, k), minVal)
        }
        
        else {
            for item in dict[node]! {
                if !visited[item.key] && dict[node]![item.key] != 0 {
                    visited[item.key] = true
                    
                    ((i, k), minVal) = dfs(item.key, target, edges: edges + [((node, item.key), dict[node]?[item.key] ?? -1)], visited: visited)
                
                    if minVal != 0 { return ((i,k), minVal) }
                }
            }
        }
        return ((i, k), minVal)
    }
    
    for item in costs {
        let ((i,k),val) = dfs(item[0], item[1], visited: visited)
        
        // 못가는경우
        if val == 0 {
            dict[item[0]]![item[1]] = item[2]
            dict[item[1]]![item[0]] = item[2]
            ans += item[2]
        }
        
        else if val >= item[2] {
            ans -= val - item[2]
            
            dict[i]?[k] = 0
            dict[k]?[i] = 0
            
            dict[item[0]]![item[1]] = item[2]
            dict[item[1]]![item[0]] = item[2]
        }
        
        else { continue }
    }
    
    return ans
}
