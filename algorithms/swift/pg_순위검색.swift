import Foundation

// pg_순위 검색
// 상당히 오래 걸린문제 이게 lv2라니,,
// 처음에는 데이터를 딕셔너리에 java, cpp, front, ... 원소 키마다 Set<Int>로 idx를 저장하였음
// 그리고 쿼리에 맞게 교집합을 추출해서 최종적인 idxs를 뽑아낸 후에 코테 점수를 마지막에 비교함
// 이러니까 효율성에서 계속 시초가 나서 코테 점수를 비교하는 반복문이 최악의 경우에 10만개니까 좀 힘들거같은 생각을함
// 그래서 이분탐색을 떠올렸고, 처음 정보 테이블을 내림차순으로 정렬하고
// 집합으로 받은 idxs를 다 배열로 바꾸고 내림차순에 맞게 idx를 입력받음
// 딕셔너리 key는 조합으로 모든 케이스를 받았고
// 해당 키에 맞는 idx원소들을 가져온 뒤 이분 탐색으로 점수를 탐색했다
// 이러니까 아슬아슬하게 통과함 조합 + 이분탐색 문제..
func solution(_ info:[String], _ query:[String]) -> [Int] {
    var arr: [Int] = []
    let info = info.map { $0.components(separatedBy: " ") }.sorted { lhs, rhs in
        return Int(lhs.last!)! > Int(rhs.last!)!
    }
    
    var dict: [String: [Int]] = [:]
    var totalIdxs: [Int] = []
    
    func combination(item: [String], idx: Int, temp: String, start: Int) {
        if temp == item[0..<item.count - 1].joined() {
            dict[temp, default: []].append(idx)
            return
        }
        if temp != "" { dict[temp, default: []].append(idx) }
        
        for i in start..<item.count - 1 {
            combination(item: item, idx: idx, temp: temp + item[i], start: i + 1)
        }
    }
    
    for i in 0..<info.count {
        combination(item: info[i], idx: i, temp: "", start: 0)
        totalIdxs.append(i)
    }
    
    // 이분탐색
    func search(val: Int, idxs: [Int]) -> Int {
        var start = 0
        var end = idxs.count - 1
        
        while(start <= end) {
            let mid = (start + end) / 2
            let temp = Int(info[idxs[mid]].last!)!
            
            if temp < val { end = mid - 1 }
            else { start = mid + 1 }
        }
        return end
    }
    
    for q in query {
        var q = q.components(separatedBy: " ").filter { $0 != "and" }.filter { $0 != "-" }
        let val = Int(q.removeLast())!
        let str = q.joined()
        
        var idxs: [Int] = []
        
        if str == "" { idxs = totalIdxs }
        else { idxs = dict[str] ?? [] }
        
        let searchedIdx = search(val: val, idxs: idxs)
        arr.append(searchedIdx + 1)
    }
    
    return arr
}
