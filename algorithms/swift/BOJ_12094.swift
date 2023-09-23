// BOJ 12904 - A와 B
// 좀 고민을 하다가 규칙을 찾았고 그걸 적용하여씀
// 처음에는 일일이 찾으려다가 2^999 ? 까지 나오겠구나 싶어서 접었고
// 다음으로는 두 번째 문자열을 만드려면 어떻게 해야 하는가로 고민을 하다가 규칙을 찾았다
// 규칙이란, 결국 두 번째 문자열을 만드려면 게임의 룰을 지키며 만들어야한다
// 그러면 맨 뒤 문자열로 이전 문자열에서 어떤 룰을 사용해서 지금의 문자열이 만들어졌는지가 나옴
// 그래서 이전 문자열을 알아낼 수 있고 이를 구현하면 된다. 규칙을 알고나니 간단s
import Foundation

// 옵셔널 Bye
func optionalBye() -> String {
    guard let input = readLine() else { return "error" }
    return input
//    let inputArray: [String] = input.components(separatedBy: " ")
//    let intInputArray = inputArray.compactMap { Int($0) }
}

var stringArray: [String] = []

for _ in 0..<2 {
    stringArray.append(optionalBye())
}

var stringToArray = Array(stringArray[1])

solution()

func solution() {
    
    if String(stringToArray) == stringArray[0] {
        print("1")
        return
    }
    
    else if stringToArray == [] {
        print("0")
        return
    }
    
    if stringToArray[stringToArray.endIndex - 1] == "A" {
        stringToArray.removeLast()
        solution()
    }
    
    else if stringToArray[stringToArray.endIndex - 1] == "B" {
        stringToArray.removeLast()
        stringToArray.reverse()
        solution()
    }
}
