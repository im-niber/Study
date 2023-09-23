import Foundation

// pg_주차 요금 계산
// 예전에 파이썬으로 풀어본 문제인데 swift로도 한 번 풀어봄
// 타입에 신경을 좀 써야하는 부분에서 조금 시간을 잡아먹었다.
// 문제 자체는 설명한대로 구현해서 풀면 된다. 딕셔너리를 사용해서
// 주차장에 있었던 시간을 전부 더해서 마지막에 계산을하고 정렬해서 리턴함
func solution(_ fees:[Int], _ records:[String]) -> [Int] {
    var result: [(Int, Int)] = []

    let defaultTime = fees[0]
    let defaultMoney = fees[1]
    let perMinute = fees[2]
    let minuteMoney = fees[3]
    
    func changeMinute(time: String) -> String {
        let time = time.split(separator: ":").map { String($0) }
        return String(Int(time[0])! * 60 + Int(time[1])!)
    }

    var carDict: [String: [String]] = [:]

    for item in records {
        let splitedItems = item.split(separator: " ").map { String($0) }
        
        if carDict[splitedItems[1]] != nil {
            carDict[splitedItems[1]]?.append(splitedItems[0])
        }
        else {
            carDict[splitedItems[1]] = [splitedItems[0]]
        }
    }
    
    for (key, value) in carDict {
        var value = value
        var charge = 0
        var totalTime = 0
        
        if value.count % 2 != 0 { value.append("23:59") }
        
        while(!value.isEmpty) {
            let item1 = Int(changeMinute(time: value.removeLast()))!
            let item2 = Int(changeMinute(time: value.removeLast()))!
            
            totalTime += (item1 - item2)
        }
        if totalTime <= defaultTime { charge = defaultMoney }
        else { charge = defaultMoney + Int(ceil(Double(totalTime - defaultTime) / Double(perMinute))) * minuteMoney }
        
        result.append((Int(key)!, charge))
    }

    return result.sorted { $0.0 < $1.0 }.map { $1 }
}
