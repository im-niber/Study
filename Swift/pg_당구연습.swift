import Foundation

// 직선인 경우에 계산 값이 너무 작아서 계속 틀렸다 후우,,
// 간단한 문제는 좀 더 간단하게 생각하는게 필요할둣
func solution(_ m:Int, _ n:Int, _ startX:Int, _ startY:Int, _ balls:[[Int]]) -> [Int] {
    
    // 거리계산
    func distance(x: Double, y: Double, a: Double, b: Double) -> Double {
        return pow(abs(x - a), 2) + pow(abs(y - b), 2)
    }

    var answer: [Int] = []
    
    var m = Double(m), n = Double(n)
    var x = Double(startX), y = Double(startY)
    
    for item in balls {
        var value: Int = Int.max
        var a = Double(item[0]), b = Double(item[1])
        
        // 입사각과 반사각이 같다면 점을 x,y축에 대칭을해서 풀어도 가능
        // 위아래 벽
        if a != x {
            var newB = b + (n - b) * 2
            value = min(value, Int(distance(x: x, y: y, a: a, b: newB)))

            newB = -1 * b
            value = min(value, Int(distance(x: x, y: y, a: a, b: newB)))
        }
        // 옆 벽
        if b != y {
            var newA = a + (m - a) * 2
            value = min(value, Int(distance(x: x, y: y, a: newA, b: b)))
            
            newA = -1 * a
            value = min(value, Int(distance(x: x, y: y, a: newA, b: b)))
        }
        
        // y축 수평
        if a == x {
            if b > y {
                var one = sqrt(distance(x: a, y: 0, a: a, b: b))
                var two = sqrt(distance(x: a, y: 0, a: a, b: y))
                
                value = min(value, Int(pow(one + two, 2)))
            }
            else {
                var one = sqrt(distance(x: a, y: n, a: x, b: y))
                var two = sqrt(distance(x: a, y: n, a: a, b: b))
                
                value = min(value, Int(pow(one + two, 2)))
            }
        }
        
        // x축 수평
        else if b == y {
            if a > x {
                var one = sqrt(distance(x: 0, y: b, a: x, b: b))
                var two = sqrt(distance(x: 0, y: b, a: a, b: b))
                
                value = min(value, Int(pow(one + two, 2)))
                
            }
            else {
                var one = sqrt(distance(x: m, y: b, a: x, b: b))
                var two = sqrt(distance(x: m, y: b, a: a, b: b))
                
                value = min(value, Int(pow(one + two, 2)))
            }
        }
        answer.append(value)
    }
    
    return answer
}
