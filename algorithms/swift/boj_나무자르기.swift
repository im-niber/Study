import Foundation
// boj_2805 나무자르기
// 이분탐색문제에서 가장 대표적인 문제인둣
// 수를 하나 정하고 정답인지 아닌지 체크하는 방법.
// 좀 어려운 문제는 결정문제로 만들어두고, 이분탐색을 활용하면 풀리는 문제들도있다
func baek() {
    let NM = readLine()!.split(separator: " ").compactMap { Int($0) }
    let M = NM[1]
    let trees = readLine()!.split(separator: " ").compactMap { Int($0) }
    
    var start = 0
    var end = 2000000000
    var ans = 0
    
    while start != end {
        let mid = (start + end) / 2
        var sum = 0
        
        trees.forEach { tree in
            sum += tree > mid ? tree - mid : 0
        }
        
        if M <= sum {
            ans = mid
            start = mid + 1
        }
        
        else {
            end = mid
        }
    }
    
    print(ans)
}

baek()
