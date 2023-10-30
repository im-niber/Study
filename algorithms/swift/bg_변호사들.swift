// 백준_변호사들 17304
// 문제추천을 받아서 풀어보았는데 상당히 오래걸려서 검색했으,,
// 뭔가 단방향 노드 처리를 하고 양방향 노드들을 남겨야하는 처리에서
// 애를 먹어서 ㅜㅜ, 이 부분은 쉽게 해결하고 넘어갔어야하는데 꼼꼼하지 못했던거같다
// 단방향으로 연결된 노드들을 잘 처리해주고, 양방향으로 연결된 노드들로
// cycle이 형성되는지를 dfs로 확인하고 return해주면 되는 좀 간단했던 문제이지싶다
let intInput = readLine()!.split(separator: " ").compactMap { Int($0 ) }
let N = intInput[0], M = intInput[1]
var visited = Array(repeating: false, count: N + 1); visited[0] = true

var my: [Int : Set<Int>] = [:]

for i in 1...N {
    my[i] = []
}

for _ in 0..<M {
    let intInput = readLine()!.split(separator: " ").compactMap { Int($0 ) }
    let a = intInput[0], b = intInput[1]

    my[a]?.insert(b)
}

var edges: [(Int, Int)] = []
for item in my {
    for node in item.value {
        if !my[node]!.contains(item.key) {
            visited[node] = true
        }
        else {
            if item.key > node {
                edges.append((item.key, node))
            }
        }
    }
}


for i in 1...N {
    my[i] = []
}

for (a, b) in edges {
    if visited[a] && visited[b] { continue }
    else if visited[a] || visited[b] {
        visited[a] = true; visited[b] = true
    }
    else {
        my[a]?.insert(b); my[b]?.insert(a)
    }
}

func dfs(node: Int, prev: Int) -> Bool {
    if visited[node] { return true }
    visited[node] = true

    for item in my[node]! {
        if item == prev { continue }

        if dfs(node: item, prev: node) {
            return true
        }
    }
    return false
}

func sol() -> String {
    for item in my {
        if visited[item.key] { continue }
        
        if !dfs(node: item.key, prev: 0) {
            return "NO"
        }
    }
    return "YES"
}
print(sol())
