import Foundation

func solution(_ relation:[[String]]) -> Int {
    var maxCount = relation[0].count
    var idxSet: Set<Set<Int>> = []

    func search(relation: [[String]], idx: Int, item: Set<Int>) {
        if idx == maxCount { return }
        var item = item
        item.insert(idx)
        
        var str: String = ""
        var strs: [[String]] = []
        var duplicateStrs: Set<[String]> = []
        var isUnique = true
        
        // i 는 배열의 비교값을 얻기 위한 용도
        // k 는 i에서 나온 값을 남은 배열을 순회하기
        // j 는 비교할 값의 묶음 ex. 1,2 라면 1번 인덱스, 2번 인덱스가 같이 존재해야
        // 값을 strs에 대입한다
        for i in 0..<relation.count {
            for k in 0..<relation.count {
                for j in item {
                    str = relation[i][j]
                    if relation[k][j] != str {
                        isUnique = false
                        break
                    }
                }
                if isUnique { strs.append(relation[k]) }
                isUnique = true
            }
            
            if strs.count != 1 {
                for item in strs {
                    duplicateStrs.insert(item)
                }
            }
            strs = []
        }
        
        if duplicateStrs.count == 0 {
            idxSet.insert(item)
            return
        }
        
        for i in idx + 1..<relation[0].count {
            search(relation: Array(duplicateStrs), idx: i, item: item)
        }
    }

    for i in 0..<relation[0].count {
        search(relation: relation, idx: i, item: [])
    }
    
    var answerSet: Set<Set<Int>> = []
    // 최소성을 고려안한 집합을 처리하는 부분
    // 집합요소를 하나 꺼내서 상위 집합이면 해당 인덱스집합은 최소성 규칙에 어긋나므로
    // flag = false 를 두고 answer에서 제외
    for item in idxSet {
        var flag = true
        for item2 in idxSet {
            if item.isStrictSuperset(of: item2) {
                flag = false
                break
            }
        }
        if flag { answerSet.insert(item) }
    }
    return answerSet.count
}

// 새로 풀어본 방식, 스터디에서 다시 풀 일이 생겨서 다시 풀어봄
// 이번에는 모든 케이스를 배열에 담고 해당 케이스들로 비교를 시작함
// 예를 들어 이름, 학번의 경우를 비교해야하면 이름과 학번의 String을 더해서
// Set에 넣고, 마지막으로 해당 count가 relation의 개수만큼 나오는거로 유일성을 판단해씀
// 마지막에는 가능한 경우들의 집합의 원소를 꺼내서 나머지 원소들의 상위집합인지
// 비교하여 최소성을 검증하여씀
func solution(_ relation:[[String]]) -> Int {
    var maxCount = relation[0].count
    var cases: [[Int]] = []
    var possibleCases: Set<Set<Int>> = []
    
    func allCase(_ arr: [Int], idx: Int) {
        if arr.count == maxCount { return }
        
        cases.append(arr)
        for i in idx..<maxCount {
            allCase(arr + [i], idx: i + 1)
        }
    }
    allCase([], idx: 0)
    cases.append(Array(0..<maxCount))
    
    for `case` in cases {
        var tempSet: Set<String> = []
        
        for row in relation {
            var tempStr: String = ""
            for item in `case` {
                tempStr += row[item]
            }
            tempSet.insert(tempStr)
        }
        if tempSet.count == relation.count { possibleCases.insert(Set(`case`)) }
    }
    var ans = possibleCases.count
    
    for item in possibleCases {
        for item2 in possibleCases {
            if item.isStrictSuperset(of: item2) { ans -= 1; break }
        }
    }
    return ans
}
