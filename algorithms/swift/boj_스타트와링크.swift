// boj_14889 스타트링크
// 완전탐색문제. N의 범위가 작은편이라 모든 경우의수를 봐도 시초는 나지않는다
// 되게 오랜만에 경우의수 함수를 짜봤는데 조금 헷갈렸다,,
// 계산하는 부분은 따로 함수로 만들어서 진행함
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
    
    func combi(n: Int, arr: [Int]) {
        if arr.count == N / 2 {
            ans = min(ans, abs(sumValue(arr: arr) - sumValue(arr: numbers.filter { !arr.contains($0) })))
            return
        }
        
        else {
            for i in n + 1..<N {
                combi(n: i, arr: arr + [i])
            }
        }
    }
    
    combi(n: 0, arr: [0])
    print(ans)
}

baek()
