import Foundation

// pg_택배 상자
// 구현문제느낌으로 풀었슴니다. 8,9번 케이스에서 시간초과가 나서 엥 했는데
// 똑같이 다시 제출하니까 이번엔 시초가 안나서 통과했습니다.. 왜이런거죠 후우;
// 케이스가 그렇게 많지 않아서 문제 설명대로 풀었슴니다.
func solution(_ order:[Int]) -> Int {
    var res = 0
    var tempBelt: [Int] = []
    
    var boxIdx = 1
    var currentOrderIdx = 0
    
    while(true) {
        if currentOrderIdx == order.count { break }
        
        if boxIdx == order[currentOrderIdx] {
            boxIdx += 1
            currentOrderIdx += 1
            res += 1
        }
        else if tempBelt.count != 0 && tempBelt.last! == order[currentOrderIdx] {
            tempBelt.removeLast()
            currentOrderIdx += 1
            res += 1
        }
        else if tempBelt.count != 0 && order[currentOrderIdx] < tempBelt.last! {
            break
        }
        else {
            while(true) {
                tempBelt.append(boxIdx)
                boxIdx += 1
                
                if order[currentOrderIdx] == boxIdx { break }
            }
        }
    }
    
    return res
}

print(solution([1, 2, 3, 4, 5]))
print(solution([4, 3, 6, 2, 5, 1]))
print(solution([4, 3, 1, 2, 5]))
print(solution([5, 4, 3, 2, 1]))
