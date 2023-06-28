import Foundation

// 안 가본 길을 탐색하는 문제이다
// 처음엔 처음간 지점을 집합에 넣었는데 멍청했으 지점은 중복이 될 수 있다~
// 경로를 집합에 넣으면 해결된다

func solution(_ dirs:String) -> Int {
    var current: (Int, Int) = (0, 0)
    var route: Set<[Int]> = []
    
    func verify(point: (Int, Int)) -> Bool {
        point.0 <= 5 && point.0 >= -5 && point.1 <= 5 && point.1 >= -5
    }
    
    func move(str: Character, before: (Int, Int)) {
        switch str {
        case "U":
            current.1 += 1
            if !verify(point: current) {
                current.1 -= 1
                return
            }
        case "D":
            current.1 -= 1
            if !verify(point: current) {
                current.1 += 1
                return
            }
        case "L":
            current.0 -= 1
            if !verify(point: current) {
                current.0 += 1
                return
            }
        case "R":
            current.0 += 1
            if !verify(point: current) {
                current.0 -= 1
                return
            }
        default: print("str error")
    }
        
        if route.contains([current.0, current.1, before.0, before.1]) {
            return
        }
        route.insert([before.0, before.1 ,current.0, current.1])
    }
    
    for char in dirs {
        move(str: char, before: current)
    }
    
    return route.count
}
