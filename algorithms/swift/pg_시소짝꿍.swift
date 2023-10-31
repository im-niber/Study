import Foundation

// pg_시소 짞꿍
// 중심으로부터 2,3,4 m 거리
// 100,100 같으면 짞꿍임, 180 360은 4, 2거리면 짞꿍
// 4쌍 360,270 은 같은거라 안 치는듯
// 10만 길이, 하나 원소랑 위 비율 규칙이 같은 다른 원소 찾는 문제. 단순히 풀면 O(n^2)
// 정렬, 몸무게 범위를 딕셔너리로 정렬 ?
// ---
// 정렬 보다는 몸무게 범위가 작았기 때문에 딕셔너리로 해서 풀었다
// 이중 반복말고 더 간단히 풀수도있었는데 double요기서 좀 걸려서 생각못해쓰,,
// 나눠서 딕셔너리 key 가는건 주의해야할둣
func solution(_ weights:[Int]) -> Int64 {
    var ans: Int64 = 0
    var weightDict: [Double: Int] = [:]
    
    for item in weights {
        weightDict[Double(item), default: 0] += 1
    }
        
//     이중 반복 ver
    for item in weightDict {
        for _ in 0..<item.value {
            var temp = 0

            temp += weightDict[item.key]! - 1

            temp += weightDict[item.key / 2] ?? 0
            temp += weightDict[item.key * 2] ?? 0

            temp += weightDict[item.key * 2 / 3] ?? 0
            temp += weightDict[item.key * 3 / 2] ?? 0

            temp += weightDict[item.key * 4 / 3] ?? 0
            temp += weightDict[item.key * 3 / 4] ?? 0


            weightDict[item.key]! -= 1
            ans += Int64(temp)
        }
    }
    
    // 반복문 줄인 ver, 마지막 return에 /2 하믄댐
    for (key, value) in weightDict {
        var temp = 0
        
        temp += value * (value - 1)
    
        // nil 병합 연산자 쪽에 괄호안하믄 값이 이상하게 나온다, 당연한건데 먼가해쓰 ;
        // += weightDict[key / 2] ?? 0 * value -> weightDict[key / 2] ?? (0 * value)
        // 저 곱셈이 nil이면 값으로 된다는거;
        temp += (weightDict[key / 2] ?? 0) * value
        temp += (weightDict[key * 2] ?? 0) * value
        
        temp += (weightDict[key * 2 / 3] ?? 0) * value
        temp += (weightDict[key * 3 / 2] ?? 0) * value
        
        temp += (weightDict[key * 4 / 3] ?? 0) * value
        temp += (weightDict[key * 3 / 4] ?? 0) * value
        
        ans += Int64(temp)
    }
    
    return ans / 2
}
