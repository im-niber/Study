import Foundation

// pg_프로세스
// 배열안의 원소를 pop 하는데 조건이 있는 문제였다
// 프로세스들을 index로 만들어서 저장해서 조건에 맞으면 빼고
// 비교할 때 상관없게해주기 위해 -1로 값을 바꿔주어 풀었다
func solution(_ priorities:[Int], _ location:Int) -> Int {
    var answer = 0
    var arr: [Int] = []
    var priorities = priorities
    
    for i in 0..<priorities.count { arr.append(i) }
    
    let target = arr[location]
    
    while(true) {
        var flag = true
        
        let num = arr.removeFirst()
        let prior = priorities[num]
        
        for i in 0..<priorities.count {
            if prior < priorities[i] {
                arr.append(num)
                flag = false
                break
            }
        }
        if !flag { continue }
        else {
            answer += 1
            priorities[num] = -1
            if num == target {
                break
            }
        }
    }
    
    return answer
}
print(solution([2, 1, 3, 2], 2))
print(solution([1, 1, 9, 1, 1, 1], 0))

