// BOJ 23083 - 꿀벌 승연이
// 후,, 계속 런타임 에러가 뜨길래 뭔가 했는데
// 나머지 연산을 도중에도 넣어 줘야한다... ㅜㅡㅜ
import Foundation

// 스위프트에서 입력을 받는 함수
let inputArray: [Int] = optionalBye()

// 행렬 크기와 구멍 개수
let N = inputArray[0]
let M = inputArray[1]
let K = optionalBye()[0]

// 오른쪽 위, 오른쪽, 아래를 담을 N*M 행렬 하나
// 가중치를 나타내는 행렬 하나, -1은 구멍난거임
var map = Array(repeating: Array(repeating: Array(repeating: (-1, -1), count: 0), count: M), count: N)
var weight = Array(repeating: Array(repeating: 0, count: M), count: N)

// 구멍난 정보를 적용함
for _ in 0..<K {
    let cases = optionalBye()
    weight[cases[0] - 1][cases[1] - 1] = -1
}

// 각 칸마다 다음 갈 수 있는 칸들을 담는 코드
for i in 0..<N {
    for k in 0..<M {
        if weight[i][k] != -1 {
            appendNextSpace(i: i, k: k)
        }
    }
}

// 초기 값
weight[0][0] = 1

// 행으로 내려가는 식으로 구현 이 방식이 값을 다 채워 줄거라고 생각해씀
for i in 0..<M {
    for k in 0..<N {
        if weight[k][i] != -1 {
            for next in map[k][i] {
                weight[next.0][next.1] += weight[k][i] % 1000000007
            }
        }
    }
}

print(weight[N - 1][M - 1] % 1000000007)

// 옵셔널 Bye
func optionalBye() -> [Int] {
    guard let input = readLine() else { return [] }
    let inputArray: [String] = input.components(separatedBy: " ")
    let intInputArray = inputArray.compactMap { Int($0) }

    return intInputArray
}

// 다음 칸을 계산하는 함수
func appendNextSpace(i: Int, k: Int) {
    if k % 2 == 0 {
        let space = [(i - 1, k + 1), (i, k + 1), (i + 1, k)].filter { item in
            item.0 != -1 && item.0 != N && item.1 != -1 && item.1 != M && weight[item.0][item.1] == 0
        }
        map[i][k] = space
    }
    else {
        let space = [(i, k + 1), (i + 1, k + 1), (i + 1, k)].filter { item in
            item.0 != -1 && item.0 != N && item.1 != -1 && item.1 != M && weight[item.0][item.1] == 0
        }
        map[i][k] = space
    }
}
