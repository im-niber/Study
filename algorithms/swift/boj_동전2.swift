/*
 boj 동전2, 2294
 적당히 동전을 여러개 사용하여서 k를 만들수 있는가
 dp 문제인걸 먼저 알고 시도해서, 사고가 어떻게 이전 값들을 사용할까로 고정되었긴해서
 담부턴 카테고리를 꺼야하나 싶기도함. 여튼 이전 값들을 어떤 식으로 업데이트할지 고민하다가
 잘 떠오르지 않아서 최대 약수로 시도했다가 결국 이건 전부 다 돌아야겠다 싶어서
 이중반복문을 사용하였다. k가 최대 1만이라서 가능해쓰
 다른 풀이 보면 coin 값들로 반복을 시도해서 좀 더 시간을 줄여서 푸는 방식도 있었다 ~
 */
func baek() {
    let input = readLine()!.split(separator: " ").compactMap { Int($0) }
    let n = input[0], k = input[1]
    let maxValue = 10001
    
    var dp: [Int] = Array(repeating: maxValue, count: 10001)
    
    for _ in 0..<n {
        let coin = Int(readLine()!)!
        if coin >= maxValue { continue }
        dp[coin] = 1
    }
    
    for i in 2..<maxValue {
        for j in 1..<i {
            dp[i] = min((dp[i - j] + dp[j]), dp[i])
        }
    }
    
    if dp[k] < maxValue { print(dp[k]); return }
    else { print(-1) }
}

baek()
