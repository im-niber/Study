import Foundation

// boj_15661 링크와 스타트
// 이전에 비슷한 문제를 풀었는데, 조건이 좀 바뀐 문제였다
// 팀 인원을 동일하게 안하는 조건이라 모든 케이스를 넣고 반복을 더 해주었더니 풀렸따
func baek() {
    let N = Int(readLine()!)!
    
    var people: [[Int]] = []
    var numbers: [Int] = []
    var ans = Int.max
    
    for i in 0..<N {
        let input = readLine()!.split(separator: " ").compactMap { Int($0) }
        numbers.append(i)
        people.append(input)
    }
    
    func sumValue(arr: [Int]) -> Int {
        var temp = 0
        
        for item in arr {
            for item2 in arr {
                if item == item2 { continue }
                temp += people[item][item2]
            }
        }
        
        return temp
    }
    
    func combi(n: Int, arr: [Int], cnt: Int) {
        if cnt == arr.count {
           ans = min(ans, abs(sumValue(arr: arr) - sumValue(arr: numbers.filter { !arr.contains($0) })))
           return
       }
       
       else {
           for i in n + 1..<N {
               combi(n: i, arr: arr + [i], cnt: cnt)
           }
       }
    }
      
    for i in 2..<N - 1 {
        combi(n: 0, arr: [0], cnt: i)
    }
    
    print(ans)
}

baek()
