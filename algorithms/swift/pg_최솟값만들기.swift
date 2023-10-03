import Foundation

// pg_최솟값 만들기
// 두 배열의 원소들을 하나씩 뽑아서 곱하고 결과에 누적하는데 이의 최소를 구해야함
// 처음 생각한 부분이 제일 작은 수와 제일 큰 수를 곱하는게 좋을거 같다고 생각해서
// 시도를 해보았더니 통과해씀
func solution(_ A:[Int], _ B:[Int]) -> Int {
    var A = A.sorted(by: <)
    var B = B.sorted(by: >)
    
    var ans = 0
    for i in 0..<A.count {
        ans += A[i] * B[i]
    }
    return ans
}
