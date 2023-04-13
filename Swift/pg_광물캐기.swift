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
