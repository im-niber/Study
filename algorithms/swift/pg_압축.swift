import Foundation

// pg_압축
// 문자열을 순회하면서 딕셔너리에 없다면 값을 반환하고,
// 딕셔너리에 저장하는 구현문제
// A~Z의 딕셔너리 저장하는 방법을 좀 찾아보았는데 여러가지가 있는듯함
func solution(_ msg:String) -> [Int] {
    let msg = Array(msg)
    var res: [Int] = []
    var dict: [String: Int] = [:]
    
    let str = "abcdefghijklmnopqrstuvwxyz"
    let characterArray = Array(str.uppercased())
    var i = 1
    for char in characterArray {
        dict[String(char)] = i
        i += 1
    }
    
    var temp = ""
    var idx = 0
    
    while(idx < msg.count) {
        temp += String(msg[idx])
        while(true) {
            idx += 1
            if idx >= msg.count { res.append(dict[temp]!); break }
            if dict[temp + String(msg[idx])] == nil {
                res.append(dict[temp]!)
                dict[temp + String(msg[idx])] = i
                i += 1
                temp = ""
                break
            }
            temp += String(msg[idx])
        }
    }
    
    
    return res
}

print(solution("KAKAO"))
print(solution("TOBEORNOTTOBEORTOBEORNOT"))
print(solution("ABABABABABABABAB"))
