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
