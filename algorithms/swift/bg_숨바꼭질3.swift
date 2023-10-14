import Foundation
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
