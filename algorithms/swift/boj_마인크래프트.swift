// boj_마인크래프트
// 좀 걸린문제ㅔㅔ
// 블럭을 쌓거나 빼야할때 다른쪽에서 들고 와야하나 싶어서
// 인벤토리에 몇개 넣고 해당 갯수에 맞게 시간을 따로 빼주는 처리를
// 하려고 시도했다가 굳이 그럴 필요가 없다는걸 깨달음;
// 결국 다 순회하면 해결되는 부분이라서 ... 시간만 더 쓴듯하다 ~
func baek() {
    let input = readLine()!.split(separator: " ").compactMap { Int($0) }
    let N = input[0]; let M = input[1]; let B = input[2]
    var maps: [[Int]] = []
    
    var time = Int.max
    var height = 0
    
    var totalBlock = B
    
    var maxValue = 0
    
    for _ in 0..<N {
        let line = readLine()!.split(separator: " ").compactMap { Int($0) }
        maps.append(line)
        totalBlock += line.reduce(0, +)
        maxValue = max(line.max()!, maxValue)
    }
    
    for h in stride(from: maxValue, through: 0, by: -1) {
        
        if totalBlock < h * N * M { continue }
        
        var newTime = 0
        var cnt = 0
        
        for i in 0..<N {
            for j in 0..<M {
                let diff = abs(h - maps[i][j])
                
                if maps[i][j] == h { continue }
                
                if maps[i][j] < h {
                    
                    newTime += (diff * 1)
                }

                else {
                    newTime += (diff * 2)
                }
            }
        }
        
        if time >= newTime {
            
            if time == newTime {
                if h > height {
                    time = newTime
                    height = h
                }
            }
            
            else {
                time = newTime
                height = h
            }
        }
    }
    
    print(time, height)
}
baek()
