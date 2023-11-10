import Foundation

// pg_호텔 대실
// 이중반복문으로 풀었슴니다. 더 좋은 풀이가 있는지는 잘 모르겠는디
// 먼저 생각한건 입실시간으로 정렬을 해두는게 좋을거 같았고
// 현재 사용중인 방을 배열로 만들고, 퇴실시간을 배열에 담았슴니다.
// 그렇게해서 다음 반복에 들어오는 예약 입실시간과 배열을순회하면서 퇴실시간들을 비교하고
// 조건에 맞으면 바꿔주고 카운트하지않고, 비교해도 맞는 방이 없다면
// 새로운 방을 추가해줌니다. 추가해줄때만 ans += 1 해주믄댐니다.
func solution(_ book_time:[[String]]) -> Int {
    var ans = 0
    
    func convertTime(_ time: String) -> Int {
        let time = time.components(separatedBy: ":")
        return Int(time[0])! * 60 + Int(time[1])!
    }
    
    let book_time = book_time.sorted { lhs, rhs in
        convertTime(lhs[0]) < convertTime(rhs[0])
    }
    var rooms: [String] = []
    for time in book_time {
        var flag = false
        for i in 0..<rooms.count {
            if convertTime(rooms[i]) + 10 <= convertTime(time[0]) {
                rooms[i] = time[1]
                flag = true
                break
            }
        }
        
        if flag { continue }
        else {
            rooms.append(time[1])
            ans += 1
        }
    }
    
    return ans
}
