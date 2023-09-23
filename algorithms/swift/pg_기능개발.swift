import Foundation

// pg_기능개발
// 먼저 들어간 기능이 100을 넘겨야 뒤의 기능들도 나올 수 있는 구조
// 그래서 큐를 생각해서 풀면 된다.
func solution(_ progresses:[Int], _ speeds:[Int]) -> [Int] {
    var answer: [Int] = []
    var progresses = progresses
    var speeds = speeds
    
    while(!progresses.isEmpty) {
        var i = 0
        var count = 0
        
        progresses = zip(progresses, speeds).map { $0 + $1 }

        while(!progresses.isEmpty && progresses[0] >= 100) {
            count += 1
            progresses.removeFirst()
            speeds.removeFirst()
        }
        answer.append(count)
    }
    
    return answer.filter { $0 != 0 }
}
