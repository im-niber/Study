import Foundation

// 회전초밥, 2531
// 문제 설명이 좀 난잡한감이 있지만 결국은
// 하나의 인덱스부터 연속된 k 까지 담고 해당 가짓수를 업데이트 하면서 최댓값을 구하는 문제였따
// 처음엔 배열로 다 담고 k 개만큼 담았으면 집합으로 만들어서 중복을 제거했는데
// 요러니까 시초나서 집합으로 애초에 접근을 했다
// 집합을 사용해서 초밥들을 넣으려면 나중에 제거할 때
// 중복인걸 따로 또 체크해줘야하므로 같은 초밥 몇 개를 담은지
// 체크하는 배열도 하나 따로 만들어서 주었다
func baek() {
    let input = readLine()!.split(separator: " ").compactMap{ Int($0) }
    let N = input[0], d = input[1], k = input[2], c = input[3]
    
    var sushi: [Int] = []
    var dish: Set<Int> = []
    var sushiCounts: [Int] = Array(repeating: 0, count: d + 1)
    
    var ans = 0
    
    for _ in 0..<N { sushi.append(Int(readLine()!)!) }
    
    var l = 0
    var r = k
    
    for i in 0..<r { dish.insert(sushi[i]); sushiCounts[sushi[i]] += 1 }
    
    while l != sushi.count {
        dish.insert(c)
        ans = max(ans, dish.count)
        
        if sushiCounts[sushi[l]] == 1 { dish.remove(sushi[l]) }
        
        sushiCounts[sushi[l]] -= 1
        
        l += 1
        dish.insert(sushi[r])
        sushiCounts[sushi[r]] += 1
        r = (r + 1) % N
    }
    
    print(ans)
}

baek()
