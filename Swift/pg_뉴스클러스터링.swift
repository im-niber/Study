import Foundation

// pg_뉴스 클러스터링
// 문자열의 교집합 합집합 개수를 나누는 문제
// 딕셔너리를 활용해서 문제를 해결하였다, 딕셔너리에 넣는 부분이 중복이 되어서 함수로 만든다면 더 좋았을듯
func solution(_ str1:String, _ str2:String) -> Int {
    var unionCount = 0.0
    var interCount = 0.0
    
    var temp: String = ""
    var Adict: [String : Double] = [:]
    var Bdict: [String : Double] = [:]
    
    for item in str1 {
        if item.isLetter {
            temp += item.lowercased()
        }
        
        else {
            temp = ""
            continue
        }
        
        if temp.count == 2 {
            Adict[temp, default: 0] += 1
            temp = String(item.lowercased())
        }
    }
    
    temp = ""
    for item in str2 {
        if item.isLetter {
            temp += item.lowercased()
        }
        
        else {
            temp = ""
            continue
        }
        
        if temp.count == 2 {
            Bdict[temp, default: 0] += 1
            temp = String(item.lowercased())
        }
    }
    
    for (key, value) in Adict {
        if Bdict[key] != nil {
            interCount += min(value, Bdict[key]!)
            unionCount += max(value, Bdict[key]!)
            Bdict[key]! = 0
        }
        else {
            unionCount += value
        }
    }
    
    for value in Bdict.values {
        unionCount += value
    }
    
    if interCount == 0 && unionCount == 0 {
        return 65536
    }

    return Int((interCount / unionCount) * 65536)
}
