import Foundation

// pg_마법의 엘리베이터
// 그리디? 라는 느낌을 받았는데 그 동전 거스름돈 마냥
// 거기서 좀 더 구현사항이 더 들어간느낌이여씀
// 반올림 느낌으로하다가 여러 케이스를 돌리다가 5를 만나는 순간이 조금 걸리는게 많아서
// 따로 처리를 해주었더니 통과하여씀.
func solution(_ storey:Int) -> Int {
    var count = 0
    
    var storey = storey
    var nextAdd = false
    
    while storey != 0 {
        var chknum = storey % 10
        
        if nextAdd {
            chknum += 1
            
            if chknum == 10 {
                nextAdd = true
                storey /= 10
                continue
            }
            
            nextAdd = false
        }
        
        if chknum <= 5 {
            storey /= 10
            
            if chknum == 5 && storey % 10 > 5 {
                count += (10 - chknum)
                nextAdd = true
            }
            else { count += chknum }
        }
        
        else {
            nextAdd = true
            count += (10 - chknum)
            storey /= 10
        }
        
    }
    
    return nextAdd ? count + 1 : count
}
