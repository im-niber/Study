import Foundation

// pg_단어 변환
// lv3 문제라서 좀 어려운 문제겠구나 하고 풀이를 시도해서
// 좀 복잡해짐.. 다른 풀이보니 그냥 BFS, DFS 사용하고 방문처리만 해주면 잘 풀리더라
// 최악의 경우 효율성 통과가 안되나 ? 싶어서 begin 에서 내려가고 target에서 올라가는 방식으로
// 구현을 함. 만약 begin 단계에서 만난 단어가 target 단계에서 카운트 체크가 되면 그게 정답이므로
// 해당 단어를 만나면 break해줘서 풀었다. 이렇게하면 10 제곱이 나오는 풀이도 5제곱으로 줄어든다고
// 생각했는데 굳이 이럴 필요도 없어서 조금 아쉬운 느낌..
func solution(_ begin:String, _ target:String, _ words:[String]) -> Int {
    var words = words; words.append(begin)
    var midWord = ""
    
    if !words.contains(target) { return 0 }
    
    var beginWordCounts: [String: Int] = [:]
    var targetWordCounts: [String: Int] = [:]

    var wordDict: [String: [String]] = [:]
    
    for item in words { beginWordCounts[item] = 0; targetWordCounts[item] = 0; }
    
    for i in 0..<words.count {
        for k in i + 1..<words.count {
            var cnt = 0
            for (c1, c2) in zip(words[i], words[k]) {
                if c1 != c2 { cnt += 1 }
            }
            if cnt == 1 {
                wordDict[words[i], default: []].append(words[k])
                wordDict[words[k], default: []].append(words[i])
            }
        }
    }
    
    var visited: [String: Bool] = [:]
    for item in words { visited[item] = false }
    
    var beginArr = [(begin, 0)]
    var targetArr = [(target, 0)]
    
    while !beginArr.isEmpty || !targetArr.isEmpty {
        let (beginNext, beginCnt) = beginArr.removeFirst()
        let (targetNext, targetCnt) = targetArr.removeFirst()
        
        if !visited[beginNext]! {
            for item in wordDict[beginNext]! {
                beginArr.append((item, beginCnt + 1))
                beginWordCounts[item] = beginCnt + 1
            }
        }
        
        if !visited[targetNext]! {
            for item in wordDict[targetNext]! {
                targetArr.append((item, targetCnt + 1))
                targetWordCounts[item] = targetCnt + 1
            }
        }
        
        if targetWordCounts[beginNext] != 0 { midWord = beginNext; break }
        if beginWordCounts[targetNext] != 0 { midWord = targetNext; break }
        
        visited[beginNext] = true
        visited[targetNext] = true
    }
    
    return beginWordCounts[midWord]! + targetWordCounts[midWord]!
}
