import Foundation

// pg_과일장수
// 간단한 정렬문제 내림차순으로 정렬후
// 맨 마지막 값들로 판단하여 해결하였다
func solution(_ k:Int, _ m:Int, _ score:[Int]) -> Int {
    let score = score.sorted(by: >)
    
    var res = 0
    var start = m - 1
    
    while(start < score.count) {
        res += score[start] * m
        start += m
    }
    
    return res
}

print(solution(3, 4, [1, 2, 3, 1, 2, 3, 1]))
print(solution(4, 3, [4, 1, 2, 2, 4, 4, 4, 4, 1, 2, 4, 2]))
