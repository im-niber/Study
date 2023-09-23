import Foundation

// lv3 치고는 쉬웠던 문제
// 기지국을 설치해야 하는 구간을 정해서 그 부분에서 몫과 나머지 연산만 해주면 된다.

func solution(_ n:Int, _ stations:[Int], _ w:Int) -> Int {
    var answer = 0

    var range = 0 // 기지국 설치해야하는 구간을 담을 range
    var coverge = 2 * w + 1 // w가 커버 가능한 범위
    var postIndex = 1 // 기지국이 설치 안 된 시작 장소
    
    func divideAndMod(_ range: Int) {
        var quotient = range / coverge
        
        if range % coverge != 0 {
            answer += 1
        }
        else if quotient == 0 { answer += 1 }
        answer += quotient
    }
    
    for item in stations {
        if postIndex > n { break }
        
        if item == postIndex {
            postIndex = item + w + 1
            continue
        }
        
        range = item - w - postIndex
        
        if range <= 0 {
            postIndex = item + w + 1
            continue
        }
        
        divideAndMod(range)
        postIndex = item + w + 1
    }
    
    if postIndex <= n {
        if postIndex == 1 { divideAndMod(n) }
        else { divideAndMod(n - postIndex) }
    }
    
    return answer
}

print(solution(11, [4, 11], 1))
print(solution(16, [9], 2))
