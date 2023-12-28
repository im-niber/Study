import Foundation

// pg_연속 부분 수열의 합의 개수
// 연속된 부분 수열의 합이 몇 가지가 나오는가 를 구하는 문제
// 범위가 1000이라 n^2으로도 풀려서 그렇게 풀었다
// 범위가 매우 큰 경우는 DP를 조금 활용해서 풀면 풀린다고 한다
func solution(_ elements:[Int]) -> Int {
    var numSet: Set<Int> = []
    
    for i in 0..<elements.count {
        var cnt = 0
        var value = 0
        
        while cnt != elements.count {
            let idx = (i + cnt) % elements.count
            
            value += elements[idx]
            numSet.insert(value)
            cnt += 1
        }
    }
    
    return numSet.count
}

print(solution([7,9,1,1,4])) // 18
print(solution([1,2,3]))
