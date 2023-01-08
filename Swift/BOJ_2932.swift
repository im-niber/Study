// BOJ 2932 - 표 회전
import Foundation

// 스위프트에서 입력을 받는 함수, 이번엔 강제 언래핑 말고 옵셔널 바인딩으로 ~
let inputArray: [Int] = optionalBye()

// 크기와 반복횟수
let N = inputArray[0]
let reps = inputArray[1]

// 정보를 담을 배열 값과, 현재 위치와, 목적지를 나타냄
var valueContainer: [Int] = []
var nowPositionContainer: [(Int, Int)] = []
var destinationContainer: [(Int, Int)] = []

// 케이스들의 정보를 배열에 넣음
for _ in 0..<reps {
    let cases = optionalBye()
    valueContainer.append(cases[0])
    nowPositionContainer.append(position(num: cases[0]))
    destinationContainer.append((cases[1], cases[2]))
}

for i in 0..<reps {
    let answer: Int = getAnswer(now: nowPositionContainer[i], destination: destinationContainer[i])
    print(answer)
    
    // 얼마나 움직여야하는지를 나타내는 변수들
    let moveCol = destinationContainer[i].1 - nowPositionContainer[i].1
    let moveRow = destinationContainer[i].0 - nowPositionContainer[i].0
    
    for k in i..<reps {
        // row는 같은 행을 판별하기 위해 넣었슴다
        rotateCol(arrayIndex: k, move: moveCol, row: nowPositionContainer[i].0)
//        print("rotateCol")
//        print(valueContainer[i], nowPositionContainer[i], destinationContainer[i])
    }
    
    for k in i..<reps {
        // col의 존재이유도 위와 가틈
        rotateRow(arrayIndex: k, move: moveRow, col: destinationContainer[i].1)
    }
}

// 옵셔널 가버려 ~
func optionalBye() -> [Int] {
    guard let input = readLine() else { return [] }
    let inputArray: [String] = input.components(separatedBy: " ")
    let intInputArray = inputArray.compactMap { Int($0) }

    return intInputArray
}

func position(num: Int) -> (Int, Int) {
    // 1을 더해줘야 현실의 행렬의 위치와 같게 된다
    var quotient = (num / N) + 1
    var remainder = num % N
    
    // 만약 딱 떨어지면 맨 끝에 이씀
    if remainder == 0 {
        quotient -= 1
        remainder = N
    }
    
    return (quotient, remainder)
}

// 행을 목적지의 행으로 맞추는 회전함수
func rotateRow(arrayIndex: Int, move: Int, col: Int) {
    if nowPositionContainer[arrayIndex].1 == col {
        nowPositionContainer[arrayIndex].0 += move
        if nowPositionContainer[arrayIndex].0 <= 0 {
            nowPositionContainer[arrayIndex].0 += N
        } else if nowPositionContainer[arrayIndex].0 > N {
            nowPositionContainer[arrayIndex].0 -= N
        }
    }
}

// 열을 목적지의 열로 맞추는 회전함수
func rotateCol(arrayIndex: Int, move: Int, row: Int) {
    if nowPositionContainer[arrayIndex].0 == row {
        nowPositionContainer[arrayIndex].1 += move
        if nowPositionContainer[arrayIndex].1 <= 0 {
            nowPositionContainer[arrayIndex].1 += N
        } else if nowPositionContainer[arrayIndex].1 > N {
            nowPositionContainer[arrayIndex].1 -= N
        }
    }
}

// 답을 구하는 함수
// 무조건 오른쪽 또는 아래로 가는걸 늦게 깨달아서 헤매버렸드,,
func getAnswer(now: (Int, Int), destination: (Int, Int)) -> Int {
    var answer = 0
    
    if destination.0 >= now.0 {
        answer += destination.0 - now.0
    } else {
        answer += N + (destination.0 - now.0)
    }
    
    if destination.1 >= now.1 {
        answer += destination.1 - now.1
    } else {
        answer += N + (destination.1 - now.1)
    }
    
    return answer
}

