import Foundation

// pg_N-Queen
// 2차원 배열로 만들고 대각 체크도 while문 4개 쓰고 하다가 시초나서
// 한 행에 하나의 퀸만 들어가는걸 알고나서 1차원 배열로 풀이를 바꾸어서 해결함
// x좌표 차와 y좌표 차의 절댓값이 같은 부분으로 대각선 체크를해야 시초가 나지 않고 해결이 가능!
func solution(_ n:Int) -> Int {
    var answer = 0
    var count = 0
    var map: [Int] = []
    
    // 퀸 자리 체크
    func falseCheck(_ i: Int, _ k: Int, _ map: [Int]) -> Bool {
        for j in 0..<map.count {
            // x 좌표 체크
            if k == map[j] { return false }
            
            // x좌표 차, y좌표 차 절댓값이 같으면 x ==> 대각선 체크
            if abs(map[j] - k) == abs(j - i) { return false }
        }
        
        return true
    }
    
    func solve(_ i: Int, _ k: Int, _ map: [Int], _ count: Int) {
        let count = count + 1
        if count == n {
            answer += 1
            return
        }
        
        var map = map
        for k in 0..<n {
            if falseCheck(i + 1, k, map) {
                map.append(k)
                solve(i + 1, k, map, count)
                map.popLast()
            }
        }
    }
    
    for i in 0..<n {
        map.append(i)
        solve(0, i, map, count)
        map.popLast()
    }
    
    return answer
}
