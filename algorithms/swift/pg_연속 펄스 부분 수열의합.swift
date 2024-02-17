import Foundation

// pg_연속 펄스 부분 수열의 합
// dp의 냄새가 나서 그렇게 접근을 시작해쓰, 아마 부분 수열의 합이라는
// 키워드 보고 떠올린둣, 규칙을 찾아보다가 짝수인덱스에서 시작한 부분 수열은
// 짝수 인덱스끼리만 비교하고 홀수인덱스는 홀수끼리 비교해야겠다 싶어서
// 짝수 부분수열 담는 배열, 홀수 부분수열 담는 배열 2개만들어서
// 짝수 인덱스의 경우 들어오는 sequence 수와 짝수 배열의 최댓값과 비교하고
// 홀수 배열에는 그냥 더해주어씀 그러고 매 반복마다 최대값을 담는 변수를 하나 두었따
func solution(_ sequence:[Int]) -> Int {
    if sequence.count == 1 { return max(sequence[0], sequence[0] * -1) }
    var evens: [Int] = []
    var odds: [Int] = []
    var temp_max = 0
    
    evens.append(sequence[0] -sequence[1])
    evens.append(-sequence[0] + sequence[1])
    
    odds.append(sequence[1])
    odds.append(-sequence[1])
    
    for i in 2..<sequence.count {
        
        if i % 2 == 0 {
            odds[0] -= sequence[i]
            odds[1] += sequence[i]
            
            evens[0] = max(evens[0] + sequence[i], sequence[i])
            evens[1] = max(evens[1] - sequence[i], -sequence[i])
        }
        
        else {
            evens[0] += (sequence[i] * -1)
            evens[1] += sequence[i]
            
            odds[0] = max(odds[0] + sequence[i], sequence[i])
            odds[1] = max(odds[1] - sequence[i], -sequence[i])
        }
        
        temp_max = max(temp_max, evens[0], evens[1], odds[0], odds[1])
    }
    

    return max(evens.max()!, odds.max()!, temp_max)
}
