import Foundation

// pg_점찍기
// 원의 방정식을 생각해서 최대값을 구한다음에 구현해서 풀면 된다
func solution(_ k:Int, _ d:Int) -> Int64 {
    var result: Int64 = 0
    var i = 0
    
    while(true) {
        if i > d { break }
        let count = 1 + Int64(sqrt(Double(d * d) - Double(i * i)) / Double(k))
        result += count
        i += k
    }
    
    return result
}
