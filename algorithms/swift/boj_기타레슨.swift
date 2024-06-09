// boj 기타레슨
// 이분탐색 문제인데 좀 걸렸다
// 문제를 잘못읽어버려서,,,,
// 주어진 강의가 다 정렬되어있는줄알았는데
// 매우 큰 착각이였따 후ㅜㅜㅜㅜㅡㅜㅜ
func baek() {
    let NM = readLine()!.split(separator: " ").compactMap { Int($0) }
    let M = NM[1]
    let lectures = readLine()!.split(separator: " ").compactMap { Int($0) }
    
    var start = 1
    var end = 10000 * 100000
    var ans = Int.max
    
    let maxMin = lectures.max()!
    
    while start != end {
        let mid = (start + end) / 2
        
        var cnt = 1
        var sum = 0
        
        for lecture in lectures {
            
            if sum + lecture > mid {
                sum = lecture
                cnt += 1
            }
            else {
                sum += lecture
            }
        }
        
        if cnt > M { start = mid + 1 }
          
        else {
            if maxMin <= mid {
                ans = min(ans, mid)
                end = mid
            }
            
            else {
                start = mid + 1
            }
        }
    }
    
    print(ans)
}

baek()
