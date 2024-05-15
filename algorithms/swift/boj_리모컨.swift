// boj_1107 리모컨
// 버튼을 눌러 목표 채널까지 최소 몇 번의 버튼을 눌러야하는가
// 고장난 버튼도 있음, 채널은 무한대 0 에서 -1 해도 0.
// 처음 생각난 풀이는 최대한 숫자를 리모컨에서 입력한 후 +, - 이용해서 가면될듯..?

// 하지만 모든 경우를 찾는게 낫겠다 싶어서 그냥 다 구하고
// 다 비교해서 풀었다~

func baek() {
    let N = readLine()!
    
    let m = Int(readLine()!)!
    var failureBtns: Set<String> = []
    
    if m != 0 { failureBtns = Set(readLine()!.split(separator: " ").compactMap { String($0) }) }
    let possibleBtns = [0,1,2,3,4,5,6,7,8,9].map { String($0) }.filter { !failureBtns.contains($0) }
    
    let target = Int(N)!
    var ans = abs(target - 100)
    
    var str: [String] = []
    
    func getStr(depth: Int, len: Int) {
        
        if depth == len {
            let val = Int(str.joined())!
            ans = min(ans, abs(target - val) + len)
            return
        }
        
        for item in possibleBtns {
            str.append(item)
            getStr(depth: depth + 1, len: len)
            str.removeLast()
        }
    }
    
    for i in 1..<7 {
        getStr(depth: 0, len: i)
    }
    print(ans)
}

baek()
