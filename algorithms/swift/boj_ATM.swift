// boj_ATM
// 그리디,, 실버4라 그런지 좀쉬워쓰
func baekjoon() -> Int {
    let N = Int(readLine()!)!
    var intInput = readLine()!.split(separator: " ").compactMap { Int($0 ) }
    
    intInput.sort()
    var ans = 0
    for i in 1..<intInput.count {
        intInput[i] += intInput[i - 1]
    }
    return intInput.reduce(0, +)
}
