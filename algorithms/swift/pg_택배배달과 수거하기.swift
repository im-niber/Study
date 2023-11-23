import Foundation

// pg_택배 배달과 수거하기
// 맨 뒤에 있는 집부터 배달해야 겠다라고 생각을 했고
// 배달과정이랑 수거 과정을 나눠서 풀었는데
// 굳이 안 그래도 해결이 되는 문제였으..
// 결국 배달을 하는 집이던 수거를 하던 집이던 끝까지 가면
// 거기서 두 가지 작업을 다 할 수 있기 때문임
// 그리고 해당 capcity를 만족하는 값이 들어오면 그 때 답을 더하면 되기도해서
// 반복을 많이 줄일 수도 있다. 해당 풀이는 아래 solution2
func solution(_ cap:Int, _ n:Int, _ deliveries:[Int], _ pickups:[Int]) -> Int64 {
    var deliveries = deliveries
    var pickups = pickups
    
    var totalLength: Int64 = 0
    
    var deliverIndex = 0
    var pickupIndex = 0
    
    for i in stride(from: n - 1, through: 0, by: -1) {
        if deliveries[i] != 0 { deliverIndex = i; break; }
    }
    
    for i in stride(from: n - 1, through: 0, by: -1) {
        if pickups[i] != 0 { pickupIndex = i; break; }
    }
    
    if deliverIndex == 0 && pickupIndex == 0 { return 0 }
    
    while(true) {
        var deliverCap = cap
        var pickupCap = cap
        
        let maxLength = max(deliverIndex, pickupIndex)
        
        for i in stride(from: deliverIndex, through: 0, by: -1) {
            if deliverCap == 0 && deliveries[i] != 0 { break }
            
            if deliveries[i] > deliverCap {
                deliveries[i] -= deliverCap; break;
            }
            
            else if deliveries[i] <= deliverCap {
                deliverCap -= deliveries[i]
                deliveries[i] = 0
                deliverIndex = i - 1
            }
        }
        
        for i in stride(from: pickupIndex, through: 0, by: -1) {
            if pickupCap == 0 && pickups[i] != 0 { break }
            
            if pickups[i] > pickupCap {
                pickups[i] -= pickupCap; break;
            }
            
            else if pickups[i] <= pickupCap {
                pickupCap -= pickups[i]
                pickups[i] = 0
                pickupIndex = i - 1
            }
        }
    
        totalLength += Int64((maxLength + 1) * 2)
        
        if deliverIndex == -1 && pickupIndex == -1 { break }
        
        if deliveries.filter({ $0 != 0 }).isEmpty && pickups.filter({ $0 != 0 }).isEmpty { break }
    }
    
    return totalLength
}

func solution2(_ cap:Int, _ n:Int, _ deliveries:[Int], _ pickups:[Int]) -> Int64 {
    var ans:Int64 = 0

    var d = 0
    var p = 0

    for i in stride(from: n-1, through: 0, by: -1) {
        d += deliveries[i]
        p += pickups[i]
        
        // 배달이나 픽업의 값이 남았다면 결국 다시 들려야하므로
        // 여기서 반복을 해주는 모씁..
        // 또 마이너스가 되더라도 상관이 없다 ~
        while d > 0 || p > 0 {
            d -= cap
            p -= cap
            ans += Int64(( i + 1) * 2)
        }
    }

    return ans
}
