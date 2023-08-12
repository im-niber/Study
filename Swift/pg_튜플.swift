import Foundation

// pg_튜플
// 먼저 [[Int]] 배열로 숫자들을 담아주고, count순으로 정렬을 했다
// 그리고 set에 넣으면서 기존에 본 숫자인지 체크하고 아니면 정답 배열에 append해서 순서를 지켜줌
// 다른 사람 풀이의 파싱보면서 좀 더 배워야겠다 다들 괴물이ㅑ~
func solution(_ s:String) -> [Int] {
    var numbers: Set<Int> = []
    var res: [Int] = []
    var s = s
    s.removeFirst()
    s.removeLast()

    var cases: [[Int]] = []
    var tempStr = ""
    var tempArr: [Int] = []
    
    for item in s {
        if item == "}" {
            tempArr.append(Int(tempStr)!)
            cases.append(tempArr)
            tempStr = ""
            tempArr = []
            continue
        }
        if !item.isNumber && tempStr.count != 0 {
            tempArr.append(Int(tempStr)!)
            tempStr = ""
            continue
        }
        if item.isNumber {
            tempStr += String(item)
        }
    }
    cases.sort { $0.count < $1.count }
    
    for items in cases {
        for item in items {
            if numbers.contains(item) { continue }
            numbers.insert(item)
            res.append(item)
        }
    }
    
    return res
}

print(solution("{{2},{2,1},{2,1,3},{2,1,3,4}}"))
print(solution("{{20,111},{111}}"))
