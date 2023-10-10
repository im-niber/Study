import Foundation

// pg_이진 변환 반복하기
// 문자열이 주어지고 0을 제거한 후 나오는 문자열의 길이를
// 2진수로 변환해서 위 동작을 반복하다가 1이 나오면 멈추고
// 횟수랑 0 제거 몇 개한지 리턴하는 문제여씀~
func solution(_ s:String) -> [Int] {
    var result = [0, 0]
    var s = s
    while(s != "1") {
        var temp: String = ""
        for char in s {
            if char == "0" {
                result[1] += 1
                continue
            }
            temp += String(char)
        }
        var num = temp.count
        s = String(num, radix: 2)
        result[0] += 1
    }
    return result
}

// 다른 분의 깔끔한 풀이
// replacingOccurrences를 사용해서 문자열을 치환하는 풀이이다
// 본 적은 있는거 같은데 사용해본적이없어서 알아두면 좋을듯 함
func solution2(_ s: String) -> Array<Int> {
    var copiedS = s
    var removedZero = 0
    var count = 0

    while copiedS != "1" {
        removedZero += copiedS.replacingOccurrences(of: "1", with: "").count
        copiedS = String(copiedS.replacingOccurrences(of: "0", with: "").count, radix: 2)
        count += 1
    }
    return [count, removedZero]
}
