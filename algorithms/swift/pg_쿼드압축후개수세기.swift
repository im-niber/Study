import Foundation

// pg_쿼드압축 후 개수 세기
// 0과 1로 이루어진 2차원 배열을 압축시키는 문제
// count의 절반으로 구역을 나누고 0이나 1만 있다면 해당 부분은 해당 숫자로 합쳐버림
// 2*2 수준까지 내려오면 내부 값이 다른게 하나라도 있다면 다 더해주어씀
// 구역을 나눈 행렬을 인자로 주었는데 좌표로 주었다면 더 효율적인 풀이였을거같음
func solution(_ arr:[[Int]]) -> [Int] {
    var res = [0, 0]
    
    func compress(_ array: [[Int]]) {
        var flag = true
        for i in 0..<array.count {
            for k in 0..<array[i].count {
                if array[0][0] != array[i][k] {
                    flag = false
                }
            }
            if !flag { break }
        }
        
        if flag {
            res[array[0][0]] += 1
            return
        }
        else {
            if array.count == 2 {
                for i in 0..<array.count {
                    for k in 0..<array.count {
                        res[array[i][k]] += 1
                    }
                }
                return
            }
            var arr1: [[Int]] = [], arr2: [[Int]] = []
            for i in 0..<array.count / 2 {
                arr1.append(Array(array[i][0..<array.count / 2]))
                arr2.append(Array(array[i][array.count / 2..<array.count]))
            }
            compress(arr1)
            compress(arr2)
            arr1 = []; arr2 = []
            
            for i in array.count / 2..<array.count {
                arr1.append(Array(array[i][0..<array.count / 2]))
                arr2.append(Array(array[i][array.count / 2..<array.count]))
            }
            
            compress(arr1)
            compress(arr2)
        }
    }
    compress(arr)
    return res
}
