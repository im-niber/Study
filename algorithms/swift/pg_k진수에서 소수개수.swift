import Foundation

// pg_k진수에서 소수 개수 구하기
// 조건 4가지를 만족하는 숫자가 소수인지 아닌지 판단하는 문제이다
// 진수변환, 소수판별을 빠르게 만든다면 금방풀리는 문제인둣
func solution(_ n:Int, _ k:Int) -> Int {
    var ans = 0
    let radixN = Array(String(n,radix: k))
    
    func isPrime(n: Int) -> Bool {
        if n < 2 { return false }
        
        for i in 2..<Int(sqrt(Double(n)) + 1) {
            if n % i == 0 { return false }
        }
        return true
    }
    
    var temp = ""
    
    for i in 0..<radixN.count {
        if radixN[i] != "0" {
            temp += String(radixN[i])
        }
        else {
            if isPrime(n: Int(temp) ?? 0) { ans += 1 }
            temp = ""
        }
    }
    
    isPrime(n: Int(temp) ?? 0) ? ans += 1 : ()
    return ans
}

print(solution(437674, 3)) // 211020101011
print(solution(110011, 10))
