import Foundation

// pg_귤고르기
// 최대값까지 배열을 만들고 해당 값의 개수와 인덱스를 담아서 만들어줌
// 만들어준걸 내림차순으로 정렬해서 앞에서부터 더해서 조건을 체크해서 반환하면된다
func solution(_ k:Int, _ tangerine:[Int]) -> Int {
    var maxValue = tangerine.max()!
    var countArray = Array(repeating: (idx: 0, value: 0), count: maxValue + 1)
    
    var category = 0
    var count = 0
    
    for item in tangerine {
        countArray[item].idx = item
        countArray[item].value += 1
    }
    
    countArray.sort{ $0.1 > $1.1 }
    
    for (_, value) in countArray {
        category += 1
        count += value
        if count >= k { break }
    }
    
    return category
}
