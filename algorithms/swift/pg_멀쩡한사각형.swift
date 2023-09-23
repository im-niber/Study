import Foundation

// pg_멀쩡한 사각형
// 최대공약수를 찾아서 규칙에 따라서 계산을 해주는 문제
// 전체 정사각형 개수 w*h에서 지나가는 정사각형의 개수를 빼주면 된다.
func solution(_ w:Int, _ h:Int) -> Int64{
    func gcd(a: Int, b: Int) -> Int {
        return a % b == 0 ? b : gcd(a: b, b: a % b)
    }
    
    return Int64(w * h - (w + h - gcd(a: w, b: h)))
}

print(solution(8, 12))
print(solution(2, 3))
print(solution(3, 5))
