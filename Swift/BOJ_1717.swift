// BOJ 1717 - 집합의 표현
// 꽤 오래 걸렸다,, enum으로 연결리스트를 만들어서 해보려고 하다가 시간초과 뜨고 ~
// 클래스로도 시도했다가 시간초과 뜨고 ~
// 결국 배열을 사용하여 해결하였다,,,
// 그리고 find 함수가 while문은 68%에서 시간초과로 통과가 안되는데
// 재귀함수로 풀이를 바꾸면 통과가 되어서 의문이다 while문이 더 빠르지 않나..? 어려웠다 ~
import Foundation

// 옵셔널 Bye
func optionalBye() -> [Int] {
    guard let input = readLine() else { return [] }
    let inputArray: [String] = input.components(separatedBy: " ")
    let intInputArray = inputArray.compactMap { Int($0) }

    return intInputArray
}

// 입력을 받는 함수
let inputArray: [Int] = optionalBye()

// 집합과 연산의 개수를 입력받음
let N = inputArray[0]
let M = inputArray[1]

var parent: [Int] = []

for i in 0...N {
    parent.append(i)
}

for _ in 0..<M {
    let cases = optionalBye()
    
    if cases[0] == 0 {
        union(l: cases[1], r: cases[2])
    }
    
    else {
        let lValue = find(cases[1])
        let rValue = find(cases[2])
        
        if lValue == rValue { print("yes") }
        else { print("no") }
    }
}

func union(l: Int, r: Int) {
    let lvalue = find(l)
    let rvalue = find(r)
    
    if lvalue > rvalue {
        parent[lvalue] = rvalue
    }
    
    else if lvalue < rvalue {
        parent[rvalue] = lvalue
    }

    return
}

// 최상위 노드를 찾는 함수
func find(_ val: Int) -> Int {
    if val == parent[val] {
       return val
   } else {
       parent[val] = findParent(parent[val])
       
       return parent[val]
   }
}
