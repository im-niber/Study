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
