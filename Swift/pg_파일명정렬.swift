import Foundation

// pg_파일명 정렬
// 문제에서 설명한 HEAD 부분을 먼저 정렬하고
// 다음 NUMBER를 정렬해야한다. 그래서 함수들을 만들어서 순서대로 실행해줌
// HEAD 먼저 정렬해두고, 그 다음으론 HEAD가 같은경우에 NUMBER를 정렬하도록 하였다
func solution(_ files:[String]) -> [String] {
    func stringToInt(with str: String) -> Int {
        var temp: String = ""
        var flag = false
        for char in str {
            if char.isNumber {
                flag = true
                temp += String(char)
            }
            if flag && !char.isNumber { break }
        }
        return Int(temp)!
    }
    func stringToHead(with str: String) -> String {
        let array = Array(str.uppercased())
        for i in 0..<str.count {
            if array[i].isNumber {
                return String(array[0..<i])
            }
        }
        return ""
    }
    
    func sortString(lhs: String, rhs: String) -> Bool {
        return stringToHead(with: lhs) == stringToHead(with: rhs) ?
        stringToInt(with: lhs) < stringToInt(with: rhs) : false
    }

    var files = files.sorted { stringToHead(with: $0) < stringToHead(with: $1) }
    files = files.sorted { sortString(lhs: $0, rhs: $1) }
    return files
}

print(solution(["img12.png", "img10.png", "img02.png", "img1.png", "IMG01.GIF", "img2.JPG"]))
print(solution(["F-5 Freedom Fighter", "B-50 Superfortress", "A-10 Thunderbolt II", "F-14 Tomcat"]))
