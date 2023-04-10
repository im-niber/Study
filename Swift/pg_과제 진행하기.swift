import Foundation

func solution() {
    
    let tempplans: [[String]] = [["science", "12:40", "50"], ["music", "12:20", "40"], ["history", "14:00", "30"], ["computer", "12:30", "100"]]
    
    // 딕셔너리를 담을 구조 선언 부분
    var stack: Array<(key: String, value: (Int,Int))> = []
    var plans: [String : (Int, Int)] = [:]
    var answer: [String] = []
    
    for i in 0..<tempplans.count {
        // 시간 계산을 위해 전부 분 단위로 바꾸는 부분
        let minutes = tempplans[i][1].components(separatedBy: ":")
        let minute = Int(minutes[0])! * 60 + Int(minutes[1])!
        
        plans[tempplans[i][0]] = (minute, Int(tempplans[i][2])!)
    }
    
    // 정렬
    var sortedPlans = plans.sorted { first, second in
        first.value.0 > second.value.0
    }
    // 배열로 만들어서 다루기 편하게 함
    var arrayPlans = Array(sortedPlans)
    
    // 스택 사용
    stack.append(arrayPlans.removeLast())
    
    while(!stack.isEmpty) {
        // 만약 추가 과제가 없다면 그대로 삭제
        if arrayPlans.isEmpty {
            var item = stack.removeLast()
            answer.append(item.key)
        }
        else {
            var time = arrayPlans[arrayPlans.count - 1].value.0 - stack[stack.count - 1].value.0
            
            // 다음 과제랑, 스택 맨 위에 있는 과제의 시간을 비교
            if time > stack[stack.count - 1].value.1 {
                var nowTime = stack[stack.count - 1].value.0 + stack[stack.count - 1].value.1
                
                time -= stack[stack.count - 1].value.1
                var item = stack.removeLast()
                answer.append(item.key)
                
                if stack.isEmpty {
                    stack.append(arrayPlans.removeLast())
                }
                else {
                    for i in 0..<stack.count {
                        stack[i].value.0 = nowTime
                    }
                }
            }
            
            else if time == stack[stack.count - 1].value.1 {
                var item = stack.removeLast()
                answer.append(item.key)
                stack.append(arrayPlans.removeLast())
            }
            
            else {
                stack[stack.count - 1].value.1 -= time
                stack[stack.count - 1].value.0 += time
                
                stack.append(arrayPlans.removeLast())
            }
        }
    }
    print(answer)
}

solution()
