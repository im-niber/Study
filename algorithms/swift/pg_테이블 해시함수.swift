import Foundation

// pg_테이블 해시 함수
// 정렬을 적절히 하여서 행의 나머지들을 다 더하고
// 그 값들을 가진 배열에서 특정 범위의 값들을 XOR 연산 해주면 되는 문제여씀
func solution(_ data:[[Int]], _ col:Int, _ row_begin:Int, _ row_end:Int) -> Int {
    let data = data.sorted { lhs, rhs in
        if lhs[col - 1] != rhs[col - 1] { return lhs[col - 1] < rhs[col - 1] }
        else { return  lhs[0] > rhs[0] }
    }
    var answers: [Int] = []
    for (i, item) in data.enumerated() {
        answers.append(item.reduce(0) { $0 + $1 % (i + 1) })
    }
    return answers[row_begin - 1..<row_end].reduce(0) {$0 ^ $1}
}
