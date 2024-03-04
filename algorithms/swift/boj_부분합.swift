// boj_부분합
// 그으렇게 어렵진 않은 투 포인터 문제였는데
// 종료 조건을 잘 주지 못해서 오래걸려쓰,, 인덱스에 벗어나지 않게 체크를
// 잘 해줘야한다ㅏ~
func baek() {
    let input = readLine()!.split(separator: " ").compactMap { Int($0) }
    let S = input[1]
    let nums: [Int] = readLine()!.split(separator: " ").compactMap { Int($0) }
    
    var nowSum = 0
    var left = 0
    var right = 0
    
    var minLength = Int.max
    
    while right <= nums.count {
        
        if nowSum < S {
            if right == nums.count { break }
            nowSum += nums[right]
            right += 1
        }
        
        else if nowSum >= S {
            minLength = min(right - left, minLength)
            
            nowSum -= nums[left]
            left += 1
        }
    }
    
    if minLength != Int.max { print(minLength) }
    else { print("0") }
}

baek()
