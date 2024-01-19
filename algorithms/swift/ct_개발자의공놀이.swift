import Foundation

// codetree_ 개발자의 공놀이
// https://www.codetree.ai/training-field/search/problems/developer's-ball-game/description?page=1&pageSize=20&tags=Greedy
// 처음 시도를 이상하게해서 상다ㅏㅏ앙히 오래걸린문제
// 처음 접근으로는 내림차순으로 정렬 후, 맨 앞에서부터 체크를하면서
// 다음으로 못 넘어가는 경우에 반복문을 반대로 돌려서 다시 앞으로 오는식으로 ?
// 하려고 했는데 인덱스가 왔다갔다 거려서 좀 헷갈리기도하고
// 같은 차이일 때 작은 값으로 선택해야하는 경우도 있어서 좀 복잡했다
// 실버2문제였기 때문에 좀 더 쉬운 방법이 있을거 같았고 좀 더 생각해보니
// 좌우로 쭉 가면서 해당 숫자의 가능 범위를 다 담은다음에
// 상위 집합만 정답 집합에 넣으면 되겠다 싶어서 그렇게 구현하여서 풀었다.. 그리디어렵너
func solution() -> Int {
    let _ = readLine()!
    let arr = readLine()!.split(separator: " ").compactMap { Int($0) }
    let sortedArr = arr.sorted(by: >)

    var totalCase: [Set<Int>] = []
    var possibleCase: Set<Int> = []

    var idx = 0
    var beforeLeng = Int.max

    for i in 0..<sortedArr.count - 1 {
        possibleCase.insert(i)
        idx = i
        
        if i != 0 { beforeLeng = sortedArr[idx - 1] - sortedArr[idx] }
        
        while idx != sortedArr.count - 1 && beforeLeng >= sortedArr[idx] - sortedArr[idx + 1]  {
            beforeLeng = sortedArr[idx] - sortedArr[idx + 1]
            possibleCase.insert(idx + 1)
            idx += 1
        }
        totalCase.append(possibleCase)
        possibleCase.removeAll()
    }

    possibleCase.removeAll()
    beforeLeng = Int.max

    for i in stride(from: sortedArr.count - 1, to: 0, by: -1) {
        possibleCase.insert(i)
        idx = i
        
        if i != sortedArr.count - 1 { beforeLeng = sortedArr[idx] - sortedArr[idx + 1] }
        
        while idx != 0 && beforeLeng > sortedArr[idx - 1] - sortedArr[idx]  {
            beforeLeng = sortedArr[idx - 1] - sortedArr[idx]
            possibleCase.insert(idx - 1)
            idx -= 1
        }
        totalCase.append(possibleCase)
        possibleCase.removeAll()
    }

    var answerCases: Set<Set<Int>> = []

    for i in 0..<totalCase.count {
        var superSet: Set<Int> = totalCase[i]
        
        for k in 0..<totalCase.count {
            if superSet.isSuperset(of: totalCase[k]) { continue }
            
            else if totalCase[k].isSuperset(of: superSet) {
                superSet = totalCase[k]
            }
        }
        
        answerCases.insert(superSet)
    }

    print(answerCases.count)
    
    return answerCases.count
}
