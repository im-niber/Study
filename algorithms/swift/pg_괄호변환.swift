// pg_괄호변환
// 문제에서 제시한대로 구현하여 풀었는데
// 도중에 문자열의 괄호 방향을 뒤집는다는게, reversed로 해버려서
// 도 대 체 왜 틀린거지 이러다가 아하 했다; 좀 더 문제를 자세히 읽어보기로~
func solution(_ p:String) -> String {
    var answer = ""
    
    var u = ""
    var v = p

    func verify(_ str: String) -> Bool {
        var stack: [Character] = []
        var str = str
        stack.append(str.removeFirst())
        
        while !str.isEmpty {
            if stack.last == ")" { return false }
            let next = str.removeFirst()
            
            if stack.isEmpty { stack.append(next) }
            else if next != stack.last { stack.popLast() }
            else { stack.append(next) }
        }
        
        return stack.isEmpty ? true : false
    }
    
    func divide(_ str: String) -> String {
        var left = 0
        var right = 0
        
        if str.isEmpty { return "" }
        
        var str = str
        var tempStr = ""

        while !str.isEmpty {
            let temp = String(str.removeFirst())
            if temp == "(" { left += 1 }
            else { right += 1 }
            
            tempStr += temp
            
            if left == right { v = str; return tempStr; }
        }
        
        return ""
    }
    
    if v.isEmpty { return "" }
    u = divide(v)
    
    if verify(u) {
        answer += u
        answer += solution(v)
    }
    
    else {
        var newStr = "(" + solution(v) + ")"
        u.removeFirst(); u.removeLast()
        
        u = String(u.map { item in
            if item == "(" { return ")" }
            return "("
        })
        newStr += u
        answer += newStr
    }
    
    return answer
}
