import Foundation

// pg_N개의 최소공배수
// 최대공약수, 최소공배수 수학문제였다
// 크게 어려운 부분은 없었던문제
func solution(_ arr:[Int]) -> Int {
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        
        if b == 0 { return a }
        else { return gcd(b, a % b) }
    }
    
    var arr = arr
    var nowNum = 0
    
    while arr.count != 1 {
        nowNum = arr.removeFirst()
        let mul = gcd(nowNum, arr[0])
        nowNum = mul * (nowNum / mul) * (arr[0] / mul)
        arr[0] = nowNum
    }
    
    return nowNum
}
