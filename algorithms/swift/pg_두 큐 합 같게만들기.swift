import Foundation

// pg_두 큐 합 같게 만들기
// 조금 걸린 문제, 원소의 합이 큰 큐에서 그냥 pop해서 옮겨주면 되는건지
// 확신이 없었다. 그래도 먼가 이게 맞는거같아서 시도했고
// 종료 조건을 큐 길이의 3배까지 반복해도 답이 없다면 불가능이라고 판단했다
// 원래는 2배로 했었는데 케이스 1번에서 계속틀려서 큐 길이 2배로 판단하는건
// 예외가 있는듯함
func solution(_ queue1:[Int], _ queue2:[Int]) -> Int {
    var cnt = 0
    var queue1 = queue1, queue2 = queue2
    
    let total = queue1.count * 3
    
    var que1val: Int64 = Int64(queue1.reduce(0, +))
    var que2val: Int64 = Int64(queue2.reduce(0, +))
    
    let sumval = que1val + que2val
    let target = sumval / 2
    
    var p1 = 0
    var p2 = 0
    
    while(que1val != que2val) {
        if cnt > total { return -1 }
        cnt += 1
        
        if que1val < que2val {
            let temp = queue2[p2]
            queue2[p2] = 0
            que2val -= Int64(temp)
            
            queue1.append(temp)
            que1val += Int64(temp)
            p2 += 1
        }
        
        else if que1val > que2val {
            let temp = queue1[p1]
            queue1[p1] = 0
            p1 += 1
            que1val -= Int64(temp)
            
            queue2.append(temp)
            que2val += Int64(temp)
        }
    }
    
    return cnt
}
