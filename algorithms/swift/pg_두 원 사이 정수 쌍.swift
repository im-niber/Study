// pg_두 원 사이의 정수 쌍
// 정답률이 낮아서 그런지 풀이가 더 이상해져쓰
// 단순 반복으로 y값을 찾아서 하나 빼주는 식으로
// 풀면 되겠다라고 생각했느데 뭔가 다르게 풀어야하나 생각이 들어서
// 헤매버렸으.. 결국은 위에 적힌대로 풀었다
func solution(_ r1:Int, _ r2:Int) -> Int64 {
    
    var res: Int64 = 0
    
    var y1 = r1 - 1
    var y2 = r2 - 1
    
    func check(x: Int, y: Int, r: Int) -> Bool { ((x * x) + (y * y)) <= r * r }
    
    for i in 1..<r2 {
        
        if !check(x: i, y: y1, r: r1) {
            for _ in stride(from: y1 - 1, through: 0, by: -1) {
                y1 -= 1
                if check(x: i, y: y1, r: r1) { break }
            }
        }
        
        if !check(x: i, y: y2, r: r2) {
            for _ in stride(from: y2 - 1, through: 0, by: -1) {
                y2 -= 1
                if check(x: i, y: y2, r: r2) { break }
            }
        }
        
        res += Int64(y2 - y1)
        
        // r1 원 위의 있는 점 처리, ex) r = 5 (3,4)의 경우
        if i != r1 && ((i * i) + (y1 * y1)) == r1 * r1 { res += 1 }
    }

    res *= 4
    res += Int64((r2 - r1 + 1) * 4)
    
    return res
}

// 요건 다른 분의 제곱근 풀이
// 좋았던 점은 정수형으로 변환을 해버리면 소수점을 날리고, 축 하나만 체크해서 아예 전부
// 마지막에 *4를 하면 답이 나오기 때문에 풀이가 깔끔한거 같다
func a(_ n: Int) -> Int64 { return Int64(sqrt(Double(n))) }

func solution(_ r1:Int, _ r2:Int) -> Int64 {

    var temp: Int64 = 0

    for x in 0..<r2 {
        if x < r1 {
            let y2 = r1 * r1 - x * x
            let b = a(y2)
            temp -= b
            if b * b == y2 { temp += 1 }
        }
        temp += a(r2 * r2 - x * x)
    }

    return temp * 4
}
