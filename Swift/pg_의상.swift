import Foundation

// pg_의상
// 수학적으로 접근을했어야 했는데,, 모든 케이스를 dfs로 해보려다가
// 오래걸렸다 후우ㅜ
func solution(_ clothes:[[String]]) -> Int {
    var result = 1
    var dict: [String: [String]] = [:]
    
    for item in clothes { dict[item[1], default: []].append(item[0]) }
    
    for item in dict {
        result *= (item.value.count + 1)
    }
    
    return result - 1
}

print(solution([["yellow_hat", "headgear"], ["blue_sunglasses", "eyewear"], ["green_turban", "headgear"]]))
print(solution([["crow_mask", "face"], ["blue_sunglasses", "face"], ["smoky_makeup", "face"]]))
print(solution([["a","b"], ["c","d"], ["e","f"], ["g","h"], ["g2", "h"]]))
