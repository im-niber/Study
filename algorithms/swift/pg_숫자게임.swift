import Foundation

// pg_숫자게임
// A의 숫자보다 큰걸 찾자라는 생각으로 이분탐색이 생각나서
// 연습도할겸 해봤는데 방문처리하고 방문했으면 앞으로 나아가는식으로 풀어서
// 시초 걱정을 좀 했는데 다행히 통과해쓰
// 다른사람풀이보니 근데 이분탐색은 굳이,, 안 써도 풀리는듯 ㅎㅋㅋ lv3라 어렵게생각했다 후;
// 단순히 b에서 a보다 큰게 몇개인지만 봐도 되기때문에,,
func solution(_ a:[Int], _ b:[Int]) -> Int {
    var cnt = 0
    let b = b.sorted()

    var visited: [Bool] = Array(repeating: false, count: b.count)

    func search(_ target: Int) {
        var start = 0
        var end = b.count

        while (start < end) {
            let mid = (start + end) / 2

            if b[mid] <= target {
               start = mid + 1
           } else {
               end = mid
           }
        }

        if end == b.count || start == b.count { return }

        if visited[end] {
            for i in end..<b.count {
                if !visited[i] && b[i] > target {
                    cnt += 1
                    visited[i] = true
                    break
                }
            }
            return
        }

        if b[end] < target { return }

        cnt += 1
        visited[end] = true
    }

    for item in a { search(item) }

    return cnt
}

func solution2(_ a:[Int], _ b:[Int]) -> Int {

    let sA = a.sorted()
    let sB = b.sorted()
    var index = 0

    for e in sB {
        if e > sA[index] {
            index += 1
        }
    }

    return index
}
