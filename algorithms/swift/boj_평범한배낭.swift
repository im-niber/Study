/*
 boj 12865 평범한배낭
 dp 문제, 2차원 배열을 사용해서 풀면 간단히 풀리는문제,,
 좀 어려워서 풀이를 참고해서 풀었다,, 좀 더 효율적으로 하려면
 아이템 끼리 무게의 차이로만 반복을 시도하면 될듯함.
 1차원 배열의 풀이도 있는거같아서 좀 더 공부해야할둣..
 */
func baek() {
    let input = readLine()!.split(separator: " ").compactMap { Int($0) }
    let n = input[0], k = input[1]
    let maxVal = 100001
    
    var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: maxVal), count: 101)
    var items: [(Int, Int)] = []
    items.append((0,0))
    for _ in 0..<n {
        let inp = readLine()!.split(separator: " ").compactMap { Int($0) }
        let w = inp[0], v = inp[1]
        items.append((w, v))
    }
    
    for i in 1...n {
        
        for j in 1...k {
            if j - items[i].0 >= 0 { dp[i][j] = max(dp[i-1][j], dp[i - 1][j - items[i].0] + items[i].1) }
            else { dp[i][j] = dp[i - 1][j] }
        }
        
    }
    
    
    print(dp[n][k])
}

baek()

/*
 2차원 배열을 사용하지 않은 풀이.
 DP 풀이에서 다음 n 위치의 값을 결정할 때 n-1만 보고 판단해도 괜찮은 경우에
 1차원 배열로 효율적으로 구성할 수 있다.
 대신 이번 문제에서는 맨 뒤에서부터 시작을 해야함.
 이유로는 맨 앞에서부터 시작하게 된다면, 값을 갱신한 항목이 생기는데
 이걸로 다음 값을 또 판별해버리면 이전 값을 보고 판단하는것이 아니게 되므로 틀리게된다
 */
func baek() {
    let nk = readLine()!.split(separator: " ").map { Int($0)! }
    let (n, k) = (nk[0], nk[1])
    var dp = [Int](repeating: 0, count: k+1)
    
    for _ in 0..<n {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        let (w, v) = (input[0], input[1])
        
        if w > k { continue }
        
        for j in stride(from: k, through: 0, by: -1) {
            if j + w <= k, dp[j] != 0 {
                dp[j+w] = max(dp[j+w], dp[j] + v)
            }
        }
        dp[w] = max(dp[w], v)
    }
    print(dp.max()!)
}

baek()
