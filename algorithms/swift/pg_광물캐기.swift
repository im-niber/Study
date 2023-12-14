import Foundation

// 이번에도 케이스가 별로 없다고 생각해서 재귀함수로 다 풀었다.
// 매개변수에 inout 파라미터로 두고 풀다가 값을 공유하고 있어서 계속 틀려서 조금 걸렸다,,
// 웬만해서는 복사를 제대로해서 풀기로~
// dfs 다시 봐야겠다 오랜만에 비슷하게 해보려했는데 좀 개판인둣,,,ㅎㅋㅋㅋ

func solution(_ picks:[Int], _ minerals:[String]) -> Int {
    var picks = picks
    
    func cal(_ mineral: String, _ index: Int) -> Int {
        if index == 0 {
            return 1
        }
        else if index == 1 {
            if mineral == "diamond" { return 5 }
            return 1
        }
        else {
            if mineral == "diamond" { return 25 }
            if mineral == "iron" { return 5 }
            return 1
        }
    }

    func sol(_ picks: [Int], _ pickIndex: Int, mineralIndex: Int) -> Int {
        var picks = picks
        var answer = 0
        
        var dia = 999999999
        var iron = 999999999
        var stone = 999999999
        
        picks[pickIndex] -= 1
        
        for i in mineralIndex..<mineralIndex + 5 {
            answer += cal(minerals[i], pickIndex)
            if i == minerals.count - 1 { return answer }
        }
        
        if picks[0] == 0 && picks[1] == 0 && picks[2] == 0 { return answer }
        
        if picks[0] != 0 { dia = (answer + sol(picks, 0, mineralIndex: mineralIndex + 5)) }
            
        if picks[1] != 0 { iron = (answer + sol(picks, 1, mineralIndex: mineralIndex + 5)) }
        
        if picks[2] != 0 { stone = (answer + sol(picks, 2, mineralIndex: mineralIndex + 5))
        }
        
        return min(dia, iron, stone)
    }
    
    var dia = 999999999
    var iron = 999999999
    var stone = 999999999
    
    if picks[0] != 0 { dia = (sol(picks, 0, mineralIndex: 0)) }
    if picks[1] != 0 { iron = (sol(picks, 1, mineralIndex: 0)) }
    if picks[2] != 0 { stone = (sol(picks, 2, mineralIndex: 0)) }
    
    return min(dia, iron, stone)
}

// 1214 ver
// 다시 풀일이 있어서 새로 풀었는데
// 이번엔 재귀로 풀 생각을 하지 못했다 순열 생각은 했어서 그게 그건가
// 싶기는 한디 여튼 이번엔 그리디로 풀어씀
// 먼저 곡괭이 개수 만큼 광물들을 나눠주어서 가능한 미네랄 배열을 만들었따
// 그 다음 피로도가 많이 드는 친구들을 내림차순으로 정렬해서
// 앞에서부터 다이아, 철, 스톤 괭이로 캐서 답을 냈음
func solution(_ picks:[Int], _ minerals:[String]) -> Int {
    var answer = 0
    
    var picks = picks
    let possibleCount = picks.reduce(0, +)
    var possibleMinerals: [[String]] = []
    
    var i = 0
    var tempArr: [String] = []
    
    while(possibleMinerals.count != possibleCount && i < minerals.count) {
        if tempArr.count == 5 {
            possibleMinerals.append(tempArr)
            tempArr = []
            continue
        }
        tempArr.append(minerals[i])
        i += 1
    }
    if !tempArr.isEmpty { possibleMinerals.append(tempArr) }
    
    func calValue(arr: [String]) -> Int {
        return arr.reduce(0) { partialResult, item in
            if item == "diamond" { return partialResult + 25 }
            else if item == "iron" { return partialResult + 5 }
            return partialResult + 1
        }
    }
    let sortedMinerals = possibleMinerals.sorted { lhs, rhs in
        calValue(arr: lhs) > calValue(arr: rhs)
    }
    for item in sortedMinerals {
        if picks[0] != 0 { answer += item.count; picks[0] -= 1 }
        else if picks[1] != 0 {
            for str in item {
                if str == "diamond" { answer += 5 }
                else { answer += 1 }
            }
            picks[1] -= 1
        }
        else {
            for str in item {
                if str == "diamond" { answer += 25 }
                else if str == "iron" { answer += 5 }
                else { answer += 1 }
            }
            picks[2] -= 1
        }
        
        if picks.reduce(0, +) == 0 { break }
    }
    
    return answer
}
