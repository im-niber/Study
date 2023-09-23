import Foundation

// pg_합승 택시 요금
// 여러시도했으나 못풀어서 질문게시판을 확인해서 풀었음,,
// 정점간의 최소거리 구하는 부분이 잘 안되었던거같다 그리고 노드가 200개라 크게 고민하지않고
// 이차원 배열로 만들어서 했었어도 좋았을듯함 내가 시도한 풀이는 아래..!

// 추가로 힙을 사용한 다익스트라로 풀어보았다. 9/1
// 힙을 일단 하나 간단하게 만들고
// 하나의 정점에서 최소 거리인 정점을 찾아서 반복해주었다
// 기존 코드에서 수정하다보니 좀 더럽긴한둣,,
func solution(_ n:Int, _ s:Int, _ a:Int, _ b:Int, _ fares:[[Int]]) -> Int {
    struct Heap<T> {
        var array: [T] = []
        var priority: (T, T) -> Bool

        init(priority: @escaping (T, T) -> Bool, item: T) {
            self.priority = priority
            array.append(item)
            array.append(item)
        }
        
        var top: T { array[1] }
        
        // insert는 맨뒤에 넣고 index / 2 한거랑 비교해서 위치를 계속 바꿔줌
        mutating func insert(item: T) {
            array.append(item)
            var index = array.count - 1
            while(index != 1 && !priority(array[index / 2], array[index])) {
                array.swapAt(index / 2, index)
                index /= 2
            }
        }
        
        mutating func remove() -> T {
            let item = top
            heapify()
            return item
        }
        
        mutating func heapify() {
            var index = 1
            array.swapAt(index, array.count - 1)
            array.removeLast()
            while(index < array.count / 2) {
                
                if priority(array[index * 2], array[index * 2 + 1]) {
                    array.swapAt(index, index * 2)
                    index *= 2
                }
                
                else {
                    array.swapAt(index, index * 2 + 1)
                    index = index * 2 + 1
                }
            }
        }
    }
    
    let MAX = 40000001
    var dict: [Int: [(Int, Int, Int)]] = [:]
    var weight: [Int: [Int : Int]] = [:]
    
    for item in fares {
        dict[item[0], default: []].append((item[0], item[1], item[2]))
        dict[item[1], default: []].append((item[1], item[0], item[2]))
    }
    
    for i in 1...n {
        for k in 1...n {
            if weight[i]?[k] == nil {
                weight[i,default: [:]][k] = 2000000
            }
        }
    }
    
    for item in fares {
        weight[item[0], default: [:]][item[1]] = item[2]
        weight[item[1], default: [:]][item[0]] = item[2]
    }
    
    for i in 1...n { weight[i, default: [:]][i] = 0 }
    
    for i in 1...n {
        var heap = Heap<(Int, Int)>(priority: <, item: (MAX, 0))
        heap.remove()
    
        var visited: [Bool] = Array(repeating: false, count: n + 1)
        
        visited[i] = true
        var queue = dict[i] ?? []
        queue.forEach { heap.insert(item: ($0.2, $0.1)) }
        
        while(heap.array.count != 1) {
            let node2 = heap.remove()
            if visited[node2.1] { continue }
            visited[node2.1] = true

            for item in dict[node2.1]! {
                if weight[i]![item.1]! > weight[i]![node2.1]! + item.2 {
                    let value = weight[i]![node2.1]! + item.2
                    weight[i]![item.1]! = value
                    heap.insert(item: (value, item.1))
                }
            }
        }
    }
    var res = weight[s]![a]! + weight[s]![b]!

    for i in 1...n {
        res = min(res, weight[s]![i]! + weight[i]![a]! + weight[i]![b]!)
    }
    
    return res
}


// 플로이드 와샬
func solution(_ n:Int, _ s:Int, _ a:Int, _ b:Int, _ fares:[[Int]]) -> Int {
    var MAX = 200000
    var weight: [[Int]] = Array(repeating: Array(repeating: MAX, count: n + 1), count: n + 1)

    for item in fares {
        weight[item[0]][item[1]] = item[2]
        weight[item[1]][item[0]] = item[2]
    }
    
    for i in 1...n { weight[i][i] = 0 }
    
    for i in 1...n {
        for k in 1...n {
            for j in 1...n {
                if weight[k][i] + weight[i][j] < weight[k][j] {
                    weight[k][j] = weight[k][i] + weight[i][j]
                }
            }
        }
    }
    var res = weight[s][a] + weight[s][b]
    for i in 1...n {
        res = min(res, weight[s][i] + weight[i][a] + weight[i][b])
    }
    
    return res
}

// 첫 시도 풀이
func solution2(_ n:Int, _ s:Int, _ a:Int, _ b:Int, _ fares:[[Int]]) -> Int {
    var dict: [Int: [(Int, Int, Int)]] = [:]
    var weight: [Int: [Int : Int]] = [:]
    var edges: Set<[Int]> = []
    
    for item in fares {
        dict[item[0], default: []].append((item[0], item[1], item[2]))
        dict[item[1], default: []].append((item[1], item[0], item[2]))
    }
    
    for i in 1...n { weight[i, default: [:]][i] = 0 }
    
    for i in 1...n {
        var queue = dict[i] ?? []
        var stack: [(Int, Int, Int)] = []
        
        while(!queue.isEmpty) {
            let node = queue.removeLast()
            
            edges.insert([node.0, node.0])
            if edges.contains([node.0, node.1]) || edges.contains([node.1, node.0]) {
                if queue.isEmpty { swap(&queue, &stack) }
                continue
            }
            edges.insert([node.0, node.1])
            edges.insert([node.1, node.0])
            
            weight[i]![node.1] = min(weight[i]?[node.1] ?? Int.max, weight[i]![node.0]! + node.2)
            weight[node.1]![i] = weight[i]![node.1]
            stack += dict[node.1] ?? []
            if queue.isEmpty { swap(&queue, &stack) }
        }
        edges = []
    }
    
    var res = weight[s]![a]! + weight[s]![b]!
    
    var visited = Array(repeating: false, count: n + 1)
    visited[s] = true
    
    var queue = dict[s] ?? []
    visited[s] = true
    while(!queue.isEmpty) {
        let node = queue.removeLast()
        if visited[node.1] { continue }
        visited[node.1] = true
        res = min(res, weight[s]![node.1]! + weight[node.1]![a]! + weight[node.1]![b]!)
        queue += dict[node.1] ?? []
    }
    
    return res
}

