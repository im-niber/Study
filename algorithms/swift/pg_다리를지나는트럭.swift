import Foundation

// pg_다리를 지나는 트럭
// 좀 효율적인 풀이를 생각하다가 오래걸렸으,,
// 시간을 늘리면서 했으면 좀 빠르게 풀었을거 같은데
// 트럭이 다리에 올라가는 시점으로 시간을 저장해주고
// remove하거나 트럭을 append할때 시간을 비교해서 최신시간으로 업데이트해줌
// 마지막에 들어간 트럭의 시작시간 + length를 리턴해주믄 정답이된다
func solution(_ bridge_length:Int, _ weight:Int, _ truck_weights:[Int]) -> Int {
    var queue: [(Int, Int)] = []
    var nowWeight = weight
    var nowTime = 0
    
    for item in truck_weights {
        if nowWeight >= item && queue.count < bridge_length {
            nowTime += 1
            queue.append((item, nowTime))
            nowWeight -= item
            
            if nowTime >= queue.first!.1 + bridge_length {
                let (weight, _) = queue.removeFirst()
                nowWeight += weight
            }
        }
        
        else {
            while(!queue.isEmpty) {
                let (weight, time) = queue.removeFirst()
                nowWeight += weight
                nowTime = bridge_length + time
                
                if nowWeight >= item {
                    queue.append((item, nowTime))
                    nowWeight -= item
                    break;
                }
            }
        }
    }
    
    return queue.last!.1 + bridge_length
}
