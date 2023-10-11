import Foundation

// pg_짝지어 제거하기
// 순회하면서 문자가 연속으로 같은게 나오면
// 삭제시키는 동작을 반복하여 빈 문자열이 되는지 체크하는 문제
// 스택을 좀 늦게 생각해서오래걸려씀 스택을 활용했다면 되게 간단한문제~
func solution(_ s:String) -> Int {
    var stack: [Character] = []
    
    for char in s {
        stack.append(char)
        if stack.count >= 2 && stack.last == stack[stack.count - 2] {
            stack.removeLast(2)
        }
    }
    
    return stack.isEmpty ? 1 : 0
}
