import Foundation

// BOJ_1780, 종이의 개수
// 재귀 문제
// N*N 행렬, 모든 같은 수면 그냥 사용.
// 아니라면 같은크기의 종이 9개로 자르는 재귀, 분할문제
// 분할을 어떻게할지 고민하다가 좀 오래 걸렸다.
// 배열 슬라이싱을 사용해서 해결하였다.
func baek1780() {
    let N = Int(readLine()!)!
    var map: [[Int]] = []
    
    for _ in 0..<N {
        map.append(readLine()!.split(separator: " ").compactMap { Int($0) })
    }
    
    var result = [0, 0, 0]
    
    func recur(_ map: [[Int]]) {
        let chk = map[0][0]
        
        if map.count == 1 { result[chk + 1] += 1; return }
        
        for i in 0..<map.count {
            for k in 0..<map[0].count {
                if chk == map[i][k] { continue }
                
                else {
                    var map1: [[Int]] = []
                    var map2: [[Int]] = []
                    var map3: [[Int]] = []
                    
                    let n3 = map.count / 3
                    
                    for i in 0..<3 {
                        for k in 0..<n3 {
                            map1.append(Array(map[i * n3..<n3 * (i + 1)][i*n3 + k][0..<n3]))
                            map2.append(Array(map[i * n3..<n3 * (i + 1)][i*n3 + k][n3..<n3 * 2]))
                            map3.append(Array(map[i * n3..<n3 * (i + 1)][i*n3 + k][n3 * 2..<n3 * 3]))
                        }
                        recur(map1); recur(map2); recur(map3);
                        map1 = []; map2 = []; map3 = []
                    }
                    
                    return
                }
            }
        }
        
        result[chk + 1] += 1
    }
    
    recur(map)
    for item in result {
        print(item)
    }
}
baek1780()
