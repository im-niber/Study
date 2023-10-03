import Foundation

// pg_행렬의 곱셈
// 행렬의 곱셈을 구현하는 문제여씀
func solution(_ arr1:[[Int]], _ arr2:[[Int]]) -> [[Int]] {
    var res: [[Int]] = Array(repeating: Array(repeating: 0, count: arr2.first?.count ?? 0), count: arr1.count)
    
    for i in 0..<arr1.count {
        for k in 0..<arr1[i].count {
            for j in 0..<arr2[k].count {
                res[i][j] += arr1[i][k] * arr2[k][j]
            }
        }
    }
    
    return res
}
