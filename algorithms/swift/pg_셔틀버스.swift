import Foundation

// pg_셔틀버스
// 구현문제느낌, 시간을 Int로 변환해서 정렬하고
// 배차 시간을 기준으로 반복을 시작해서 timeTable에 시간들을 비교해서
// 태울 크루들을 배열에 넣고 m 카운트라면 마지막 크루 시간에서 -1을 무조건 빼고
// 그게 아니라면 -1을 넣어서 다음 반복을 시작했음
// 마지막 시간이 -1이라면 여유롭게 탈 수 있으므로 배차시간 마지막을 리턴하고
// 그게 아니라면 마지막 시간을 변환해서 리턴함
// lv3라 좀 더 복잡한 무언가가 있을줄 알았는데 그으렇게는 어렵진 않았따~ 
func solution(_ n:Int, _ t:Int, _ m:Int, _ timetable:[String]) -> String {
    var cnt = n
    var lastTime: Int = 0
    
    func dateToInt(_ time: String) -> Int {
        let time = time.split(separator: ":").compactMap { String($0) }
        return Int(time[0])! * 60 + Int(time[1])!
    }
    
    func intToDate(_ time: Int) -> String {
        var hour = String(time / 60)
        var minute = String(time % 60)
        
        if hour.count == 1 { hour.insert("0", at: hour.startIndex) }
        if minute.count == 1 { minute.insert("0", at: minute.startIndex) }
        
        return hour + ":" + minute
    }
    
    var timetable: [Int] = timetable.map { dateToInt($0) }.sorted().reversed()
    
    for time in stride(from: 540, to: 1440, by: t) {
        var crews: [Int] = []
        
        for _ in 0..<m {
            if timetable.count != 0 && timetable[timetable.count - 1] <= time {
                crews.append(timetable.removeLast())
            }
        }
        
        if crews.count == m { lastTime = crews.last! - 1 }
        else { lastTime = -1 }
        
        cnt -= 1
        crews = []
        if cnt == 0 || timetable.isEmpty { break }
    }
    
    if lastTime == -1 { return intToDate(540 + (t * (n - 1))) }
    return intToDate(lastTime)
}
