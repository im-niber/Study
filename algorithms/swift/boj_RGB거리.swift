// RGB거리, 1149
// 특정한 규칙을 가지고 쭈욱 내려가는 문제였따
// 이전의 값들에서 최솟값을 계속 업데이트해가면서
// 값을 갱신해주면 되는 문제이다. DP를 좀 알고 있으면 간단하지만
// 모른다면 탐색을 시도했지싶다 그렇게 된다면 2^1000 ? 나올둣 ㅎ;
func baek() {
   let N = Int(readLine()!)!
   
   var houses: [[Int]] = []
   
   for i in 0..<N {
       houses.append([])
       houses[i] += readLine()!.split(separator: " ").compactMap { Int($0) }
   }
   
   var dp: [[Int]] = [[houses[0][0], houses[0][1], houses[0][2]]]
   for i in 1..<N {
       dp.append([])
       
       // R G B
       dp[i].append(houses[i][0] + min(dp[i - 1][1], dp[i - 1][2]))
       dp[i].append(houses[i][1] + min(dp[i - 1][0], dp[i - 1][2]))
       dp[i].append(houses[i][2] + min(dp[i - 1][0], dp[i - 1][1]))
   }
   
   print(min(dp[N - 1][0], dp[N - 1][1], dp[N - 1][2]))
}

baek()
