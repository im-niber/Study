import Foundation

// pg_양궁대회
// 예ㅔㅔ전에 파이썬으로 풀었을 때는 순열조합 썼는데
// 이번엔 DFS로 풀어봄
// 완전탐색으로 이번 점수를 맞추고 가거나 안 맞추고 넘어가거나
// 의 경우로 나누어서 시도함 마지막에 정렬하는 부분에서 좀 걸렸다,,
func solution(_ n:Int, _ info:[Int]) -> [Int] {
    let temp: [Int] = [0,0,0,0,0,0,0,0,0,0,0]
    var anss: [[Int]] = []
    
    var maxValue = 0
    
    func cal(lhs: [Int], rhs: [Int]) -> Int {
        var value = 0
        
        for i in 0..<11 {
            if lhs[i] == 0 && rhs[i] == 0 { }
            else if lhs[i] < rhs[i] { value += (10 - i) }
            else { value -= (10 - i) }
        }
        
        return value
    }
    
    func dfs(n: Int, arr: [Int], idx: Int) {
        var arr = arr

        if n == 0 || idx == 10 {
            if n > 0 { arr[idx] += n }
            let val = cal(lhs: info, rhs: arr)
            
            if val > maxValue {
                anss = []
                anss.append(arr)
                maxValue = val
            }
            else if val == maxValue {
                anss.append(arr)
            }
            
            return
        }
        
        let tempN = n - (info[idx] + 1)
        
        if tempN >= 0 {
            arr[idx] = info[idx] + 1
            dfs(n: tempN, arr: arr, idx: idx + 1)
            arr[idx] = 0
        }
        
        if n > 0 { dfs(n: n, arr: arr, idx: idx + 1) }
        
    }
    
    dfs(n: n, arr: temp, idx: 0)
    
    if anss.count == 0 { return [-1] }
    
    return anss.sorted { lhs, rhs in
        for i in stride(from: lhs.count - 1, through: 0, by: -1) {
            if lhs[i] < rhs[i] { return true }
            else if lhs[i] > rhs[i] { return false }
        }
        return false
    }.last!
}
