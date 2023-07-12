import Foundation

// pg_이모티콘 할인행사
// 중복순열을 만드는 함수를 만들어서 해결한 문제
// 중복순열을 만드는 다른 좋은 예시를 찾아봐야 할 둣
func solution(_ users:[[Int]], _ emoticons:[Int]) -> [Int] {
    var result: [Int] = [0, 0]
    var cases: [[Int]] = []
    
    func permutation(arr: [Int], r: Int, _ temp: inout [Int]) {
        if temp.count == r {
            cases.append(temp)
            while(true) {
                if temp.last != arr.last {
                    temp.popLast()
                    break
                }
                else { temp.popLast() }
            }
            return
        }
        else {
            for i in 0..<arr.count {
                temp.append(arr[i])
                permutation(arr: arr, r: r, &temp)
            }
        }
    
    }
    
    var temp: [Int] = []
    permutation(arr: [10,20,30,40], r: emoticons.count, &temp)
    
    for disCount in cases {
        var tuple: [(Int,Int)] = []
        var resultTuple = (0, 0)
        
        for i in 0..<emoticons.count {
            tuple.append((disCount[i], emoticons[i] - (emoticons[i] * disCount[i] / 100)))
        }
        for user in users {
            var count = 0
            for item in tuple {
                if user[0] <= item.0 {
                    count += item.1
                }
            }
            if count >= user[1] {
                resultTuple.0 += 1
            }
            else { resultTuple.1 += count }
        }
        
        if result[0] < resultTuple.0 {
            result[0] = resultTuple.0
            result[1] = resultTuple.1
        }
        else if result[0] == resultTuple.0 && result[1] < resultTuple.1 {
            result[1] = resultTuple.1
        }
    }
    
    return result
}
