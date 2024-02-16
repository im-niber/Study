import Foundation

// pg_베스트앨범
// 요 문제도 LV3라서 어렵겠구나 싶었는데 막상 풀면
// 크게 어려운게 없어서 좀 당황함 요정도는 LV2가 맞지 않나 싶은데
// 플그 난이도 기준을 모르겠넹
// 어떤 카테고리에서 1개 또는 2개를 골라서 인덱스를 배열에 넣고 반환해야함니다
// 그래서 초기작업을 좀 진행하고 카테고리가 최대 99개라 시초는 안 나겠다 싶어서
// 쌐다 구현으로 풀었슴니다. 데이터를 다루기 쉽게 튜플로 만들어서 그걸로 정렬하고 비교해씀니다.
func solution(_ genres:[String], _ plays:[Int]) -> [Int] {
    var dict: [String: Int] = [:]
    
    for (i, item) in genres.enumerated() {
        dict[item, default: 0] += plays[i]
    }
    var playsAllInfo: [(Int, Int, String)] = []
    
    for i in 0..<plays.count { playsAllInfo.append((plays[i], i, genres[i])) }
    
    playsAllInfo = playsAllInfo.sorted { lhs, rhs in
        if lhs.0 == rhs.0 { return lhs.1 < rhs.1 }
        return lhs.0 > rhs.0
    }
    
    var cnt = 0
    var ans: [Int] = []
    
    for genre in dict.sorted(by: { lhs, rhs in
        lhs.value > rhs.value
    }) {
        cnt = 0
        for item in playsAllInfo {
            if item.2 == genre.key {
                ans.append(item.1)
                cnt += 1
            }
            
            if cnt == 2 { break }
        }
    }
    
    return ans
}

// 매우 깔-끔해서 들고와씀니다
func solution(_ genres:[String], _ plays:[Int]) -> [Int] {
    let dict = genres.enumerated().reduce(into: [String: [[Int]]]()) {
        let (index, genre) = $1
        print($1)
        $0[genre, default: []] += [[index, plays[index]]]
    }
    
    return Array(dict.values)
        .sorted {
            ($0.reduce(0) { $0 + $1[1] }) > ($1.reduce(0) { $0 + $1[1] })
        }
        .flatMap {
            $0.sorted { $0[1] > $1[1] }.map { $0[0] }.prefix(2)
        }
}
