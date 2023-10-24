import Foundation

// pg_메뉴리뉴얼
// 예ㅔㅔㅔ전에 파이썬으로 풀었었는데 swift로 다시 풀어봄
// 조합을 사용했었는데 쓰지 않고 해보려다가 안되겠어서 결국 써버림
// 그래도 배열을 순회하여 같은 원소들의 배열을 리턴하고
// 해당 배열에서 조합의 경우를 세었기 때문에 반복이 많이 줄었을듯함
// 나머진 딕셔너리를 사용해 count로 비교를해주었따
func solution(_ orders:[String], _ course:[Int]) -> [String] {
    var ans: [String] = []
    let orders = orders.map { Array($0) }
    var dictCourses: [String : Int] = [:]
    
    func combination(_ arr: [String.Element], target: [String.Element], idx: Int) {
        if target.count == arr.count {
            if course.contains(arr.count) {
                dictCourses[String(arr), default: 0] += 1
            }
            return
        }
        
        if course.contains(target.count) {
            dictCourses[String(target), default: 0] += 1
        }
        
        for i in idx..<arr.count {
            combination(arr, target: target + [arr[i]], idx: i + 1)
        }
    }
    
    for i in 0..<orders.count {
        for k in i + 1..<orders.count {
            let checkarr = orders[i].filter { orders[k].contains($0) }
            combination(checkarr.sorted(), target: [], idx: 0)
        }
    }

    for i in 0..<course.count {
        let validCourse = dictCourses
            .filter { $0.key.count == course[i] }
            .sorted { $0.value > $1.value }
        
        validCourse
            .forEach {
                if validCourse.first!.value == $0.value {
                    ans.append($0.key)
                }
            }
    }
    
    return ans.sorted()
}
