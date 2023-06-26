import Foundation

// 데이터가 크지 않아서 반복문을 엄청 돌려서 겨우 해결한 문제 ㅜㅡㅜ
// 문제 조건에 맞는 idx를 저장해서 겹치는 부분들을 제외하여 count를 세면 답이나온다

func solution(_ relation:[[String]]) -> Int {
    var maxCount = relation[0].count
    var idxSet: Set<Set<Int>> = []
    var answer = 0

    func search(relation: [[String]], idx: Int, item: Set<Int>) {
        if idx == maxCount { return }
        var item = item
        item.insert(idx)
        
        var str: String = ""
        var strs: [[String]] = []
        var duplicateStrs: Set<[String]> = []
        var isUnique = true
        
        for i in 0..<relation.count {
            for k in 0..<relation.count {
                for j in item {
                    str = relation[i][j]
                    if relation[k][j] != str {
                        isUnique = false
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
            answer += 1
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
    
    for item in idxSet {
        var flag = true
        for item2 in idxSet {
            if item.isStrictSuperset(of: item2) {
                flag = false
            }
        }
        if flag { answerSet.insert(item) }
    }
    return answer
}
