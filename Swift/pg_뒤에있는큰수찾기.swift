import Foundation

// pg_뒤에 있는 큰 수 찾기
// 조금 헤맨 문제 뒤에서부터 탐색을 시작하고
// 해당 인덱스의 뒷 큰수의 인덱스를 저장할 딕셔너리를 만든다
// 그리고 탐색을 하면서 해당 딕셔너리만 연결리스트처럼 비교하면서 진행하면 해결된다.
// 이렇게 하면 비교횟수를 최대한 많이 줄이는것같아서 해보았는데 다행히 통과한두
func solution(_ numbers:[Int]) -> [Int] {
    var result: [Int] = [-1, ]
    var dict: [Int: Int] = [:]
    dict[numbers.count - 1, default: -1] = -1
    
    for i in stride(from: numbers.count - 2, through: 0, by: -1) {
        print(i)
        if numbers[i + 1] > numbers[i] {
            result.append(numbers[i + 1])
            dict[i, default: -1] = i + 1
        }
        else {
            var idx = dict[i + 1] ?? -1
            while(true) {
                if idx == -1 {
                    result.append(-1)
                    break
                }
                else {
                    if numbers[idx] > numbers[i] {
                        result.append(numbers[idx])
                        dict[i, default: -1] = idx
                        break
                    }
                    else { idx = dict[idx] ?? -1 }
                }
            }
        }
    }
    return result.reversed()
}

print(solution([2, 3, 3, 5]))
print(solution([9, 1, 5, 3, 6, 2]))
