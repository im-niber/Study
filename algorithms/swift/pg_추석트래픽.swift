import Foundation

// pg_추석 트래픽
// 빠르게 풀이방법을 알았다고 생각했는데 좀 오래 걸린문제
// 처음 시도한 코드는 아래에 있슴니다
// 처음 시도한 방식으로는 반복을 하면서 들어오는 로그의 종료시간을 기준으로 다음 로그가
// 1초 안에 해결이 되는지를 판별해서 배열안에 넣어준다음
// 해결이 안되는 경우에는 지금 기준을 바꿔야 하니까 0번 인덱스에 있떤 처음 로그의 종료시간을 빼주고
// 기준 시간을 새로운 0번 인덱스의 로그로 바꿔 주고 다시 반복을 실행했슴니다.
// 그렇게해서 제출하니 2개 빼고 다 맞길래 아 범위 계산에서 틀리거나 소수점 문제겠다 라고 좁게 생각해서
// 이 부분을 dateFormater, Int 여러 방식으로 해결해보려다가 삽질을 너무했다,,

// 놓치고 있던 부분은 만약 새로운 로그가 들어오고 만족하지 못하면 기준시간을 바꿔주고 다시 반복했는데
// 이러면 안되고 해당 기준시간에서 모든 로그들을 판별해야 했다... 종료시간이 늦어도 시작시간이 빠른 경우
// 1초안에 처리가 되는 로그도 있기 때문이다,, 시작시간으로 정렬을 했다면 모를까
// 종료시간으로 정렬되어있는 lines 배열에서는 n^2으로 전체 순회를 했어야함,,
// 시작 시간도 들고있었다면 위의 방식으로 해도 괜찮았을듯

func solution(_ lines:[String]) -> Int {
    var ans = 1
    var doubleLines: [(Double, Double)] = []
    
    for item in lines {
        var splitedItems = item.split(separator: " ").map { String($0) }
        let strTime = splitedItems[1].split(separator: ":").map { Double($0)! }
        splitedItems[2].removeLast()
        
        let time = ((strTime[0] * 60.0 * 60.0) + (strTime[1] * 60.0) + strTime[2]) * 1000.0
        let val = Double(splitedItems[2])! * 1000.0
        
        doubleLines.append((time, val))
    }
    
    var nowTime = 0.0

    for i in 0..<lines.count {
        let (time, val) = doubleLines[i]
        var temp = 1
        nowTime = time
        
        for k in i + 1..<lines.count {
            let (logTime, val) = doubleLines[k]
            let logStart = (logTime - val) + 1.0
            
            if logStart < nowTime + 1000 && nowTime <= logTime {
                temp += 1
            }
        }
        
        ans = max(temp,ans)
    }
    
    return ans
}

// 3,18 case x
func solution(_ lines:[String]) -> Int {
    var ans = 1
    var arr: [String] = []
    
    var nowTime = 0
    
    func strToDouble(_ item: String) -> (Int, Int) {
        var splitedItems = item.split(separator: " ").map { String($0) }
        let strTime = splitedItems[1].split(separator: ":").map { Double($0)! }
        splitedItems[2].removeLast()
        
        let time = ((strTime[0] * 60.0 * 60.0) + (strTime[1] * 60.0) + strTime[2]) * 1000.0
        let val = Double(splitedItems[2])! * 1000.0
        
        return (Int(time), Int(val))
    }
    
    for item in lines {
        let (time, val) = strToDouble(item)
        ans = max(arr.count, ans)
        
        if arr.isEmpty {
            arr.append(item)
            nowTime = time
            continue
        }
        
        else {
            while !arr.isEmpty {
                let logStart = (time - val) + 1
                let logEnd = time
                
                if logStart < nowTime + 1000 && nowTime <= logEnd {
                    arr.append(item)
                    break
                }
                
                else {
                    arr.removeFirst()
                    
                    if arr.isEmpty {
                        arr.append(item)
                        (nowTime, _) = strToDouble(arr[0])
                        break
                    }
                    
                    (nowTime, _) = strToDouble(arr[0])
                }
            }
        }
    }
    
    ans = max(arr.count, ans)
    return ans
}
