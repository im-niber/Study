import Foundation

// 다시 풀어볼일이 생겨서 다시 푼 풀이
// 1번. time을 튜플에 같이 담아서 한 풀이 + 2배로 간 위치를 맨앞에 안 두고 한 풀이
// 이래도 정답이 나오긴함 오히려 더 빠름 범위설정이 되어 있어서 그런걸로 추츸함
func baek() {
    let input = readLine()!.split(separator: " ").compactMap { Int($0) }
    let n = input[0], k = input[1]
    var ans = Int.max
    var visited: [Bool] = Array(repeating: false, count: 200001)
    
    var queue: [(v: Int, t: Int)] = []
    queue.append((0, n))
    
    while !queue.isEmpty {
        let (t, node) = queue.removeFirst()
        if node == k { ans = min(t, ans); break }

        if node*2 < 200001 {
            if !visited[2*node] {
                visited[2*node] = true
                queue.append((t, node*2))
            }
        }
        
        if node - 1 >= 0 {
            if !visited[node - 1] {
                visited[node - 1] = true
                queue.append((t + 1, node - 1))
            }
        }
        
        if node + 1 < 200001 {
            if !visited[node + 1] {
                visited[node + 1] = true
                queue.append((t + 1, node + 1))
            }
        }
    }
    print(ans)
}

baek()

// 2번
// visited 배열에 시간을 담은 풀이 위의 풀이보다 빠름
// 튜플형태로 append 하지 않고, 2배로 간 길이를 맨 앞에 넣어줘서 그런듯함
func baek() {
    let input = readLine()!.split(separator: " ").compactMap { Int($0) }
    let n = input[0], k = input[1]
    var visited: [Int] = Array(repeating: -1, count: 200001)
    visited[n] = 0
    var queue: [Int] = []
    queue.append(n)
    
    while !queue.isEmpty {
        let node = queue.removeFirst()
        if node == k { print(visited[node]); return }
        
        if node*2 < 200001 {
            if visited[2*node] == -1 {
                visited[2*node] = visited[node]
                queue.insert(node*2, at: 0)
            }
        }
        
        if node - 1 >= 0 {
            if visited[node - 1] == -1 {
                visited[node - 1] = visited[node] + 1
                queue.append(node - 1)
            }
        }
        
        if node + 1 < 200001 {
            if visited[node + 1] == -1 {
                visited[node + 1] = visited[node] + 1
                queue.append(node + 1)
            }
        }
        
    }
}

baek()



// 백준_숨바꼭질3
// 순간이동의경우를 먼저 체크하여 큐 앞에 두고
// 다음 탐색때 얘를 먼저쓰면서 풀어나가믄댄다
var intInputArray: [Int] = []
func setInput() {
    guard let input = readLine() else { return }
    let inputArray: [String] = input.components(separatedBy: " ")
    intInputArray = inputArray.compactMap { Int($0) }
}
setInput()
let N = intInputArray[0]; let K = intInputArray[1]
var arr: [Int] = Array(repeating: Int.max, count: 200001)
arr[N] = 0
var queue: [Int] = [N]
while(true) {
    let item = queue.removeFirst()
    let warp = item * 2
    
    if item == K { return arr[K] }
    
    if warp < 200001 && arr[warp] > arr[item] {
        arr[warp] = arr[item]
        queue.insert(warp, at: 0)
    }
    
    let minus = item - 1, plus = item + 1;
    
    if minus > 0 && arr[minus] > arr[item] + 1 {
        arr[minus] = arr[item] + 1
        queue.append(minus)
    }
    
    if plus < 200001 && arr[plus] > arr[item] + 1 {
        arr[plus] = arr[item] + 1
        queue.append(plus)
    }
}
return arr[K]
