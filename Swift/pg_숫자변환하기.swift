import Foundation

// pg_숫자 변환하기
// 처음엔 dfs로 시도하다가 시간초과가 떠서 포기하고 bfs로 대부분 케이스를 통과하였지만
// 5 7 9 10번이 계속 초과가나서 y에서 부터 x를 만드는 방식으로 시도해서 통과함
func solution(_ x:Int, _ y:Int, _ n:Int) -> Int {
    var que: [(Int,Int)] = [(y,0)]
    var count = 0
    
    while(!que.isEmpty) {
        let next = que.removeFirst()
        if next.0 == x { return next.1 }
        if next.0 <= 0 { break }

        if next.0 % 3 == 0 { que.append((Int(next.0 / 3), next.1 + 1)) }
        if next.0 % 2 == 0 { que.append((Int(next.0 / 2), next.1 + 1)) }
        que.append((next.0 - n, next.1 + 1))
    }
    
    return -1
}
