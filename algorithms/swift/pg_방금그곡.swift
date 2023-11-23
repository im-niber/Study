import Foundation

// 방금 그 곡
// 문자열에 나의 문자열이 있는가 ? 문제 이다.
// 그래서 문자 처리를 잘 해주고 index처리도 조금 해줘야했음
// #이 있다면 다 붙여서 새로운 문자열 배열로 만들어줬고
// index 처리에서 멜로디가 다시 재생되므로 0으로 가는 경우를 추가해줬다
// 마지막에는 전체 반복으로 해당하는 멜로디가 있는지 체크해주어씀
func solution(_ m: String, _ musicinfos: [String]) -> String {
    var music = ""
    var tempTime = 0
    
    let musicinfos = musicinfos.map { $0.components(separatedBy: ",") }
    
    func stringTodateValue(str: String) -> Int {
        let str = str.components(separatedBy: ":")
        let (hour, min) = (str[0], str[1])
        return Int(hour)! * 60 + Int(min)!
    }
    
    func convertStringToArray(str: String) -> [String] {
        var strArr: [String] = []
        
        for i in 0..<str.count {
            var item = String(str[str.index(str.startIndex, offsetBy: i)])
            if item == "#" { continue }
            
            if i < str.count - 1 {
                let plus = String(str[str.index(str.startIndex, offsetBy: i + 1)])
                
                if plus == "#" {
                    item += plus
                }
            }
            strArr.append(item)
        }
        
        return strArr
    }
    
    let m = convertStringToArray(str: m)
    
    for item in musicinfos {
        var runningTime = stringTodateValue(str: item[1]) - stringTodateValue(str: item[0])
        let totalTime = runningTime
        let melody = convertStringToArray(str: item[3])
        
        var runningMelody: [String] = []
        var i = 0
        
        while(runningTime > 0) {
            runningMelody.append(melody[i])
            if i != melody.count - 1 { i += 1 }
            else { i = 0 }
            runningTime -= 1
        }
        
        for i in 0..<runningMelody.count {
            if i <= runningMelody.count - m.count {
                if Array(runningMelody[i..<i + m.count]) == m {
                    if tempTime < totalTime {
                        music = item[2]
                        tempTime = totalTime
                    }
                }
            }
        }
    }
    return music.count == 0 ? "(None)" : music
}
