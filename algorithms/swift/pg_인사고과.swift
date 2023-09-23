import Foundation

// pg_인사고과
// 좀 어렵게 생각해서 코드가 너무 방대해짐..
// 근태점수를 내림차순으로 정렬하고 idx를 들고있는 배열하나랑
// 동료평가점수를 오름차순으로 정렬하고 idx를 들고있는 배열하나를 만들어서 비교를 시작함
// 이걸 하나로 몰았어야 하는데,, 너무 멀리와버려서 이렇게 쭉 해결을 했다
// 근태 점수가 같은경우의 비교를 디테일하게 하지 않아서 11,22 케이스에서 너무 오래걸렸다..
func solution(_ scores:[[Int]]) -> Int {
    var rank = 0
    var i = -1
    let answerValue = scores[0][0] + scores[0][1]
    
    var workScores: [(Int, Int)] = scores.map { item in
        i += 1
        return (item[0], i)
    }.sorted { $0.0 > $1.0 }
    
    let maxValue = workScores[0].0
    
    i = -1
    var coworkerScores: [(Int, Int)] = scores.map { item in
        i += 1
        return (item[1], i)
    }.sorted { $0.0 < $1.0 }
    
    var idxDict: [Int: Int] = [:]
    var insentiveArrays: [Int] = []

    for i in 0..<coworkerScores.count {
        idxDict[coworkerScores[i].1] = i
    }
    
    while(!workScores.isEmpty) {
        while(coworkerScores.last?.0 == -1) { coworkerScores.popLast() }
        if coworkerScores.count == 0 { break }
        
        i = 1
        let (item, idx) = workScores.popLast()!
        
        if item == maxValue {
            insentiveArrays.append(item + scores[idx][1])
            continue
        }
        
        if scores[idx][1] >= coworkerScores.last!.0 {
            coworkerScores[idxDict[idx]!].0 = -1
            insentiveArrays.append(item + scores[idx][1])
        }
        else if scores[coworkerScores.last!.1][0] == item {
            var flag = true
            while(i != coworkerScores.count) {
                i += 1
                let (item2, idx2) = coworkerScores[coworkerScores.count - i]
                
                if scores[idx2][0] == item { continue }
                else if scores[idx2][0] > item && item2 > scores[idx][1] {
                    flag = false
                    break
                }
                else { flag = true }
            }
            if flag { insentiveArrays.append(item + scores[idx][1]) }
            coworkerScores[idxDict[idx]!].0 = -1
        }
        else {
            if idx == 0 { return -1 }
            coworkerScores[idxDict[idx]!].0 = -1
        }
    }
    
    insentiveArrays.sort(by: >)
    for i in 0..<insentiveArrays.count {
        if insentiveArrays[i] == answerValue {
            rank = i + 1
            break
        }
    }
    
    return rank
}
