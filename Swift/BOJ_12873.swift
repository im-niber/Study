// BOJ 12873 - 기념품
import Foundation

// 스위프트에서 입력을 받는 함수, 옵셔널이므로 언래핑을 해야함 알고리즘 문제의 경우는 강제 언래핑 해도 괜찮긴 함
var arrayCount = Int(readLine()!)!

// 문제에 해당하는 배열을 만드는 코드 (17라인까지)
var array: [Int] = Array(repeating: 0, count: arrayCount)
for i in 0..<arrayCount{
    array[i] = i + 1
}

// 필요한 변수들 답과, 시작 단계, 마지막 위치를 명시하고 있다
var answer: Int = 0
var start = 1
var lastIndex = 0

// 하나씩 없애므로 1이 되면 반복문 종료함
while(arrayCount != 1) {
    // 1단계는 1, 2단계는 8 3단계는 27 이렇게 흘러가는데
    // 마지막 위치의 인덱스를 더해줘야함 다음 차례부터 스타트하므로
    let stage = triple(start: start) + lastIndex
    
    // 그리고 이를 배열 카운트로 나머지를 구해줌. 그리고 인덱스 하나씩 차이나므로 하나 빼줌
    lastIndex = (stage - 1) % arrayCount
    
    // 단계가 끝나고 앞에 있는 친구는 사라지므로 그걸 구현한 코드
    array.remove(at: lastIndex)
    arrayCount -= 1
    
    // 다음 단계를 시작해야 하므로 + 1
    start += 1
}
// 다 삭제 해버렸으므로 답은 0번 인덱스에 존재 함.
answer = array[0]
print(answer)

// 세 제곱 하는 함수
func triple(start: Int) -> Int {
    return (start * start * start)
}
