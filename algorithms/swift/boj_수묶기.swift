import Foundation

// boj_수 묶기
// 어떤 두 수를 묶고 머 계산하느데 최댓값을 구해야함
// 같은 위치를 묶는건 x
// 묶은 수는 서로 곱한 후에 더함 ex. 1 ( 23 ) ( 45 ) ==> 27 ?
// -1 1 2 3 --> 3* 2 + 1 + -1 묶거나, 묶지 않아야함.

// 먼저 그냥 다 하나의 배열에 넣고 내림차순으로 정렬 후
// 곱한거랑 더한거 차이가 크면 묶어서 넣어줬는데
// 당연히 마이너스 부분이틀렸고
// 그래서 마이너스랑 0을 포함하는 배열과 양수 배열을 나눠서
// 동일 로직을 수행하니까 통과했다 ~
func baek() {
    let N = Int(readLine()!)!
    
    var arr: [Int] = []
    var minusArr: [Int] = []
    
    for _ in 0..<N {
        let input = Int(readLine()!)!
        input > 0 ? arr.append(input) : minusArr.append(input)
    }
    
    arr = arr.sorted(by: >)
    minusArr = minusArr.sorted(by: <)
    
    var sumArr: [Int] = []
    
    var isNext = false
    
    for i in 0..<arr.count {
        if isNext { isNext = false; continue }
        
        if i != arr.count - 1 && arr[i] * arr[i + 1] > arr[i] + arr[i + 1] {
            sumArr.append(arr[i] * arr[i + 1])
            isNext = true
        }
        else {
            sumArr.append(arr[i])
        }
    }
    isNext = false
    
    for i in 0..<minusArr.count {
        if isNext { isNext = false; continue }
        
        if i != minusArr.count - 1 && minusArr[i] * minusArr[i + 1] > minusArr[i] + minusArr[i + 1] {
            sumArr.append(minusArr[i] * minusArr[i + 1])
            isNext = true
        }
        else {
            sumArr.append(minusArr[i])
        }
    }
    
    print(sumArr.reduce(0, +), "answer")
}
