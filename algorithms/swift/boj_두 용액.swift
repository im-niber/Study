// 두 용액, 2470
// 투포인터 문제, 하나를 잡고 다른 수 하나 더해서 0이랑
// 최대한 가까운 숫자를 찾는 문제라서 이분탐색으로도 풀 수 있다
// 먼저 정렬을 시킨다음에 젤 작은, 젤 큰 값 기준으로 포인터들을 잡아서
// 비교를 계속 진행해주었다. 값이 0 보다 크면 오른쪽에서 감소해야 값이 작아지므로 그렇게 진행하고
// 0 보다 작으면 왼쪽에서 +1을 해주면서 점점 탐색을 끝내가는 방식이라서
// 틀린거 같지가 않은데 계속 틀렸다길래 왤까 하다가
// 배열을 print 하고 있었다는걸 깨달았다.. 출력형식 잘 확인..하자
func baek() {
   let _ = Int(readLine()!)!
   var arr = readLine()!.split(separator: " ").compactMap { Int($0) }
   arr.sort()
   
   var l = 0
   var r = arr.count - 1
   
   var sum = arr[l] + arr[r]
   var closeZero = arr[l] + arr[r]
   
   var ans = [arr[l], arr[r]]
   
   while l != r {
       if sum > 0 {
           r -= 1
           
           if arr[l] != arr[r] && abs(closeZero) > abs(arr[l] + arr[r]) {
               ans[0] = arr[l]
               ans[1] = arr[r]
               
               closeZero = arr[l] + arr[r]
           }
       }
       
       else {
           l += 1
           
           if arr[l] != arr[r] && abs(closeZero) > abs(arr[l] + arr[r]) {
               ans[0] = arr[l]
               ans[1] = arr[r]
               
               closeZero = arr[l] + arr[r]
           }
       }
       
       sum = arr[l] + arr[r]
   }
   
   ans.sort()
   print(ans[0], ans[1])
}

baek()
