import Foundation

// pg_할인 행사
// 구현 문제인둣 함, 10일 연속 부분을 생각해서 구현을 하면 간단하게 풀린다 !
// 10만개 데이터지만 10번만 더 반복하면 되기 때문에 시간복잡도 문제는 없다~
func solution(_ want:[String], _ number:[Int], _ discount:[String]) -> Int {
    var result = 0
    let dict = Dictionary(uniqueKeysWithValues: zip(want, number))
    var isZero = true
    
    for i in 0..<discount.count {
        var tempDict = dict
        
        for k in i..<i+10 {
            if k == discount.count { break }
            
            if tempDict[discount[k]] != nil {
                tempDict[discount[k]]! -= 1
            }
        }
        
        for item in tempDict.values {
            if item != 0 {
                isZero = false
                break
            }
        }
        
        isZero ? result += 1 : ()
        isZero = true
    }
    
    return result
}
