import Foundation

// pg_보석 쇼핑
// 구현문제..? 라고 생각이듬니다.
// 앞에서부터 넣으면서 조건을 체크해야겠다 라고 생각했고
// 앞에서부터 차례대로 배열에 넣고, 넣기전에
// 맨 앞에 연속되는 보석이거나 맨 뒤에 넣을 보석이 맨 앞이랑 같다면
// 맨 앞의 보석을 빼주면서 구간을 줄이려고 했는데
// 중간에 있는 보석과 맨 앞에 있는 보석이 같은 경우의 예외가 있어서
// 이 부분은 아무래도 딕셔너리로 지금까지 담은 보석의 개수를 체크해야하지싶어서
// 딕셔너리 하나 만들고, 중복인 보석을 제거해주면서 풀었따 그리고 이렇게 하면
// 위에서 체크한 연속된보석, 젤 앞, 뒤 보석 조건도 지워도 되서 좀 더 깔끔해졌다.
func solution(_ gems: [String]) -> [Int] {
    var start = 0
    var end = 0
    
    var minStart = Int.max
    var minEnd = Int.max
    
    var sets: Set<String> = []
    var cnts: [String: Int] = [:]
    
    for item in gems {  sets.insert(item) }
    
    var nowGems: [String] = []
    var minSectionCount = Int.max

    for i in 0..<gems.count {
        nowGems.append(gems[i])
        cnts[gems[i], default: 0] += 1
        
        sets.remove(gems[i])
        
        end = i
        
        if sets.isEmpty {
            
            while cnts[nowGems.first ?? ""] ?? 0 > 1 {
                cnts[nowGems.first ?? ""]! -= 1
                nowGems.removeFirst()
                start += 1
            }
            
            if minSectionCount > end - start {
                minSectionCount = end - start
                
                minStart = start
                minEnd = end
            }
            
            cnts[nowGems.first ?? ""]! -= 1
            sets.insert(nowGems.removeFirst())
            start += 1
        }
    }
    
    return [minStart + 1, minEnd + 1]
}
