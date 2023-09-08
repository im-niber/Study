import Foundation

// pg_n진수 게임
// 10진수를 기준으로 변환하여 배열에 담은 다음에
// 순서에 맞게 answer에 담아줘서 풀었다
func solution(_ n:Int, _ t:Int, _ m:Int, _ p:Int) -> String {
    var res = "-"
    let table: [String] = ["0","1","2","3","4","5","6","7","8","9","A", "B", "C", "D", "E", "F"]
    var answer = ""
    
    func convertNumber(_ number: Int) -> String {
        var res = ""
        var number = number
        
        while(number != 0) {
            if number % n == 0 && number < n {
                res.append(table[number / n])
                break
            }
            else {
                res.append(table[number % n])
            }
            number /= n
        }
    
        return res.count == 0 ? "\(number)" : String(res.reversed())
    }
    
    for i in 0...t*m { res.append(convertNumber(i)) }
    let answerTable = Array(res)
    
    for i in 1..<answerTable.count {
        if p == m && i % m == 0 { answer.append(answerTable[i]) }
        else if i % m == p { answer.append(answerTable[i]) }
        
        if answer.count == t { break }
    }
    
    return answer
}

print(solution(2, 4, 2, 1))
print(solution(7, 16, 2, 1))
print(solution(16, 16, 2, 1))
print(solution(4, 16, 2, 2))
print(solution(16, 16, 2, 2))
