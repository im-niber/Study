import Foundation

// pg_조이스틱
// 좀 많이 오래걸린문제.. 단순히 0번 인덱스에서 최소로 움직여서
// 문자 바꾸고를 반복하는식으로 풀면 안되고 적절히 어느 위치로 갈지를 정해야한다
// 왼쪽 오른쪽 한칸씩 움직인 경우 2가지로 나누어서 풀어야겠다고 생각을했고
// 그 다음부터는 이제 해당 위치에서 최소로 움직여서 바꿀 수 있는 문자를 찾으믄된다
// 0번 인덱스가 아닌 다른 인덱스에서는 그리디 기법인거가튼? 문제였다 ~
func solution(_ name:String) -> Int {
    let nameArr = Array(name); let first = Int(nameArr[0].asciiValue!)
    var tempStringLeft: [String.Element] = Array(repeating: "A", count: name.count)
    var tempStringRight: [String.Element] = Array(repeating: "A", count: name.count)
    
    var ansLeft = (min(abs(first - 65), abs(91 - first))), ansRight = ansLeft;
    tempStringLeft[0] = nameArr[0]; tempStringRight[0] = nameArr[0];
    
    if tempStringLeft == nameArr || tempStringRight == nameArr { return ansLeft }
    else { ansLeft += 1; ansRight += 1; }
    
    var left = name.count - 1, right = 1;
    
    func findIndex(_ idx: Int, arr: [String.Element]) -> (idx: Int, cnt: Int) {
        var returnIdx = 0, cnt = 0;
        var left = idx, right = idx;
        
        while(arr != nameArr) {
            left -= 1; right += 1;
            cnt += 1;
            
            if left == -1 { left = arr.count - 1 }
            if right == arr.count { right = 0; }
            
            if arr[left] != nameArr[left] { returnIdx = left; break }
            if arr[right] != nameArr[right] { returnIdx = right; break }
            
        }
        
        return (returnIdx, cnt)
    }
    
    while(tempStringLeft != nameArr || tempStringRight != nameArr) {
        let templeftChar: Int = Int(tempStringLeft[left].asciiValue!)
        let tempRightChar: Int = Int(tempStringRight[right].asciiValue!)
        
        let leftChar: Int = Int(nameArr[left].asciiValue!)
        let rightChar: Int = Int(nameArr[right].asciiValue!)
        
        ansLeft += (min(abs(leftChar - templeftChar), abs(91 - leftChar)))
        ansRight += (min(abs(rightChar - tempRightChar), abs(91 - rightChar)))
        
        tempStringLeft[left] = nameArr[left]
        tempStringRight[right] = nameArr[right]
        
        let lefts = findIndex(left, arr: tempStringLeft)
        let rights = findIndex(right, arr: tempStringRight)
        
        left = lefts.idx; ansLeft += lefts.cnt
        right = rights.idx; ansRight += rights.cnt
    }
    
    return min(ansLeft, ansRight)
}
