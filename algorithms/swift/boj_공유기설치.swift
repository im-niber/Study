// boj_공유기설치
// 이분탐색을 어떻게 할 지 고민하다가 오래 걸린문제
// 거리를 mid로 정하고, 얘가 가능한지 공유기를 n 반복으로 설치하면 되는 문제였다
func baek() {
    let NC = readLine()!.split(separator: " ").compactMap{ Int($0) }
    
    var houses: [Int] = []
    
    for _ in 0..<NC[0] {
        let house = Int(readLine()!)!
        houses.append(house)
    }
    houses.sort()
    
    var ans = 0
    var start = 0
    var end = houses[NC[0] - 1] - houses[0]
    
    while start != end {
        let mid = (start + end + 1) / 2
        
        var cnt = 1
        var prev = houses[0]
        
        for i in 1..<NC[0] {
            if houses[i] - prev >= mid {
                cnt += 1
                prev = houses[i]
            }
        }
        
        if cnt >= NC[1] {
            ans = max(mid, ans)
            start = mid
        }
        else { end = mid - 1 }
    }
    
    print(ans)
}

baek()
