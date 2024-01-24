// pg_금과 은 운반하기
// 질문게시판의 도움을 얻어버린 문제,,,
// 최적화 문제를 결정문제로 해결하는 이분탐색 라는 파라메트릭 서치 기법이라고한다.
// 이분탐색을 좀 더 풀어봐야할둣함,,
// 처음에 접근한 방식은 시간순으로 정렬하고 a,b를 계속 빼려고 했었는데
// 이러면 어떤 값을 빼야하는지 고르기가 힘들어서 계속 고민해도 안 나와서 답지를 봐버림ㅎ;
func solution(_ a:Int, _ b:Int, _ g:[Int], _ s:[Int], _ w:[Int], _ t:[Int]) -> Int64 {
    var maxValue = Int.max / 1000
    var minValue = 0
    
    func isPossible(time: Int) -> Bool {
        var total = 0
        var totalG = 0
        var totalS = 0
        
        for i in 0..<g.count {
            
            var cnt = time / (2 * t[i])
            if (time % (2 * t[i]) >= t[i]) { cnt += 1 }

            //해당 시간에 옮길 수 있는 무게
            let tmp = min(cnt * w[i], g[i] + s[i])
            //각 도시의 총합 최대 무게 누적
            total += tmp
            //각 도시의 금 최대 무게 누적
            totalG += min(tmp, g[i])
            //각 도시의 은 최대 무게 누적
            totalS += min(tmp, s[i])
        }

        // 다 더해버렸으니까 아래를 만족해야함
        if (total >= a+b && totalG >= a && totalS >= b) { return true }
        return false
    }
    
    while(minValue + 1 < maxValue) {
        let mid = (minValue + maxValue) / 2
        
        if isPossible(time: mid) { maxValue = mid }
        else { minValue = mid }
    }
    
    return Int64(maxValue)
}
