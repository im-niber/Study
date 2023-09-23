import Foundation

// pg_H-index
// 정렬해서 h의 최댓값을 구하는 문제, 시초가 안나서 이중반복문으로 풀었는데
// 다른 사람 풀이를 보니 하나로도 해결이 된다..
func solution(_ citations:[Int]) -> Int {
    let citations = citations.sorted(by: <)
    var h: Int = 0
    
    for i in 0...1000 {
        var count = 0
        
        for k in 0..<citations.count {
            if i <= citations[k] {
                count += 1
            }
            
            if count >= i {
                h = i
                break
            }
        }
    }
    // 다른 풀이, h번 이상의 인용횟수가 h개 있어야 하므로
    // 내림차순으로 배열을 만든 후에 개수를 체크하면 된다
    let citations2 = citations.sorted(by: >)
    var result = 0
    for i in 0..<citations.count {
        if i + 1 <= citations[i] {
            result = i + 1
        }
        else { break }
        
    }
    
    return h
}

print(solution([3, 0, 6, 1, 5]))
print(solution([1,2,3,3,5,5,6,7]))

