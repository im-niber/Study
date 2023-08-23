import Foundation

// pg_카펫
// 살짝 수학문제? 테두리에만 갈색이 있어야하므로 yellow 쪽 사각형은 x-2 y-2 형태가 된다
// 그러면 좀 더 수식을 풀어보면 xy = yellow + brown, 2x + 2y = 4 + brown
// 식이 나오는데 얘네들을 만족하는 값이 나올때까지 반복해서 풀었다
func solution(_ brown:Int, _ yellow:Int) -> [Int] {
    var res: [Int] = []
    let xy = brown + yellow
    let xPlusy = 2 + Int(brown / 2)
    
    var y = 1
    var x = Int.max
    
    repeat {
        x = xPlusy - y
        if (x * y == xy) { break }
        y += 1
    } while(x >= y)
    
    res.append(x)
    res.append(y)
    
    return res
}

print(solution(10, 2))
print(solution(8, 1))
print(solution(24, 24))
