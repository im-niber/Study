import Foundation

// 간단했는데 좀 어렵게 생각해서 오래 걸렸다
// 무조건 요격해야 한다는 사실을 집중해서 생각했다면 쉽게 풀 듯 하다
func solution(_ targets:[[Int]]) -> Int {
    var targets = targets.sorted { first, second in
        first[0]  < second[0]
    }
    var count = 1

    var max_X = targets[0][1]

    for i in 1..<targets.count {
        if (max_X > targets[i][0]) {
            max_X = min(max_X, targets[i][1])
        }
        else {
            count += 1
            max_X = targets[i][1]
        }
    }

    return count
}

// pg_요격시스템 0103
// 다시 풀어보았는데 거의 비슷하게 한듯..?
// 시작점 업데이트도 해줬는데 딱히 필요는 없었으..
func solution(_ targets:[[Int]]) -> Int {
    var count = 1
    var targets = targets.sorted { lhs, rhs in lhs[0] < rhs[0] }
    var point = targets.removeFirst()
    
    for target in targets {
        // 다음 타겟의 시작점이 현재 구간의 종료점보다 작은가
        if target[0] < point[1] {
            point[0] = max(target[0], point[0])
            point[1] = min(target[1], point[1])
        }
        
        else {
            point = target
            count += 1
        }
    }
    
    return count
}
