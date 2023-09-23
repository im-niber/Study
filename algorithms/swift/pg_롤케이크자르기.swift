import Foundation

// pg_롤케이크 자르기
// 딕셔너리랑 집합을 사용해서 풀었다 구현문제인둣
func solution(_ topping:[Int]) -> Int {
    var topping = topping
    var count = 0

    var rightToppingCount: Int = 0
    var rightDict: [Int: Int] = [:]

    for item in topping { rightDict[item, default: 0] += 1 }
    for _ in rightDict.keys { rightToppingCount += 1 }

    var toppingSetL: Set<Int> = []

    while(!topping.isEmpty) {
        let item = topping.popLast()!
        toppingSetL.insert(item)
        rightDict[item]! -= 1

        if rightDict[item]! == 0 {
            rightToppingCount -= 1
        }

        if toppingSetL.count == rightToppingCount { count += 1 }
        if toppingSetL.count > rightToppingCount { break }
    }

    return count == 0 ? 0 : count
}

print(solution([1, 2, 1, 3, 1, 4, 1, 2]))
print(solution([1, 2, 3, 1, 4]))
