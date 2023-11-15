import Foundation

// pg_숫자 카드 나누기
// 배열 하나의 최대공약수를 구하고, 배열B에서 안 나눠지는지를 판별하는 문제였따
// gcd를 사용하는 문제라서 미리 알아두면 금방푸는 문제인둣
func solution(_ arrayA:[Int], _ arrayB:[Int]) -> Int {
    var ans = 0
    let arrayA = arrayA.sorted(by: <), arrayB = arrayB.sorted(by: <)
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        if b == 0 { return a } else {
            return gcd(b, a % b)
        }
    }
    
    func sol(arrayA: [Int], arrayB: [Int]) {
        var arrayA = arrayA
        var temp = arrayA.removeFirst()
        
        for item in arrayA {
            temp = gcd(temp, item)
        }
        
        if temp <= 1 { return }
            
        for itemB in arrayB {
            if itemB % temp == 0 { return }
        }
    
        ans = max(ans, temp)
    
    }
    
    sol(arrayA: arrayA, arrayB: arrayB)
    sol(arrayA: arrayB, arrayB: arrayA)
    
    return ans
}
