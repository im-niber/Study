import Foundation

// pg_땅따먹기
// dp문제 인듯하다 맨 위의 값들을 먼저 넣어주고
// 다음 열의 값을 고를때 max 값을 찾아서 넣어주었다
func solution(_ land:[[Int]]) -> Int{
    var answer = 0
    var table: [[Int]] = Array(repeating: Array(repeating: 0, count: 4), count: land.count)
    
    table[0][0] = land[0][0]; table[0][1] = land[0][1]; table[0][2] = land[0][2]; table[0][3] = land[0][3];

    for i in 1..<land.count {
        for k in 0..<4 {
            var value = 0
            
            for j in 0..<4 {
                if k == j { continue }
                value = max(table[i - 1][j], value)
            }
            
            table[i][k] = value + land[i][k]
        }
    }
    answer = table.map { $0.max()! }.max()!
    return answer
}

print(solution([[1,2,3,5],[5,6,7,8],[4,3,2,1]]))
