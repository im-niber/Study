import Foundation

// pg_우박수열 정적분
// 지문읽는거에 시간을 좀 쓴 문제;
// 정적분 범위가 넘어가면 -1.0을 대입하고 넘어가면 되는데
// 이걸 못봐서 좀 걸렸다. 나머지는 문제대로 함수 구현하고
// 간격 나오면 다 더해서 배열에 넣어주면 되는 간단한 문제였다
func solution(_ k:Int, _ ranges:[[Int]]) -> [Double] {
    var answer: [Double] = []
    var arr: [(Int, Int)] = [(0, k)]
    
    func collatz(_ k: Int, _ i: Int = 1) {
        var k = k
        
        if k % 2 == 0 {
            k /= 2
            arr.append((i, k))
        }
        else {
            k = k * 3 + 1
            arr.append((i, k))
        }
        
        if k > 1 { collatz(k, i + 1) }
        else { return }
    }
    
    collatz(k)
    
    var n = arr.count - 1
    
    for item in ranges {
        let a = item[0]
        let b = n + item[1]
        
        if a > b { answer.append(-1.0) }
        else if a == b { answer.append(0.0) }
        else {
            var total = 0.0
            for i in a..<b {
                total += Double(arr[i].1 + arr[i + 1].1) / 2.0
            }
            answer.append(total)
        }
    }
    
    return answer
}
