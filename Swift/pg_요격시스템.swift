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
