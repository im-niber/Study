import Foundation

// pg_키패드 누르기
// 구현 문제. 키패드를 어느 손으로 누르는지를 담는 문자열을 반환해야한다.
// 손들의 현재 위치에서 거리계산을 하여 같은 경우에 판단만 하면 해결되는 문제임니당
func solution(_ numbers:[Int], _ hand:String) -> String {
    let keypad = [(3,1),(0,0),(0,1),(0,2),(1,0),(1,1),(1,2),(2,0),(2,1),(2,2)]
    
    var left = (3, 0)
    var right = (3, 2)
    var res = ""
    
    func distance(to: (Int, Int), from: (Int,Int)) -> Int {
        abs(to.0 - from.0) + abs(to.1 - from.1)
    }
    
    for item in numbers {
        switch item {
        case 1, 4, 7:
            left = keypad[item]
            res += "L"
        case 3, 6, 9:
            right = keypad[item]
            res += "R"
        default:
            if distance(to: left, from: keypad[item]) < distance(to: right, from: keypad[item]) {
                left = keypad[item]
                res += "L"
            } else if distance(to: left, from: keypad[item]) > distance(to: right, from: keypad[item]) {
                right = keypad[item]
                res += "R"
            } else {
                if hand.first!.uppercased() == "L" { left = keypad[item] }
                else { right = keypad[item] }
                res += hand.first!.uppercased()
            }
        }
    }
    
    return res
}

print(solution([1, 3, 4, 5, 8, 2, 1, 4, 5, 9, 5], "right"))
print(solution([7, 0, 8, 2, 8, 3, 1, 5, 7, 6, 2], "left"))
print(solution([1, 2, 3, 4, 5, 6, 7, 8, 9, 0], "right"))
